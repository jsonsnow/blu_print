//
//  WGESCPrintCommand.swift
//  Demo
//
//  Created by chen liang on 2019/5/5.
//  Copyright © 2019 smarnet. All rights reserved.
//

import Foundation
import PrinterSDK

func converStringToFloat(_ str: String?, defualt: Float? = 0) -> Float {
    if let _str = str, let res = Float(_str) {
        return res
    }
    if let res = defualt {
        return res
    }
    return 0
}

//空格是一个字母的宽度，数子也是字母的宽度，宽度为12个点
func calculateStrWidth(_ phrase: String, font:String, scale: Float) -> Int {
    
    var width = 0
    let fontWidth = WGESCFontType.init(rawValue: font)!
    for value in phrase {
        //非汉字
        var characterWidth = fontWidth.fontToWidth()
        if ("\u{4E00}" > value  || value > "\u{9FA5}") {
            characterWidth = characterWidth / 2
        }
        width = width + characterWidth
    }
    return width
}

enum WGESCAligment: String {
    case left = "left"
    case center = "center"
    case right = "right"
    
    func convertToEscCmd() -> Int {
        switch self {
        case .left:
            return 48
        case .center:
            return 49
        case .right:
            return 50
        }
    }
}

enum WGESCFontType: String {
    case min = "min"
    case normal = "normal"
    case bold = "blod"
    
    func fontToWidth() -> Int {
        switch self {
        case .min:
            return 16
        case .normal:
            return 24
        case .bold:
            return 24
        }
    }
    
    func fontToEscCmd() -> ESCText {
        switch self {
        case .min:
            return ESCText.init(rawValue: 1)!
        case .normal:
            return ESCText.init(rawValue: 0)!
        case .bold:
            return ESCText.init(rawValue: 8)!
        }
    }
}

class WGESCPrintCommand: WGBasePrintCommand {
    
    fileprivate var width: Int!
    fileprivate var scale: Float!
    fileprivate var pageWidth: Int!
    fileprivate var titleOffsets:[[Int]] = [[Int]]()//表格标题偏移
    private var curTableIndex: Int = 0//当前在第几个表格
    
    override func printPage(attri: [String : String]) {
        let width = converStringToInt(attri[kwidth])
        let scale = converStringToFloat(attri[kscale], defualt: 8)
        self.width = width
        self.scale = scale
        self.titleOffsets.removeAll()
        self.curTableIndex = 0
        self.cmd.initializePrinter()
        pageWidth = Int(Float(width) * scale - 8 * 8)
        self.cmd.setLeftMargin(0)
        //self.cmd.setPrintAreaWidth(pageWidth)
    }
    
    override func printDirection(attri: [String : String]) {
        let direction = converStringToInt(attri[kvalue], defualt: 3);
        self.cmd.pageSetPrintDirection(direction)
    }
    
    override func printSpeed(attri: [String : String]) {
        let speed = converStringToInt(attri[kvalue], defualt: 1)
        self.cmd.setSpeed(speed)
    }
    
    override func feedLine(attri: [String : String]) {
        let count = converStringToInt(attri[kvalue], defualt: 5)
        self.cmd.printAndFeedLines(count)
    }
    
    override func printText(_ text: String?, with attri: [String : String]) {
        let value = attri[kvalue]
        var drawText: String = ""
        if let _value = value {
            drawText = _value
        }
        if let _text = text {
            drawText = _text
        }
        let alignment = attri[kalignment]
        let fon = attri[kfont]
        let aligType = WGESCAligment.init(rawValue: alignment ?? "left")!
        let fontType = WGESCFontType.init(rawValue: fon ?? "normal")!
        self.cmd.setJustification(aligType.convertToEscCmd())
        self.setTextFont(fontType)
        self.cmd.appendText(drawText, mode: fontType.fontToEscCmd())
        self.clearTextFont()
        self.cmd.setJustification(0)
    }
    
    override func printLine(attri: [String : String]) {
        let count = self.pageWidth / calculateStrWidth("-", font: "normal", scale: self.scale)
        var line = ""
        for _ in 0 ..< count {
            line.append("-")
        }
        self.cmd.appendText(line)
    }
    
    override func printBarCode(data: String, attri: [String : String]) {
        let content = attri[kvalue]!
        let alignment = attri[kalignment]
        let width = converStringToInt(attri[kwidth], defualt: 3)
        let height = converStringToInt(attri[kheight], defualt: 120)
        let numberAround = converStringToInt(attri["numberAround"], defualt: 2)
        let aligType = WGESCAligment.init(rawValue: alignment ?? "left")!
        let barType = ESCBarcode.init(rawValue: converStringToInt(attri[kbarType], defualt: 73)) ?? .B_CODE128
        self.cmd.append(barType, data: content, justification: aligType.convertToEscCmd(), width: width, height: height, hri: numberAround)
    }
    
    override func printQRCode(data: String, attri: [String : String]) {
        let content = attri[kvalue]!
        let alignment = attri[kalignment]
        let size = converStringToInt(attri[ksize], defualt: 6)
        let aligType = WGESCAligment.init(rawValue: alignment ?? "left")!
        let leftMargin = converStringToInt(attri["leftMargin"], defualt: 1)
        self.cmd.appendQRCodeData(content, justification: aligType.convertToEscCmd(), leftMargin: leftMargin, eccLevel: 48, model: 50, size: size)
    }
    
    override func printImg(data: Data, attri: [String : String]) {
        let base64 = attri[kvalue];
        let data = base64?.covertBase64StrToData()
        self.cmd.appendRasterImage(data?.covertToCGImage()!, mode: .binary, compress: .none)
    }
    
    override func printTable(attri: [String : Any]) {
        let titles = attri["titles"] as? [String]
        let list = attri["list"] as? [Any]
        self.printTableTitles(titles)
        self.printTableList(list)
        self.curTableIndex = self.curTableIndex + 1
    }
    
    private func printTableList(_ list: [Any]?) {
        guard let _list = list else { return  }
        _list.forEach { (rows) in
            self.printTableRows(rows)
        }
        
    }
    
    private func printTableRows(_ rows: Any) {
        guard let _rows = rows as? [String: Any] else { return  }
        let title = _rows["title"] as? String
        self.cmd.appendText(title, mode: .normal)
        let rows = _rows["row"] as? [[String]]
        rows?.forEach({ (row) in
            printTableRow(row)
        })
    }
    
    private func printTableRow(_ row: [String]) {
        //原始数据
        var originalRow = row
        //本行数据
        var curRow: [String] = [String]()
        //下一行的数据容器，是否有数据根据计算得出
        let nexRow: [String] = row.map { (_) -> String in
            return ""
        }
        var changeNexRow = nexRow
        let offsets = self.titleOffsets[self.curTableIndex]
        for i in 0 ..< originalRow.count {
            let item = originalRow[i]
            let preItem = (i == 0 ? nil : originalRow[i-1])
            let preOffset = (i == 0 ? nil : offsets[i-1])
            let resItem:(this: String, next: String?, original: String) = layoutItem(item, preItem: preItem, preOffset: preOffset, curOffset: offsets[i], nextOffset: offsets[i+1])
            if let lineFeed = resItem.next {
                changeNexRow[i] = lineFeed
                originalRow[i] = resItem.original
            }
            curRow.append(resItem.this)
        }
        let curStr = curRow.reduce("") { (first, next) -> String in
            return first + next
        }
        print("\(curStr)")
        self.cmd.appendText(curStr, mode: .normal)
        if changeNexRow != nexRow {
            printTableRow(changeNexRow)
        }
    }
    
    //如果计算需要换行则next存在值
    private func layoutItem(_ item: String, preItem: String?,  preOffset: Int?, curOffset: Int, nextOffset: Int) -> (this: String, next: String?, original: String) {
        var itemWidth = calculateStrWidth(item, font: "normal", scale: self.scale)
        var cur: String = item
        var nex: String?
        var original: String = item
        //item之间的最小间隔
        let interval = 12
        if (itemWidth + curOffset + interval) >= nextOffset {
            var curStr: String = ""
            var preStr: String!
            var index = 0
            for value in item {
                curStr = curStr + String(value)
                let curWidth = calculateStrWidth(curStr, font: "normal", scale: self.scale)
                if (curWidth + curOffset + interval) >= nextOffset {
                    let nextStartIndex = item.index(item.startIndex, offsetBy: index)
                    let nextEndIndex = item.index(item.endIndex, offsetBy: 0)
                    cur = preStr
                    original = preStr
                    nex = String(item[nextStartIndex ..< nextEndIndex])
                    break
                }
                index = index + 1
                preStr = curStr
            }
        }
        if let _preItem = preItem, let _preOfsset = preOffset {
            itemWidth = calculateStrWidth(_preItem, font: "normal", scale: self.scale)
            var spaceCount = (curOffset - _preOfsset - itemWidth)/12
            if spaceCount < 0 {
                spaceCount = 0
            }
            cur = textInsertSpace(cur, spaceCount: spaceCount)
            print("\(spaceCount)")
        }
        
        return (cur, nex, original)
    }
    
    private func printTableTitles(_ titles: [String]?) {
        guard let _titles = titles else { return  }
        let pageWidth = Float(self.pageWidth)
        let titleWidth = _titles.reduce(0, { (key1, key2) -> Float in
            let width = Float(calculateStrWidth(key2, font: "normal", scale: self.scale))
            return width + key1
        })
        let reduceWidth = pageWidth - titleWidth
        let reduceCount = reduceWidth / Float(calculateStrWidth(" ", font: "normal", scale: self.scale))
        let fillCount = Float(_titles.count)
        let average = Int(reduceCount / fillCount)
        let res = _titles.reduce("") { (first, value) -> String in
            if value == _titles[_titles.count - 1] {
                return first + textInsertSpace(value, spaceCount: average) + textAppendSpace("", spaceCount: average)
            }
            if value == _titles[0] {
                return value
            }
            let res = first + textInsertSpace(value, spaceCount: average)
            return res
        }
        var offsets = _titles.map { (value) -> Int in
            let offset = res.positionOf(sub: value)
            let startIndex = res.index(res.startIndex, offsetBy: 0)
            let endIndex = res.index(res.startIndex, offsetBy: offset)
            let subStr = String(res[startIndex ..< endIndex])
            return calculateStrWidth(subStr, font: "normal", scale: self.scale)
        }
        offsets.append(Int(calculateStrWidth(res, font: "normal", scale: self.scale)))
        self.titleOffsets.append(offsets)
        print("\(res) offset:\(offsets)")
        self.cmd.appendText(res, mode: .normal)
    }
    
    private func textInsertSpace(_ text: String, spaceCount: Int) -> String {
        var res = text
        for _ in 0 ..< spaceCount {
            res.insert(" ", at: res.startIndex)
        }
        return res
    }
    
    private func textAppendSpace(_ text: String, spaceCount: Int) -> String {
        var res = text
        for _ in 0 ..< spaceCount {
            res.insert(" ", at: res.endIndex)
        }
        return res
    }
    
    private func printRow() {
        
    }
    
    override func blePrint(attri: [String : String]?) {
        
    }
    
    override func printData() -> Data {
        self.cmd.printAndFeedLines(5)
        let data = self.cmd.getCommandData()
        return data ?? Data.init()
    }
    
    override func queryStatusData() -> Data {
        let cmd = PTCommandESC.init()
        cmd.getPaperStatus()
        return cmd.getCommandData()
    }
    
    lazy var cmd: PTCommandESC = {
        let cmd = PTCommandESC.init()
        return cmd
    }()
    
}

extension WGESCPrintCommand {
    
    //没效果，注释了
    func setTextFont(_ font: WGESCFontType) -> Void {
        //        var min = false
        //        var double = true
        //        var blod = false
        //        if font == .min {
        //            min = true
        //        }
        //        if font == .bold {
        //            double = true
        //            blod = true
        //        }
        //        self.cmd.setTextStyleMini(min, bold: blod, doubleWidth: double, doubleHeight: double, underline: false)
    }
    
    func clearTextFont() -> Void {
        //self.cmd.setTextStyleMini(false, bold: false, doubleWidth: false, doubleHeight: false, underline: false)
    }
}

extension String {
    //返回第一次出现的指定子字符串在此字符串中的索引
    //（如果backwards参数设置为true，则返回最后出现的位置）
    func positionOf(sub:String, backwards:Bool = false)->Int {
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
}
