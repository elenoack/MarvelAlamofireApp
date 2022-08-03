//
//  CharacterImage.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 02.08.22.
//

import UIKit


enum SizeImage: String {
    case meium = "standard_medium"
    case large = "landscape_large"
    case portraitMedium = "portrait_medium"
}


struct CharacterImage: Decodable {
    private let path: String?
    private let format: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case format = "extension"
    }
    
    var mediumImage: UIImage? {
        getImage(size: SizeImage.meium.rawValue)
    }
    
    var largeImage: UIImage? {
        getImage(size: SizeImage.large.rawValue)
    }
    
    var portraitMedium: UIImage? {
        getImage(size: SizeImage.portraitMedium.rawValue)
    }
        
    private func getImage(size: String) -> UIImage? {
        guard let imagePath = path,
              let imageExtension = format,
              let imageURL = URL(string: "\(imagePath)/\(size).\(imageExtension)")
        else {
            return nil }
        
        guard let data = try? Data(contentsOf: imageURL)
        else {
            return nil }
        
        return UIImage(data: data)
    }
    
}
