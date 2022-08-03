//
//  URL Extensions.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 01.08.22.
//

import UIKit
import CryptoKit


extension String {
    
    func md5() -> String {
        return Insecure
            .MD5
            .hash(data: self.data(using: .utf8) ?? Data())
            .map { String(format: "%02hhx", $0) }
            .joined()
    }

}



