//
//  WallPaperDetailViewController.swift
//  Unsplashed
//
//  Created by Aditya Gurjar on 7/8/17.
//  Copyright © 2017 Aditya Gurjar. All rights reserved.
//

import Foundation
import UIKit
class WallPaperDetailViewController : UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var img : UIImage!

      override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        loadWallPaper(url: URL(string:currentWallPaper.fullSizeURL)!)
           }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }
    @IBAction func backButton(_ sender: UIButton) {
            dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveImage(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(img!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Done!", message: "Image has been saved!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadWallPaper(url : URL){
        
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let data = data{
                
                self.img = UIImage(data: data)
                
                
                self.imageView.image = self.img
            }
            
            }.resume()
    }
    
    
    
}
