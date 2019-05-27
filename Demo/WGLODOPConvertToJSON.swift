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
