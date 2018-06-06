//
//  imagecache.swift
//  Apply GCD In Load Image URL
//
//  Created by nguyễn hữu đạt on 5/30/18.
//  Copyright © 2018 nguyễn hữu đạt. All rights reserved.
//


import Foundation
class CacheImage {
    static let images: NSCache<NSString, AnyObject> = {
        let result = NSCache<NSString, AnyObject>()
        result.countLimit = 15
        result.totalCostLimit = 10 * 1024 * 1024
        return result
    }()
}
