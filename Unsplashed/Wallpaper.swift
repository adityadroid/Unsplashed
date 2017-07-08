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
    var id: String
    var fullSizeURL : String
    
    init(id: String, name: String, photo: UIImage, rating: Int, fullSizeURL : String) {
        self.name = name
        self.photo = photo
        self.rating = rating
        self.id = id
        self.fullSizeURL = fullSizeURL
    }
}
