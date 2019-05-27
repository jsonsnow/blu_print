//
//  WGPrintQueue.swift
//  WeAblum
//
//  Created by chen liang on 2019/5/14.
//  Copyright © 2019 WeAblum. All rights reserved.
//

import Foundation

class WGPrintQueue: NSObject {
    
    enum WGPrintState: String, CustomDebugStringConvertible {
        
        var debugDescription: String {
            return "------------self cur state is \(self.rawValue)"
        }
        
        case coverOpen = "coverOpen"
        case noPaper = "noPaper"
        case overHeat = "overHeat"
        case batteryLow = "batteryLow"
        case printing = "printing"
        case ok = "ok"
        case other = "other"
    }
    
    typealias WGPrintStatusCallback = (_ state: String, _ curPage: Int, _ totalPage: Int, _ identifier: String) -> ()
    private var curPage: Int = 0
    private var totalPage: Int = 0
    private var printIng: Bool = false
    private var identifiles: [String]?
    private var datas: [Data]?
    private var queryData: Data?
    private var pauseOperation: PrintStatusProtocol?
    private var type: String = "tspl"
    @objc static let printQueue: WGPrintQueue =  WGPrintQueue.init()
    
    private override init() {
        super.init()
    }
    
    ///目前业务不拆分
    @objc func printDatas(_ datas: [Data],identifiles:[String], callback: @escaping WGPrintStatusCallback, queryData: Data, type: String) -> Void {
        let manager = ConnecterManager.sharedInstance()
        self.printIng = true
        self.totalPage = datas.count
        self.curPage = 0
        self.identifiles = identifiles
        self.datas = datas
        self.type = type
        self.queryData = queryData
        //WGLogBridgFile.logLogStr("[Print]: start print task identifiles:\(identifiles.joined(separator: ","))" + "print type: \(type)")
        for data in datas {
            let oper = WGPrintOperation.init { (opertaion) in
                manager?.write(data, progress: { (total, progress) in
                    if progress == total {
                        //                        // 因为esc收不到打印状态回调，数据发送过去就当打印完成，批量打印服务器拼接模板即可
                        //                        if type == "esc" {
                        //                            opertaion.printFinsh()
                        //                            callback("ok", self.curPage, self.totalPage, self.identifiles?[self.curPage] ?? "")
                        //                            self.printOnePage()
                        //                        } else {
                        //                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                        //                                manager?.write(queryData)
                        //                            })
                        //                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                            manager?.write(queryData)
                        })
                    }
                }, receCallBack: { (res) in
                    let state = self.analyzeByte(res ?? Data())
                    if state == WGPrintState.ok {
                        opertaion.printFinsh()
                        callback(state.rawValue, self.curPage, self.totalPage, self.identifiles?[self.curPage] ?? "")
                        self.printOnePage()
                        print("打印下一页")
                    } else {
                        if state == WGPrintState.printing {
                            manager?.write(queryData)
                            return
                        }
                       // WGLogBridgFile.logLogStr("[Print]:print state error id is\(String(describing: self.identifiles?[self.curPage]))")
                        self.pauseOperation = opertaion
                        callback(state.rawValue, self.curPage, self.totalPage, self.identifiles?[self.curPage] ?? "")
                        print("异常状态")
                    }
                    
                })
            }
            self.operationQueue.addOperation(oper)
        }
    }
    
    
    //MAR: private method
    private func printOnePage() {
        self.syncToService(identitile: self.identifiles?[self.curPage])
        self.curPage = self.curPage + 1
        if self.curPage == self.totalPage {
            self.clear()
        }
    }
    
    private func analyzeByte(_ data: Data) -> WGPrintState {
        var res = 0
        if data.count == 1 {
            res = Int(data.scanValue(at: 0, endianess: .BigEndian) as UInt8)
        } else {
            res = Int(data.scanValue(at: 0, endianess: .BigEndian) as UInt16)
        }
        if self.type == "tspl" {
            let ok = 0xFF
            let noPaper = 0x06
            let print = 0x20
            let error = 0xF0
            let coverOpen = 0x01
            let coverOpen2 = 0x40
            if (res & ok) == 0 {
                return WGPrintState.init(rawValue: "ok")!
            }
            if (res & noPaper) == 2 || (res & noPaper) == 4{
                return WGPrintState.init(rawValue: "noPaper")!
            }
            if (res & coverOpen) == 1 || (res & coverOpen2) == 64 {
                return WGPrintState.init(rawValue: "coverOpen")!
            }
            if (res & print) == 32 {
                return WGPrintState.init(rawValue: "printing")!
            }
            if (res & error) == 128 {
                return WGPrintState.init(rawValue: "other")!
            }
        }
        if self.type == "esc" {
            // 18就认为正确
            let ok = 0x12
            let noPaper = 0x04
            let print = 0x10
            let error = 0xF0
            let coverOpen = 0x01
            let heart = 0x40
            if (res & ok) == ok {
                return WGPrintState.init(rawValue: "ok")!
            }
            if (res & noPaper) == noPaper {
                return WGPrintState.init(rawValue: "noPaper")!
            }
            if (res & coverOpen) == coverOpen  {
                return WGPrintState.init(rawValue: "coverOpen")!
            }
            if (res & heart) == heart {
                return WGPrintState.init(rawValue: "overHeat")!
            }
            if (res & error) == error {
                return WGPrintState.init(rawValue: "other")!
            }
            if (res & print) == print {
                return WGPrintState.init(rawValue: "printing")!
            }
        }
        
        if self.type == "cpcl" {
            let ok = 0xFF
            let noPaper = 0x02
            let print = 0x01
            let error = 0xF0
            let coverOpen = 0x04
            let lowBattery = 0x08
            if (res & ok) == 0 {
                return WGPrintState.init(rawValue: "ok")!
            }
            if (res & noPaper) == noPaper {
                return WGPrintState.init(rawValue: "noPaper")!
            }
            if (res & coverOpen) == coverOpen  {
                return WGPrintState.init(rawValue: "coverOpen")!
            }
            if (res & print) == print {
                return WGPrintState.init(rawValue: "printing")!
            }
            if (res & lowBattery) == lowBattery {
                return WGPrintState.init(rawValue: "batteryLow")!
            }
            if (res & error) == error {
                return WGPrintState.init(rawValue: "other")!
            }
        }
        return WGPrintState.init(rawValue: "other")!
    }
    
    
    
    //MARK:
    @objc func isPrint() -> Bool {
        return self.printIng
    }
    
    @objc func continuePrint() {
        let operations = self.operationQueue.operations
        self.operationQueue.cancelAllOperations()
        self.operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    @objc func canclePrint() {
        self.operationQueue.cancelAllOperations()
        self.clear()
    }
    
    
    /// 清空数据
    @objc func clear() {
        self.curPage = 0
        self.totalPage = 0
        self.queryData = nil
        self.datas = nil
        self.identifiles = nil
        self.printIng = false
        self.pauseOperation = nil
    }
    
    private func syncToService(identitile: String?) {
//        guard let _identi = identitile else { return  }
//        let params = ["deliveryId": _identi,"printState":"ok"]
//        self.apiManager.postUrl(WG_PRINT_STATE_SYSNC, params: params, entiyClass: nil, parserJsonBlock: nil) { (_, data) in
//            if data.isSuccess {
//                WGLogBridgFile.logLogStr("[Print]:print state sysnc succees id is\(_identi)")
//            } else {
//                WGLogBridgFile.logLogStr("[Print]:print state sysnc failed id is\(_identi)" + "\(data.errmsg ?? "")")
//            }
//        }
    }
    
    lazy var operationQueue: OperationQueue = {
        let queue = OperationQueue.init()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
//    lazy var apiManager: WGConnectHelper = {
//        let connect = WGConnectHelper.shareInstance()
//        return connect
//    }()
}

extension Data {
    enum Endianness {
        case BigEndian
        case LittleEndian
    }
    func scanValue<T: FixedWidthInteger>(at index: Data.Index, endianess: Endianness) -> T {
        let number: T = self.subdata(in: index..<index + MemoryLayout<T>.size).withUnsafeBytes({ $0.pointee })
        switch endianess {
        case .BigEndian:
            return number.bigEndian
        case .LittleEndian:
            return number.littleEndian
        }
    }
}


