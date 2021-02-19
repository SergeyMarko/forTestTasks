//
//  ImageCache.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/20/21.
//

import Foundation
import UIKit

class ImageCache {
    
    static let shared = ImageCache.init()
    
    private let config: Config
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    
    private init(config: Config = Config.defaultConfig) {
        self.config = config
    }
    
    struct Config {
        
        let memoryLimit: Int
        static let defaultConfig = Config(memoryLimit: 1024 * 1024 * 100)
    }
}

extension ImageCache {
    
    func insertImage(_ image: UIImage?, forKey url: URL) {
        guard let image = image else { return removeImage(forKey: url) }
        imageCache.setObject(image as AnyObject, forKey: url as AnyObject)
    }
    
    func image(forKey url: URL) -> UIImage? {
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            return image
        }
        
        return nil
    }
    
    func removeImage(forKey url: URL) {
        imageCache.removeObject(forKey: url as AnyObject)
    }
}
