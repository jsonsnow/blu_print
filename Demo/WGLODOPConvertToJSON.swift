//
//  WGLODOPConvertToJSON.swift
//  Demo
//
//  Created by chen liang on 2019/5/27.
//  Copyright © 2019 smarnet. All rights reserved.
//

import Foundation

let LINE_CMD_STR = "LODOP.ADD_PRINT_LINE"
let TEXT_CMD_STR = "LODOP.ADD_PRINT_TEXT"
let BAR_CMD_STR = "LODOP.ADD_PRINT_BARCODE"
let QR_CMD_STR = "LODOP.ADD_PRINT_QR"



class WGLODOPConvertToJSON: NSObject {
    
    enum LODOParamsRegular: String {
        case LINE = "LODOP.ADD_PRINT_LINE\\((\\d*),(\\d*),(\\d*),(\\d*),(\\d*),(\\d*)\\);"
        //545,148,135,36,"寄方:{寄件人姓名} {寄件人联系电话} {寄件地址}"
        case TEXT = "LODOP.ADD_PRINT_TEXT\\(([0-9]*),([0-9]*),([0-9]*),([0-9]*),\"(\\w*)({\\w*\\})? \"\\);"
        
        func getParams(with cmdLine: String) -> [String:[String: String]]? {
            switch self {
            case .LINE:
                let res = cmdLine.match(pattern: self.rawValue)
                print(res ?? [String:[String: String]]())
                return res
            default:
                return nil
            }
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
         return ["page" :[String: String]()]
    }
    
    static private func analyzeText(_ line: String) -> [String: [String: String]] {
         return ["text" :[String: String]()]
    }
    
    static private func analyzeLine(_ line: String) -> [String: [String: String]] {
        _ = LODOParamsRegular.LINE.getParams(with: line)
        return ["line" :[String: String]()]
    }
    
    static private func analyzeQr(_ line: String) -> [String: [String: String]] {
        return ["qr" :[String: String]()]
    }
    
    static private func analyzeBarcode(_ line: String) -> [String: [String: String]] {
        return ["barCode" :[String: String]()]
    }
    
    static private func analyzeDefault(_ line: String) -> [String: [String: String]] {
        return ["layout": [String: String]()]
    }
}

extension String {
    func match(pattern: String) -> [String:[String: String]]? {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: self, options: [], range: NSRange.init(location: 0, length: self.utf16.count))
            return matches.map { (result) -> [String: [String: String]] in
                var res = [String: String]()
                print(result.range(at: 1))
                var firstIndex = self.index(self.startIndex, offsetBy: result.range(at: 1).location)
                var endIndex = self.index(self.startIndex, offsetBy: result.range(at: 1).location + result.range(at: 1).length)
                res["y1"] = String(self[firstIndex ..< endIndex])
                
                firstIndex = self.index(self.startIndex, offsetBy: result.range(at: 2).location)
                endIndex = self.index(self.startIndex, offsetBy: result.range(at: 2).location + result.range(at: 2).length)
                res["x1"] = String(self[firstIndex ..< endIndex])
                
                firstIndex = self.index(self.startIndex, offsetBy: result.range(at: 3).location)
                endIndex = self.index(self.startIndex, offsetBy: result.range(at: 3).location + result.range(at: 3).length)
                res["y"] = String(self[firstIndex ..< endIndex])
                firstIndex = self.index(self.startIndex, offsetBy: result.range(at: 4).location)
                endIndex = self.index(self.startIndex, offsetBy: result.range(at: 4).location + result.range(at: 4).length)
                res["x"] = String(self[firstIndex ..< endIndex])
                
                firstIndex = self.index(self.startIndex, offsetBy: result.range(at: 5).location)
                endIndex = self.index(self.startIndex, offsetBy: result.range(at: 5).location + result.range(at: 5).length)
                res["null"] = String(self[firstIndex ..< endIndex])
                
                firstIndex = self.index(self.startIndex, offsetBy: result.range(at: 6).location)
                endIndex = self.index(self.startIndex, offsetBy: result.range(at: 6).location + result.range(at: 6).length)
                res["width"] = String(self[firstIndex ..< endIndex])
                return ["line": res]
            }.first
        } catch  {
            print("\(error)")
            return nil
        }
    }
}
