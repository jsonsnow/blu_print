//
//  WGBasePrintCommand.swift
//  Demo
//
//  Created by chen liang on 2019/5/7.
//  Copyright © 2019 smarnet. All rights reserved.
//

import UIKit

class WGBasePrintCommand: NSObject, WGPrintProtocol {
    func feedLine(attri: [String : String]) {
        
    }
    
    
    func printDirection(attri: [String : String]) {
        
    }
    
    func printSpeed(attri: [String : String]) {
        
    }
    
    func blePrint(attri: [String : String]?) {
        
    }
    
    
    func printTable(attri: [String : Any]) {
        
    }
    
    func queryStatusData() -> Data {
        return Data.init()
    }
    
    
    func printData() -> Data {
        return Data.init()
    }
    
    
    func printPage(attri: [String : String]) {
        
    }
    
    func printText(_ text: String?, with attri: [String : String]) {
        
    }
    
    func printLine(attri: [String : String]) {
        
    }
    
    func printBarCode(data: String, attri: [String : String]) {
        
    }
    
    func printQRCode(data: String, attri: [String : String]) {
        
    }
    
    func printImg(data: Data, attri: [String : String]) {
        
    }
    
}
