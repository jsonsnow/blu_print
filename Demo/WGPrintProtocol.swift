//
//  WGPrintProtocol.swift
//  Demo
//
//  Created by chen liang on 2019/5/5.
//  Copyright © 2019 smarnet. All rights reserved.
//

import Foundation

protocol WGPrintProtocol {
    
    // page 配置指令
    func printPage(attri: [String: String])
    
    // 打印文本
    func printText(_ text: String?, with attri: [String: String]) -> Void
    
    // 画线
    func printLine(attri: [String: String]) -> Void
    
    // 画table 主要为esc
    func printTable(attri:[String: Any]) -> Void
    func printBarCode(data: String, attri: [String: String])
    func printQRCode(data: String, attri: [String: String])
    func printImg(data: Data, attri: [String: String])
    
    // 打印方向
    func printDirection(attri: [String: String])
    
    // 打印速度
    func printSpeed(attri:[String: String])
    
    //换行
    func feedLine(attri: [String: String])
    //打印
    func blePrint(attri: [String: String]?) -> Void
    
    //打印数据
    func printData() -> Data
    
    //查询打印状态指令
    func queryStatusData() -> Data
}
