//
//  WGPrintManager.swift
//  Demo
//
//  Created by chen liang on 2019/5/7.
//  Copyright © 2019 smarnet. All rights reserved.
//

import UIKit

enum WGPrintCommandType: String {
    case TSPL = "tspl"
    case CPCL = "cpcl"
    case ESC = "esc"
    
    func cmd() -> WGBasePrintCommand {
        switch self {
        case .TSPL:
            return WGTSPLPrintCommand()
        case .CPCL:
            return WGCPCLPrintCommand()
        case .ESC:
            return WGESCPrintCommand()
        }
    }
}

enum WGPrintCommandLineType: String {
    case PAGE = "page"
    case LINE = "line"
    case TEXT =  "text"
    case BarCode = "barCode"
    case QR = "qr"
    case IMG = "img"
    case PRINT = "print"
    case LAYOUT = "layout"
    case TABLE = "table"
    case DIRECTION = "direction"
    case FEEDLINE = "feedLine"
    case SPEED = "speed"
    
    func execute(key: String, value: Any?, attri:[String:Any], cmd: WGBasePrintCommand) -> Void {
        switch self {
        case .PAGE:
            cmd.printPage(attri: attri as! [String: String])
        case .LINE:
            cmd.printLine(attri: attri as! [String: String])
        case .TEXT:
            cmd.printText(value as? String, with: attri as! [String: String])
        case .BarCode:
            cmd.printBarCode(data: value as? String ?? "", attri: attri as! [String: String])
        case .QR:
            cmd.printQRCode(data: value as? String ?? "", attri: attri as! [String: String])
        case .IMG:
            cmd.printImg(data: value as? Data ?? Data.init(), attri: attri as! [String: String])
        case .LAYOUT:
            print("print layout")
        //print("layout cmd")
        case .PRINT:
            cmd.blePrint(attri: attri as? [String: String])
        case .TABLE:
            cmd.printTable(attri: attri)
        case .FEEDLINE:
            cmd.feedLine(attri:  attri as? [String: String] ?? [String: String]() )
        case .DIRECTION:
            cmd.printDirection(attri:  attri as? [String: String] ?? [String: String]())
        case .SPEED:
            cmd.printSpeed(attri: attri as? [String: String] ?? [String: String]())
        }
    }
}

class WGPrintDataManager: NSObject {
    
    @objc static let print = WGPrintDataManager.init()
    
    //MARK: init
    private override init() {
        super.init()
    }
    
    //MARK: public method,现在该方法兼容esc获取，可以统一用该方法
    @objc public func getPrintDataWithJson(_ json: [String: Any], xmlAttri:[[String: [String: Any]]]) -> [Data]? {
        let data = json["data"] as? [[String: String]]
        let res = data?.map({ value -> Data  in
            let cmd = self.cmdWithType(json["type"] as? String ?? "")
            //遍历每个命令行
            xmlAttri.forEach({ cmdRaw in
                //提取命令行的属性
                cmdRaw.forEach( {(key, keyAttri) in
                    let cmdLine = WGPrintCommandLineType.init(rawValue: key)!
                    let idValue = value[keyAttri["id"] as? String ?? ""]
                    let otherIdValue = value[keyAttri["otherId"] as? String ?? ""]
                    var keyValue: Any? = nil
                    if let _other = otherIdValue {
                        keyValue = "\(idValue ?? " ")" + "    \(_other)"
                    } else {
                        keyValue = idValue
                    }
                    var temp = keyAttri
                    if keyValue != nil {
                        temp[kvalue] = keyValue as? String
                    }
                    cmdLine.execute(key: key, value: keyValue, attri: temp, cmd: cmd)
                })
            })
            cmd.blePrint(attri: nil)
            return cmd.printData()
        })
        return res
    }
    
    @objc public func getEscPrintData(_ json:[String: Any]) -> Data {
        let cmd = self.cmdWithType("esc")
        let data = json["data"] as? [[String: Any]]
        data?.forEach({ cmdRow in
            cmdRow.forEach({ (key, cmdArrit) in
                let cmdLine = WGPrintCommandLineType.init(rawValue: key)!
                cmdLine.execute(key: key, value: nil, attri: cmdArrit as! [String : Any], cmd: cmd)
            })
        })
        return cmd.printData()
    }
    
    @objc public func convertDataToBase64(_ data: Data) -> String? {
        return data.covertDataToBase64()
    }
    
    @objc public func convertBase64ToData(_ base64: String) -> Data? {
        return base64.covertBase64StrToData()
    }
    
    @objc public func getQueryPrintStatusData(_ json: [String: Any]) -> Data {
        let cmd = self.cmdWithType(json["type"] as? String ?? "")
        return cmd.queryStatusData()
    }
    
    @objc public func printIdentifers(_ json: [String: Any]) -> [String]? {
        let data = json["data"] as? [[String: String]]
        var res:[String] = [String]()
        guard let _data = data else { return nil }
        for temp in _data  {
            res.append(temp["deliveryId"] ?? "")
        }
        return res
    }
    
    @objc public func printType(_ json: [String: Any]) -> String {
        let type = json["type"] as? String ?? ""
        return type
    }
    
    //MARK: private method
    private func cmdWithType(_ type: String) -> WGBasePrintCommand {
        let printType = WGPrintCommandType.init(rawValue: type)!
        return printType.cmd()
    }
    
}

