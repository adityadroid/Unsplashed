//
//  ViewController.swift
//  GooeyTabbar
//
//  Created by KittenYang on 11/16/15.
//  Copyright © 2015 KittenYang. All rights reserved.
//

//
//Nature
//Food
//Music
//Landscape
//Couple
//Animals
//Rain
//Happy
//Love
//Road
import UIKit

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var items : [Wallpaper] = []
    var menu : TabbarMenu!
    private var buttonNature  : UILabel!
    private var buttonLandscape : UILabel!
    private var buttonLove : UILabel!
    private var buttonFood : UILabel!
    private var buttonMusic : UILabel!
    private var buttonAnimals : UILabel!
    private var buttonRain : UILabel!
    private var buttonHappy : UILabel!
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let img = UIImage(named: "A6B.jpeg")
        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
        
        let str = NSAttributedString(string: "Search", attributes: [NSForegroundColorAttributeName:UIColor.white])
        searchField.attributedPlaceholder = str
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        menu = TabbarMenu(texture: .withBlur(blurStyle: .dark) ,tabbarHeight: 40.0, toTop: 200)
        setupMenu()
        
    }
    
    
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! ItemCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
          cell.titleLabel.text = self.items[indexPath.item].name
        //cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
          cell.imageView.image=self.items[indexPath.row].photo
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    
    
    
    @IBAction func searchAction(_ sender: UIButton) {
    }
    
    func setupMenu(){
        let displayWidth: CGFloat = menu.frame.width
        let displayHeight : CGFloat = menu.frame.height
        print(displayHeight)
        print(displayWidth)
        
       
        let v1 = UIView(frame: CGRect(x: CGFloat(0), y: 250, width: displayWidth, height: CGFloat(2)))
        v1.backgroundColor = UIColor.gray
        menu.addSubview(v1)
        buttonNature = UILabel(frame: CGRect(x: CGFloat(10), y: 252, width: displayWidth, height: CGFloat(50))) 
        buttonNature.text = "NATURE"
        buttonNature.textAlignment = .center
        buttonNature.textColor = UIColor.white
        buttonNature.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: CGFloat(21))
        menu.addSubview(buttonNature)
        let v2 = UIView(frame: CGRect(x: CGFloat(0), y: 302, width: displayWidth, height: CGFloat(2)))
        v2.backgroundColor = UIColor.gray
        menu.addSubview(v2)
        
        buttonLandscape = UILabel(frame: CGRect(x: CGFloat(10), y: 304, width: displayWidth, height: CGFloat(50)))
        buttonLandscape.text = "LANDSCAPE"
        buttonLandscape.textAlignment = .center
        buttonLandscape.textColor = UIColor.white
        buttonLandscape.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: CGFloat(21))
        menu.addSubview(buttonLandscape)
        let v3 = UIView(frame: CGRect(x: CGFloat(0), y: 354, width: displayWidth, height: CGFloat(2)))
        v3.backgroundColor = UIColor.gray
        menu.addSubview(v3)
        
        
        buttonLove = UILabel(frame: CGRect(x: CGFloat(10), y: 356, width: displayWidth, height: CGFloat(50)))
        buttonLove.text = "LOVE"
        buttonLove.textAlignment = .center
        buttonLove.textColor = UIColor.white
        buttonLove.font = UIFont(name: "HelveticaNeue-CondensedBold", size: CGFloat(21))
        menu.addSubview(buttonLove)
        let v4 = UIView(frame: CGRect(x: CGFloat(0), y: 406, width: displayWidth, height: CGFloat(2)))
        v4.backgroundColor = UIColor.gray
        menu.addSubview(v4)
        
        
        buttonFood = UILabel(frame: CGRect(x: CGFloat(10), y: 408, width: displayWidth, height: CGFloat(50)))
        buttonFood.text = "FOOD"
        buttonFood.textAlignment = .center
        buttonFood.textColor = UIColor.white
        buttonFood.font = UIFont(name: "HelveticaNeue-CondensedBold", size: CGFloat(21))
        menu.addSubview(buttonFood)
        let v5 = UIView(frame: CGRect(x: CGFloat(0), y: 458, width: displayWidth, height: CGFloat(2)))
        v5.backgroundColor = UIColor.gray
        menu.addSubview(v5)
        
        
        buttonMusic = UILabel(frame: CGRect(x: CGFloat(10), y: 460, width: displayWidth, height: CGFloat(50)))
        buttonMusic.text = "MUSIC"
        buttonMusic.textAlignment = .center
        buttonMusic.textColor = UIColor.white
        buttonMusic.font = UIFont(name: "HelveticaNeue-CondensedBold", size: CGFloat(21))
        menu.addSubview(buttonMusic)
        let v6 = UIView(frame: CGRect(x: CGFloat(0), y: 510, width: displayWidth, height: CGFloat(2)))
        v6.backgroundColor = UIColor.gray
        menu.addSubview(v6)
        
        buttonAnimals = UILabel(frame: CGRect(x: CGFloat(10), y: 512, width: displayWidth, height: CGFloat(50)))
        buttonAnimals.text = "ANIMALS"
        buttonAnimals.textAlignment = .center
        buttonAnimals.textColor = UIColor.white
        buttonAnimals.font = UIFont(name: "HelveticaNeue-CondensedBold", size: CGFloat(21))
        menu.addSubview(buttonAnimals)
        let v7 = UIView(frame: CGRect(x: CGFloat(0), y: 562, width: displayWidth, height: CGFloat(2)))
        v7.backgroundColor = UIColor.gray
        menu.addSubview(v7)
        
        
        if(displayHeight>568){
        print("Large screen device")
        buttonRain = UILabel(frame: CGRect(x: CGFloat(10), y: 564, width: displayWidth, height: CGFloat(50)))
        buttonRain.text = "RAIN"
        buttonRain.textAlignment = .center
        buttonRain.textColor = UIColor.white
        buttonRain.font = UIFont(name: "HelveticaNeue-CondensedBold", size: CGFloat(21))
        menu.addSubview(buttonRain)
        let v8 = UIView(frame: CGRect(x: CGFloat(0), y: 614, width: displayWidth, height: CGFloat(2)))
        v8.backgroundColor = UIColor.gray
        menu.addSubview(v8)
        
        
        buttonHappy = UILabel(frame: CGRect(x: CGFloat(10), y: 616, width: displayWidth, height: CGFloat(50)))
        buttonHappy.text = "HAPPY"
        buttonHappy.textAlignment = .center
        buttonHappy.textColor = UIColor.white
        buttonHappy.font = UIFont(name: "HelveticaNeue-CondensedBold", size: CGFloat(21))
        menu.addSubview(buttonHappy)
        let v9 = UIView(frame: CGRect(x: CGFloat(0), y: 666, width: displayWidth, height: CGFloat(2)))
        v9.backgroundColor = UIColor.gray
            menu.addSubview(v9)
        
        }
        
    }
  
}
