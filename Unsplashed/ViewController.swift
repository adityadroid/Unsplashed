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

var currentWallPaper : Wallpaper!
class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate ,UITextFieldDelegate {
    
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
    @IBOutlet weak var dimmingView: UIVisualEffectView!
    @IBOutlet weak var collectionView: UICollectionView!
    var isHome : Bool = true
    var page : Int = 0
    var query : String!
    override func viewDidLoad() {
        super.viewDidLoad()
       // let img = UIImage(named: "A6B.jpeg")
//        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
//        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
//        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
//        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
//        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
//        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
//        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
//        items.append(Wallpaper(name: "name", photo: img!, rating: 1))
//        
        
        let str = NSAttributedString(string: "SEARCH", attributes: [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBold", size: 21)! ])
        searchField.attributedPlaceholder = str
        loadHomeImages(page:page)
     //   getImage("fog")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        dimmingView.alpha = 0.0
        menu = TabbarMenu(texture: .withBlur(blurStyle: .dark) ,tabbarHeight: 40.0, toTop: 200)
        setupMenu()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        menu.removeFromSuperview()
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
        cell.likesLabel.text = String(self.items[indexPath.row].rating)
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        currentWallPaper = items[indexPath.row]
        self.performSegue(withIdentifier: "openWallpaperSegue", sender: self)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.bounds.maxY == scrollView.contentSize.height) {
            print("end")
            page = page + 1
            if(isHome){
                print(page)
                loadHomeImages(page: page)
                
            }else{
                getImage(query, page: page)
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
       toggleDimView(alpha: 1.0)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
        toggleDimView(alpha: 0.0)
        query = searchField.text
        isHome = false
        if query != nil{
            
            items.removeAll()
            collectionView.reloadData()
            page = 0
            
            self.getImage(query!, page: page)
        }
        return true
    }
    
    @IBAction func homeAction(_ sender: UIButton) {
        page = 0
        items.removeAll()
        collectionView.reloadData()
        isHome = true
        loadHomeImages(page: page)
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
    
        searchField.resignFirstResponder()
        toggleDimView(alpha: 0.0)
        query = searchField.text

        if query.characters.count>0{
            isHome = false
            
            items.removeAll()
            collectionView.reloadData()
            page = 0
            self.getImage(query!,page : page)
        }
    }
    
    func toggleDimView(alpha : Float){
        
        UIView.animate(withDuration: 0.4, animations: {
            self.dimmingView.alpha = CGFloat(alpha)
        }, completion:nil)
    }
    
    
    func getImage(_ query : String, page : Int){
        let comp = query.components(separatedBy: " ")
        let defaultWords = 1
        //        for i in (0..<comp.count).reversed(){
        //
        //            if(comp[i]=="a"){
        //                defaultWords = comp.count-i
        //                break
        //            }
        //
        //        }
        var trimmedQuery = ""
        for i in (comp.count-defaultWords..<comp.count){
            
            trimmedQuery = trimmedQuery + comp[i]
            if(i != comp.count-1){
                trimmedQuery = trimmedQuery + "+"
            }
        }
        print(trimmedQuery)
        
        print("looking for image...")
        let url = URL(string: "https://api.unsplash.com/search/photos/?client_id=b0204a5caa5a8224f7a0946b7249f8c7b3859b9f7a8c7ca6c173cfd7cce988a9&query="+trimmedQuery+"&per_page=10&page=\(page)")
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            
            if(error != nil){
                
                print(error ?? "nil")
            }else{
                
                if let data = data {
                    
                    print(data)
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)  as! [String:Any]
                        if let results = jsonResult["results"] as? [[String : AnyObject]]{
                            // print("results")
                            if(results.count>0){
                                for result in results{
                                    
                                    
                                    let id = result["id"] as? String
                                    let rating = result["likes"] as? Int
                                    let name = result["user"]?["name"] as? String
                                  
                                    if let urls = result["urls"] as? [String : AnyObject]{
                                        
                                        if let thumb = urls["thumb"] as? String{
                                            
                                            print(thumb)
                                            let fullSize = urls["full"] as? String
                                            self.downloadImage(url: URL(string: thumb)!, id: id!,name : name!,rating : rating!, fullSize : fullSize!)
                                            //do something with the image
                                            // UIImage(data: )
                                            
                                        }
                                        
                                    }
 
                                }
                                
                            }else{
                                
                                print("No Results")
                                
                            }}
                        
                    }catch{
                        print("JSONconversion failed")
                    }
                }
            }
            
            
            
        }
        task.resume()
        
    }
    

    
    func loadHomeImages(page : Int){
       

        print("looking for image...")
        let url = URL(string: "https://api.unsplash.com/photos/?client_id=b0204a5caa5a8224f7a0946b7249f8c7b3859b9f7a8c7ca6c173cfd7cce988a9&order_by=latest&per_page=10&page=\(page)")
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            
            if(error != nil){
                
                print(error ?? "nil")
            }else{
                
                if let data = data {
                    
                    print(data)
                    do{
                        guard let results = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] else {
                            print("error trying to convert data to JSON")
                            return
                        }
                        
                            if(results.count>0){
                                for result in results{
                                    
                                    
                                    let id = result["id"] as? String
                                    let rating = result["likes"] as? Int
                                    let name = result["user"]?["name"] as? String
                                    
                                    if let urls = result["urls"] as? [String : AnyObject]{
                                        
                                        if let thumb = urls["thumb"] as? String{
                                            
                                            print(thumb)
                                            let fullSize = urls["full"] as? String
                                            self.downloadImage(url: URL(string: thumb)!, id: id!,name : name!,rating : rating!, fullSize : fullSize!)
                                            //do something with the image
                                            // UIImage(data: )
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            }else{
                                
                                print("No Results")
                                
                            }
                        
                    }catch{
                        print("JSONconversion failed")
                    }
                }
            }
            
            
            
        }
        task.resume()
        
    }
    

    func downloadImage(url: URL,id : String, name : String, rating : Int, fullSize : String) -> Void {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                
                //display the image
                let image  = UIImage(data: data)
                let wallpaper = Wallpaper(id: id, name: name, photo: image!, rating: rating,fullSizeURL : fullSize)
                self.items.append(wallpaper)
                self.collectionView.reloadData()
                print(wallpaper.name)
                print(wallpaper.rating)
            }
        }
    }

    
    
    
    //GET DATA FROM A URL
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
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
        
//        buttonNature.isUserInteractionEnabled = true
//        buttonFood.isUserInteractionEnabled = true
//        buttonLove.isUserInteractionEnabled = true
//        buttonLandscape.isUserInteractionEnabled = true
//        buttonMusic.isUserInteractionEnabled = true
//        buttonAnimals.isUserInteractionEnabled = true
////        
//        buttonNature.addGestureRecognizer(tapGesture)
//        buttonFood.addGestureRecognizer(tapGesture)
//        buttonLove.addGestureRecognizer(tapGesture)
//        buttonLandscape.addGestureRecognizer(tapGesture)
//        buttonMusic.addGestureRecognizer(tapGesture)
//        buttonAnimals.addGestureRecognizer(tapGesture)
        var buttons = [buttonNature, buttonFood, buttonLove, buttonLandscape, buttonMusic, buttonAnimals]
        

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
        buttons.append(buttonHappy)
        buttons.append(buttonRain)
        }
        
        for button in buttons{
            button?.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onMenuItemClicked(_:)))
            button?.addGestureRecognizer(tapGesture)
        }
        
    }
  
    func onMenuItemClicked(_ sender: UITapGestureRecognizer){
        menu.triggerAction()
        isHome = false
        items.removeAll()
        collectionView.reloadData()
        page = 0
        print("clicked")
        let button = sender.view as? UILabel
        print((button?.text)!)
      //  print(label.text!)
        query = button?.text
        getImage((button?.text)!, page: page)
    }
}
