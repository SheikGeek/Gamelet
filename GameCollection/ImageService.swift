//
//  ImageService.swift
//  GameCollection
//
//  Created by Chelsea Carr on 8/10/19.
//  Copyright © 2019 Chelsea Carr. All rights reserved.
//

import Foundation
import UIKit

class ImageService: NSObject {
    
    static let main = ImageService()
    private override init() {}
    
    func fetchImage(from urlString: String, completion: @escaping ((UIImage?) -> Void)) {
       
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { imageData, _, error in
            guard let data = imageData, error == nil else {
                completion(nil)
                return
            }

            completion(UIImage(data: data))
        }
    }
}
