//
//  String.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/13.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//  擴展STRING，增加MD5方法 ，調用方法 let md5String = someString.md5()
//

import Foundation

extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(format: hash as String)
    }
}

