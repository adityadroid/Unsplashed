//
//  Wallpaper.swift
//  Unsplashed
//
//  Created by Aditya Gurjar on 7/8/17.
//  Copyright © 2017 Aditya Gurjar. All rights reserved.
//
import UIKit
import Foundation
public class Wallpaper{
    
    var name: String
    var photo: UIImage
    var rating: Int
    
    init(name: String, photo: UIImage, rating: Int) {
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
