//
//  Character.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 01.08.22.
//

import Foundation


struct Character: Decodable {
    let id: Int?
    var name: String?
    let description: String?
    let comicsImages : [CharacterImage]?
    let image: CharacterImage?
    let comics: ComicList?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case comicsImages = "images"
        case image = "thumbnail"
        case comics
    }
}


    
   
