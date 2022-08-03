//
//  Comic.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 01.08.22.
//

import Foundation


struct ComicList: Decodable {
    let items: [ComicSummary]?
}

struct ComicSummary: Decodable {
    let name: String?
}

