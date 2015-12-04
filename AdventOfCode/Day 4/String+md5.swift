//
//  String+md5.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 04.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

extension String {

    func md5() -> String {
        var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
        if let data = self.dataUsingEncoding(NSUTF8StringEncoding) {
            CC_MD5(data.bytes, CC_LONG(data.length), &digest)
        }
        
        let digestHex = digest.map { String(format: "%02x", $0) }.joinWithSeparator("")
        
        return digestHex
    }

}