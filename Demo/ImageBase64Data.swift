//
//  File.swift
//  Demo
//
//  Created by chen liang on 2019/5/9.
//  Copyright © 2019 smarnet. All rights reserved.
//

import Foundation

extension Data {
    
    func covertDataToBase64(urlEncode: Bool = true) -> String? {
        var base64: String? = self.base64EncodedString(options: .endLineWithLineFeed)
        if urlEncode {
            base64 = base64?.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        }
        return base64
    }
    
    func covertToCGImage() -> CGImage? {
        let imamge = UIImage.init(data: self)
        let cgImage = imamge?.cgImage
        return cgImage
    }
    
}

extension String {
    func covertBase64StrToData(urlEncode: Bool = true) -> Data? {
        if urlEncode == true {
            if let base64 = self.removingPercentEncoding {
                return Data(base64Encoded: base64)
            }
            return nil
        }
        return Data(base64Encoded: self)
    }
}

