//
//  WGXMLParserManager.swift
//  Demo
//
//  Created by chen liang on 2019/5/5.
//  Copyright © 2019 smarnet. All rights reserved.
//

import UIKit
import Foundation

typealias XMLParaserCallback = (_ data: [[String: [String: String]]]?) ->()
class WGXMLParserManager: NSObject {

    fileprivate var parseData: [[String: [String: String]]]?
    fileprivate var curElement: String?
    fileprivate var callback: XMLParaserCallback?
    fileprivate var parser: XMLParser?
    @objc static let manager: WGXMLParserManager = WGXMLParserManager.init()
    
    private override init() {
        super.init()
    }
    
    /// parser xml document
    ///
    /// - Parameters:
    ///   - data: xml data
    ///   - callback: parse succeess callback ,when parserDidEndDocument
    @objc public func parseData(_ data: Data, callback: @escaping XMLParaserCallback) {
        self.callback = callback
        parseData = [[String: [String: String]]]()
        parser = XMLParser.init(data: data)
        parser?.delegate = self
        parser?.parse()
    }
    
   
    /// parser xml document
    ///
    /// - Parameters:
    ///   - url: xml url
    ///   - callback: parse succeess callback ,when parserDidEndDocument
    @objc public func parseUrl(_ url: URL, callback: @escaping XMLParaserCallback) {
        self.callback = callback
        parseData = [[String: [String: String]]]()
        parser = XMLParser.init(contentsOf: url)
        parser?.delegate = self
        parser?.parse()
    }
}

extension WGXMLParserManager: XMLParserDelegate {
    
     func parserDidStartDocument(_ parser: XMLParser) {
        
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.callback?(self.parseData)
        self.callback = nil
        let encode = JSONEncoder.init()
        let data = try? encode.encode(self.parseData!)
        let jsonStr = String(data: data ?? Data.init(), encoding: .utf8)
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.curElement = elementName
        self.parseData?.append([elementName: attributeDict])
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard let _ = curElement else { return  }
    }
    
//    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
//        print("解析出错:\(parseError)")
//    }
}
