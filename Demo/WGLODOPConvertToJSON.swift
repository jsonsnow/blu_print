//
//  WGLODOPConvertToJSON.swift
//  Demo
//
//  Created by chen liang on 2019/5/27.
//  Copyright © 2019 smarnet. All rights reserved.
//

import Foundation

let PAGE_CMD_STR = "LODOP.ADD_PRINT_PAGE"
let LINE_CMD_STR = "LODOP.ADD_PRINT_LINE"
let TEXT_CMD_STR = "LODOP.ADD_PRINT_TEXT"
let BAR_CMD_STR = "LODOP.ADD_PRINT_BARCODE"
let QR_CMD_STR = "LODOP.ADD_PRINT_QR"

let horizontal_min_width = 2

class WGLODOPConvertToJSON: NSObject {
    
    enum LODOParamsRegular: String {
        
        //LODOP.ADD_PRINT_PAGE(direction,0,0,100,180);
        case PAGE = "LODOP.ADD_PRINT_PAGE\\((.*),(.*),(.*),(.*),(.*)\\);"
        case LINE = "LODOP.ADD_PRINT_LINE\\((\\d*),(\\d*),(\\d*),(\\d*),(\\d*),(\\d*)\\);"
        //545,148,135,36,"寄方:{寄件人姓名} {寄件人联系电话} {寄件地址}"
        case TEXT = "LODOP.ADD_PRINT_TEXT\\((\\d*),(\\d*),(\\d*),(\\d*),\"(.*)\"\\);"
        
        //LODOP.ADD_PRINT_BARCODE(116,48,192,40,"128Auto","{快递单号条码}");
        case BARCODE = "LODOP.ADD_PRINT_BARCODE\\((\\d*),(\\d*),(\\d*),(\\d*),\"(\\w*)\",\"\\{(\\w*)\\}\"\\)"
        
        case QR = ""
        
        func getParams(with cmdLine: String) -> [String:[String: String]]? {
            switch self {
            case .PAGE:
                var page: [String : [String : String]]? = nil;
                cmdLine.match(pattern: self.rawValue) { (result) in
                    guard let result = result else { return }
                    var res = [String: String]()
                    
                    var firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 1).location)
                    var endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 1).location + result.range(at: 1).length)
                    res["id"] = String(cmdLine[firstIndex ..< endIndex])
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 2).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 2).location + result.range(at: 2).length)
                    res["x"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])))"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 3).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 3).location + result.range(at: 3).length)
                    res["y"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])))"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 4).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 4).location + result.range(at: 4).length)
                    res["width"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])))"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 5).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 5).location + result.range(at: 5).length)
                    res["height"] = String(cmdLine[firstIndex ..< endIndex])
                    
                    page = ["page" : res]
                }
                return page
            case .LINE:
                var line: [String : [String: String]]? = nil
                cmdLine.match(pattern: self.rawValue) { (result) in
                    guard let result = result else { return }
                    var res = [String: String]()
                    var firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 1).location)
                    var endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 1).location + result.range(at: 1).length)
                    res["y"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 2).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 2).location + result.range(at: 2).length)
                    res["x"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 3).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 3).location + result.range(at: 3).length)
                    res["y1"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 4).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 4).location + result.range(at: 4).length)
                    res["x1"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 5).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 5).location + result.range(at: 5).length)
                    res["null"] = String(cmdLine[firstIndex ..< endIndex])
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 6).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 6).location + result.range(at: 6).length)
                    res["lineWidth"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    let x1 = converStringToFloat(res["x1"])
                    let y1 = converStringToFloat(res["y1"])
                    let x = converStringToFloat(res["x"])
                    let y = converStringToFloat(res["y"])
                    if abs(x1 - x) <= Float(horizontal_min_width) {
                        res["width"] = res["lineWidth"]
                        res["height"] = "\(y - y1)"
                        res["y"] = "\(y1)"
                    } else {
                        res["width"] = "\(x1 - x)"
                        res["height"] = res["lineWidth"]
                    }
                    line = ["line": res]
                }
                print(line ?? [String : [String: String]]())
                return line
            case .BARCODE:
                var bar: [String : [String: String]]? = nil
                cmdLine.match(pattern: self.rawValue) { (result) in
                    guard let result = result else { return }
                    var res = [String: String]()
                    var firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 1).location)
                    var endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 1).location + result.range(at: 1).length)
                    res["y"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 2).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 2).location + result.range(at: 2).length)
                    res["x"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 3).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 3).location + result.range(at: 3).length)
                    res["width"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])))"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 4).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 4).location + result.range(at: 4).length)
                    res["height"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 5).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 5).location + result.range(at: 5).length)
                    res["type"] = String(cmdLine[firstIndex ..< endIndex])
                    
                    let type = res["type"] ?? "QRCode"
                    if type == "QRCode" {
                        let width = converStringToFloat(res["width"])
                        let size = width / 13
                        res[ksize] = "\(size)"
                        res["id"] = "qrCodeNum"
                        bar = ["qr": res]
                    } else {
                        var width = converStringToFloat(res["width"]) * 1.9
                        width = width / 120
                        res[kwidth] = "\(width)"
                        res[kratio] = "2"
                        res["id"] = "barCodeNum"
                        bar = ["barCode": res]
                    }
                }
                return bar
            case .TEXT:
                var text: [String : [String: String]]? = nil
                cmdLine.match(pattern: getTextRegual(type: 0)) { (result) in
                    guard let result = result else { return }
                    var res = [String: String]()
                    var firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 1).location)
                    var endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 1).location + result.range(at: 1).length)
                    res["y"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 2).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 2).location + result.range(at: 2).length)
                    res["x"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 3).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 3).location + result.range(at: 3).length)
                    res["width"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 4).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 4).location + result.range(at: 4).length)
                    res["height"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 5).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 5).location + result.range(at: 5).length)
                    res["value"] = String(cmdLine[firstIndex ..< endIndex])
                    
                    res["font"] = "TSS24.BF2"
                    res["xScale"] = "1"
                    res["yScale"] = "1"
                    text = ["text": res]
                }
                return text
                //一个id的匹配
                cmdLine.match(pattern: getTextRegual(type: 1)) { (result) in
                    guard let result = result else { return }
                    var res = [String: String]()
                    var firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 1).location)
                    var endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 1).location + result.range(at: 1).length)
                    res["y"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 2).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 2).location + result.range(at: 2).length)
                    res["x"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 3).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 3).location + result.range(at: 3).length)
                    res["width"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 4).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 4).location + result.range(at: 4).length)
                    res["height"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 5).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 5).location + result.range(at: 5).length)
                    res["id"] = String(cmdLine[firstIndex ..< endIndex])
                    
                    res["font"] = "TSS24.BF2"
                    res["xScale"] = "1"
                    res["yScale"] = "1"
                    text = ["text": res]
                }
                
                //一个id的匹配
                cmdLine.match(pattern: getTextRegual(type: 2)) { (result) in
                    guard let result = result else { return }
                    var res = [String: String]()
                    var firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 1).location)
                    var endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 1).location + result.range(at: 1).length)
                    res["y"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 2).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 2).location + result.range(at: 2).length)
                    res["x"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 3).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 3).location + result.range(at: 3).length)
                    res["width"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 4).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 4).location + result.range(at: 4).length)
                    res["height"] = "\(converStringToFloat(String(cmdLine[firstIndex ..< endIndex])) * 2)"
                    
                    firstIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 5).location)
                    endIndex = cmdLine.index(cmdLine.startIndex, offsetBy: result.range(at: 5).location + result.range(at: 5).length)
                    res["id"] = String(cmdLine[firstIndex ..< endIndex])
                    
                    res["font"] = "TSS24.BF2"
                    res["xScale"] = "1"
                    res["yScale"] = "1"
                    text = ["text": res]
                }
                return text
            default:
                return nil
            }
            
        }
        func getTextRegual(type: Int) -> String {
            //纯text匹配正则
            return "LODOP.ADD_PRINT_TEXT\\((\\d*),(\\d*),(\\d*),(\\d*),\"(.*)\"\\);"
            if type == 0 {
                return "LODOP.ADD_PRINT_TEXT\\((\\d*),(\\d*),(\\d*),(\\d*),\"(.*)\"\\);"
            }
            if type == 1 {
                return "LODOP.ADD_PRINT_TEXT\\((\\d*),(\\d*),(\\d*),(\\d*),\"\\{(\\w*)\\}\"\\);"
            }
            //545,148,135,36,"寄方:{寄件人姓名} {寄件人联系电话} {寄件地址}"
            return "LODOP.ADD_PRINT_TEXT\\((\\d*),(\\d*),(\\d*),(\\d*),\"(.*)[\\{(.*)\\ ?\\}\"]{2,3}\\);"
            
        }
    }
    
    
   @objc static func parseTxt(fileName: String ) -> [[String:[String: String]]]? {
        let cmdLines = convertTxtToStrLines(fileName: fileName)
        guard let _cmdLines = cmdLines else { return nil }
        return self.convertLODOLineToMyLine(_cmdLines)
    }
    
   static  private func convertTxtToStrLines(fileName: String) -> [String]? {
        let newLines = "\r\n"
        guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else { return nil }
        do {
            let customEnc = CFStringConvertEncodingToNSStringEncoding(UInt32(CFStringEncodings.GB_18030_2000.rawValue))
            let data = try String(contentsOfFile: path, encoding: String.Encoding(rawValue: customEnc))
            let printStr = data.components(separatedBy: newLines)
            print(printStr)
            return printStr
        } catch  {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static private func convertLODOLineToMyLine(_ lines: [String]) -> [[String: [String: String]]] {
        let res = lines.map { (line) -> [String: [String: String]] in
            if line.contains(PAGE_CMD_STR) {
                return self.analyzePage(line)
            }
            if line.contains(LINE_CMD_STR) {
                return self.analyzeLine(line)
            }
            if line.contains(TEXT_CMD_STR) {
                return self.analyzeText(line)
            }
            if line.contains(BAR_CMD_STR) {
                return self.analyzeBarcode(line)
            }
            if line.contains(QR_CMD_STR) {
                return self.analyzeQr(line)
            }
            return self.analyzeDefault(line)
        }
        return res
    }
    
    static private func analyzePage(_ line: String) -> [String: [String: String]] {
        return LODOParamsRegular.PAGE.getParams(with: line) ?? [String: [String: String]]()
    }
    
    static private func analyzeText(_ line: String) -> [String: [String: String]] {
        return LODOParamsRegular.TEXT.getParams(with: line) ?? [String: [String: String]]()
    }
    
    static private func analyzeLine(_ line: String) -> [String: [String: String]] {
        return LODOParamsRegular.LINE.getParams(with: line) ?? [String: [String: String]]()
    }
    
    static private func analyzeQr(_ line: String) -> [String: [String: String]] {
        return LODOParamsRegular.QR.getParams(with: line) ?? [String: [String: String]]()
    }
    
    static private func analyzeBarcode(_ line: String) -> [String: [String: String]] {
        return LODOParamsRegular.BARCODE.getParams(with: line) ?? [String: [String: String]]()
    }
    
    static private func analyzeDefault(_ line: String) -> [String: [String: String]] {
        return ["layout": [String: String]()]
    }
}

extension String {
    typealias WGMatchCallback = (_ result: NSTextCheckingResult?) -> Void
    func match(pattern: String, callback: WGMatchCallback) -> Void {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: self, options: [], range: NSRange.init(location: 0, length: self.utf16.count))
            callback(matches.first)
        } catch  {
            print("\(error)")
        }
    }
}
