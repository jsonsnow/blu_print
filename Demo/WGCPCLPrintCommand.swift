//
//  WGCPCLPrintCommand.swift
//  Demo
//
//  Created by chen liang on 2019/5/5.
//  Copyright © 2019 smarnet. All rights reserved.
//

import Foundation
import PrinterSDK

func converStringToInt(_ str: String?, defualt: Int? = 0) -> Int {
    if let _str = str, let res = Int(_str) {
        return res
    }
    if let res = defualt {
        return res
    }
    return 0
}

class WGCPCLPrintCommand: WGBasePrintCommand {
    
    override func printPage(attri: [String : String]) {
        let direction = converStringToInt(attri[kdirection], defualt: 1)
        let width = converStringToInt(attri[kwidth], defualt: 800)
        let height = converStringToInt(attri[kheight], defualt: 1440)
        let x = converStringToInt(attri[kx], defualt: 0)
        let y = converStringToInt(attri[ky], defualt: 0)
        let init_print_template = "! 0 200 200 \(height) 1\n"
        let page_width_command = "PAGE-WIDTH \(width)\n"
        self.cmd.cpclSetPosition(withXPos: x, yPos: y)
        self.cmd.appendCommand(init_print_template)
        self.cmd.cpclReverse(direction)
        self.cmd.appendCommand(page_width_command)
    }
    
    override func printDirection(attri: [String : String]) {
        
    }
    
    override func printSpeed(attri: [String : String]) {
        let speed = converStringToInt(attri[kvalue], defualt: 3)
        self.cmd.cpclSpeed(speed)
    }
    
    
    // font: 字体大小 1：16点阵；2：24点阵；3：32点阵；4：24点阵放大一倍；5：32点阵放大一倍; 6：24点阵放大两倍；7：32点阵放大两倍；其他：24点阵
    override func printText(_ text: String?, with attri: [String : String]) {
        let width = converStringToInt(attri[kwidth], defualt: 800)
        let x = converStringToInt(attri[kx], defualt: 0)
        let y = converStringToInt(attri[ky], defualt: 0)
        let direction = attri[kdirection] ?? "h"
        //let xScale = converStringToInt32(attri[kxScale], defualt: 1)
        //let yScale = converStringToInt32(attri[kyScale], defualt: 1)
        let font = converStringToInt(attri["cpclFont"], defualt: 2)
        let value = attri[kvalue]
        var drawText: String = ""
        if let _value = value {
            drawText = _value
        }
        if let _text = text {
            drawText = _text
        }
        self.cmd.drawText(x: x, y: y, width: width, direction: direction, font: font, text: drawText)
        //self.cmd.cpclAutoText(withRotate: 0, font: font, fontSize: 0, x: x, y: y, width: width, lineSpacing: 8, text: drawText)
    }
    
    override func printLine(attri: [String : String]) {
        let x = converStringToInt(attri[kx], defualt: 0)
        let y = converStringToInt(attri[ky], defualt: 0)
        let x1 = converStringToInt(attri["x1"], defualt: 100)
        let y1 = converStringToInt(attri["y1"], defualt: 1)
        let width = converStringToInt(attri[kwidth], defualt: 100)
        let height = converStringToInt(attri[kheight], defualt: 1)
        self.cmd.cpclLine(withXPos: x, yPos: y, xEnd: width - x, yEnd: y1 + height, thickness: 1)
    }
    
    override func printBarCode(data: String, attri: [String : String]) {
        let x = converStringToInt(attri[kx], defualt: 0)
        let y = converStringToInt(attri[ky], defualt: 0)
        let width = converStringToInt(attri[kwidth])
        let height = converStringToInt(attri[kheight])
        let ratio = converStringToInt(attri[kratio])
        let hm = converStringToInt(attri[khm], defualt: 1)
        self.cmd.barCodeNumShow(hm)
        self.cmd.cpclBarcode("128", width: width, ratio: ratio, height: height, x: x, y: y, barcode: data)
    }
    
    override func printQRCode(data: String, attri: [String : String]) {
        let x = converStringToInt(attri[kx], defualt: 0)
        let y = converStringToInt(attri[ky], defualt: 0)
        let size = converStringToInt(attri[ksize], defualt: 6)
        self.cmd.cpclBarcodeQRcode(withXPos: x, yPos: y, model: 2, unitWidth: size)
    }
    
    override func printImg(data: Data, attri: [String : String]) {
        
    }
    
    override func queryStatusData() -> Data {
        let cmd = PTCommandCPCL.init()
        cmd.cpclGetPaperStatus()
        return cmd.cmdData as Data
    }
    
    override func printData() -> Data {
        return self.cmd.cmdData as Data
    }
    
    override func blePrint(attri: [String : String]?) {
        self.cmd.cpclForm()
        self.cmd.cpclPrint()
    }
    
    //MARK: lazy load
    lazy var cmd: PTCommandCPCL = {
        let cmd = PTCommandCPCL.init()
        return cmd
    }()
}


extension PTCommandCPCL {
    
    public func drawText(x: Int, y: Int, width: Int, direction: String, font: Int, text: String) {
        if direction == "v" {
            let fontWithWidth:[(key:Int, value: Int)] = [(1, 16),(2, 24),(3, 32),(4, 48),(5, 64),(6, 72),(7, 98)]
            let drawFont:(key: Int, value: Int) = fontWithWidth.filter { return $0.key == font }.reduce((0,0), { return $1})
            let itemX = drawFont.value
            for i in 0 ..< text.count {
                let start = text.index(text.startIndex, offsetBy: i)
                let end = text.index(text.startIndex, offsetBy: i)
                let range = start ..< end
                let oneStr = String(text[range])
                let temp_y = (itemX + 4) * i
                self.cpclAutoText(withRotate: 0, font: font, fontSize: 0, x: x, y: y + temp_y, width: width, lineSpacing: 8, text: oneStr)
            }
        } else {
            self.cpclAutoText(withRotate: 0, font: font, fontSize: 0, x: x, y: y, width: width, lineSpacing: 8, text: text)
        }
    }
    
    public func barCodeNumShow(_ show: Int) {
        if show == 1 {
            self.appendCommand("BARCODE-TEXT 7 0 5")
        } else {
            self.appendCommand("BT OFF")
        }
    }
    
    public func appSetff(maxFeed: Float = 25, skip: Float = 1) {
        let setff = "SETFF \(maxFeed) \(skip)"
        let res = "! UTILITIES\r\nIN-MILLIMETERS\r\n" + setff
        self.appendCommand(res)
        
    }
}

