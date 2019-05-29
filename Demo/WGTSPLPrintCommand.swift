//
//  WGTSPLPrintCommand.swift
//  Demo
//
//  Created by chen liang on 2019/5/5.
//  Copyright © 2019 smarnet. All rights reserved.
//

import Foundation

func converStringToInt32(_ str: String?, defualt: Int32? = 0) -> Int32 {
    if let _str = str, let res = Float(_str) {
        return Int32(res)
    }
    if let res = defualt {
        return res
    }
    return 0
}

class WGTSPLPrintCommand: WGBasePrintCommand {
  
    override func printPage(attri: [String : String]) {
        let direction = converStringToInt32(attri[kdirection], defualt: 1)
        let width = converStringToInt32(attri[kwidth], defualt: 100)
        let height = converStringToInt32(attri[kheight], defualt: 180)
        let x = converStringToInt32(attri[kx], defualt: 0)
        let y = converStringToInt32(attri[ky], defualt: 0)
        self.cmd.addQueryPrinterStatus(Response.ON)
        self.cmd.addSize(width, height)
        self.cmd.addDirection(direction)
        self.cmd.addReference(x, y)
        self.cmd.addGap(withM: 2, withN: 0)
        self.cmd.addComonCommand()
        self.cmd.addCls()
    }
    
    override func printText(_ text: String?, with attri: [String : String]) {
        let direction = attri[kdirection] ?? "h"
        let width = converStringToInt32(attri[kwidth], defualt: 800)
        let x = converStringToInt32(attri[kx], defualt: 0)
        let y = converStringToInt32(attri[ky], defualt: 0)
        let xScale = converStringToInt32(attri[kxScale], defualt: 1)
        let yScale = converStringToInt32(attri[kyScale], defualt: 1)
        let font = attri[kfont] ?? "TSS24.BF2"
        let value = attri[kvalue]
        var drawText: String = ""
        if let _value = value {
            drawText = _value
        }
        if let _text = text {
            drawText = _text
        }
        self.cmd.drawTextwithX(x, withY: y, withWidth: width, withFont: font, withRotation: 0, withXscal: xScale, withYscal: yScale, direction: direction, withText: drawText)
    }
    
    override func printLine(attri: [String : String]) {
        let x = converStringToInt32(attri[kx], defualt: 0)
        let y = converStringToInt32(attri[ky], defualt: 0)
        let width = converStringToInt32(attri[kwidth], defualt: 100)
        let height = converStringToInt32(attri[kheight], defualt: 1)
        self.cmd.addBar(x, y, width, height)
    }
    
    override func printBarCode(data: String, attri: [String : String]) {
        let x = converStringToInt32(attri[kx], defualt: 0)
        let y = converStringToInt32(attri[ky], defualt: 0)
        let width = converStringToInt32(attri[kwidth])
        let height = converStringToInt32(attri[kheight])
        let ratio = converStringToInt32(attri[kratio])
        self.cmd.add1DBarcode(x, y, "128", height, 1, 0, width, width * ratio, data)
    }
    
    override func printQRCode(data: String, attri: [String : String]) {
        let x = converStringToInt32(attri[kx], defualt: 0)
        let y = converStringToInt32(attri[ky], defualt: 0)
        let size = converStringToInt32(attri[ksize], defualt: 6)
        self.cmd.addQRCode(x, y, "L", size, "A", 0, data)
    }
    
    override func printImg(data: Data, attri: [String : String]) {
        
    }
    
    override func blePrint(attri: [String: String]?) -> Void {
        let set = converStringToInt32(attri?["set"], defualt: 1)
        let copy = converStringToInt32(attri?["copy"], defualt: 1)
        self.cmd.addPrint(set, copy)
    }
    
    override func printData() -> Data {
        return self.cmd.getCommand()
    }
    
    override func queryStatusData() -> Data {
        self.cmd.queryPrinterStatus()
        return self.cmd.getCommand()
    }
    
    @objc func cmdTtpe() -> Data {
        self.cmd.queryPrinterType()
        return self.cmd.getCommand()
    }
    
    lazy var cmd: TscCommand = {
        let cmd = TscCommand.init()
        return cmd
    }()
    
}

