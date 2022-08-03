//
//  Characters.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 01.08.22.
//

import Foundation


struct Characters: Decodable {
    let count: Int?
    let list: [Character]

    enum CodingKeys: String, CodingKey {
        case count
        case list = "results"
    }
}
