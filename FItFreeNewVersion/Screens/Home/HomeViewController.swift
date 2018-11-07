//
//  FirstViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import SideMenu
import RealmSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionViewHorizontalExperience: UICollectionView!
    @IBOutlet weak var summaryCompactViewHomeScreen: UIView!
    
 
    @IBOutlet weak var caloriesLastAddedActivity: UILabel!
    @IBOutlet weak var lastAddedActivity: UILabel!
    var  lasActivitySport: ActivitySport!
    
    
    @IBOutlet weak var LastAddedNutritionItem: UILabel!
    @IBOutlet weak var lastAddedCaloriesNutrition: UILabel!
    var  lastNutritionItem: NutritionItem!
    
    @IBOutlet weak var categoryWaterUIView: UIView!
    @IBOutlet weak var aktivitätUIView: UIView!
    @IBOutlet weak var ernaehrungUIVIew: UIView!
    
    @IBOutlet weak var imageWaterIntake1: UIButton!
    @IBOutlet weak var imageWaterIntake2: UIButton!
    @IBOutlet weak var imageWaterIntake3: UIButton!
    @IBOutlet weak var imageWaterIntake4: UIButton!
    @IBOutlet weak var imageWaterIntake5: UIButton!
    @IBOutlet weak var imageWaterIntake6: UIButton!
    @IBOutlet weak var imageWaterIntake7: UIButton!
    @IBOutlet weak var imageWaterIntake8: UIButton!

    @IBOutlet weak var waterIntakePercentage: UILabel!
    @IBOutlet weak var waterLiterIndicator: UILabel!
    
    @IBAction func actionSheetButtonPressed(sender: UIButton) {
        let alert = UIAlertController(title: "My Alert", message: "This is an action sheet.", preferredStyle: .actionSheet) // 1
        let firstAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
            NSLog("You pressed button one")
        } // 2
        
        let secondAction = UIAlertAction(title: "Cancel", style: .default) { (alert: UIAlertAction!) -> Void in
            NSLog("You pressed button two")
        } // 3
        
        alert.addAction(firstAction) // 4
        alert.addAction(secondAction) // 5
        present(alert, animated: true, completion:nil) // 6
    }
    
    @IBAction func infoWhereToGoAlertButtonPressed(sender: UIButton) {
        let alert = UIAlertController(title: "Info", message: "Finde tolle Location in deiner Näher die zu deiner Ernährung und Portemonaie passen", preferredStyle: .alert) // 1
        let firstAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
            NSLog("You pressed button one")
        } // 2
        
        
        alert.addAction(firstAction) // 4
        present(alert, animated: true, completion:nil) // 6
    }
    @IBAction func infoSummaryButtonPressed(sender: UIButton) {
        let alert = UIAlertController(title: "Info", message: "Finde tolle Location in deiner Näher die zu deiner Ernährung und Portemonaie passen", preferredStyle: .alert) // 1
        let firstAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
            NSLog("You pressed button one")
        } // 2
        
        
        alert.addAction(firstAction) // 4
        present(alert, animated: true, completion:nil) // 6
    }
    var waterIntakeButtons: [UIButton] = []
    
    @IBAction func imageBtn1(_ sender: UIButton) {
        
        if imageIsEqualTo(image1: sender.currentImage!, isEqualTo: UIImage(named: "icons8-wodkaglas-filled-50")!) == true {
            
            sender.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)
            
            let percentage = (0*100)/8
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 0) + " L from 2 L recommended daily intake"
           
        }else {
            let percentage = (1*100)/8
            sender.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 1) + " L from 2 L recommended daily intake"
            for i in 0 ..< 1 {
                let button =  waterIntakeButtons[i]
                
                button.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
                
            }
        }
         for i in 1 ..< 8 {
         let button =  waterIntakeButtons[i]
         
            button.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)

         
         }
 
    }
    
    @IBAction func imageBtn2(_ sender: UIButton) {
        
        if imageIsEqualTo(image1: imageWaterIntake2.currentImage!, isEqualTo: UIImage(named: "icons8-wodkaglas-filled-50")!) == true {
            
            sender.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)
            
            let percentage = (1*100)/8
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 1) + " L from 2 L recommended daily intake"
            for i in 0 ..< 1 {
                let button =  waterIntakeButtons[i]
                
                button.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
                
            }
        }else {
            let percentage = (2*100)/8
            imageWaterIntake2.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 2) + " L from 2 L recommended daily intake"
            for i in 0 ..< 2 {
                let button =  waterIntakeButtons[i]
                
                button.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
                
            }
        }
       
        for i in 2 ..< 8 {
            let button =  waterIntakeButtons[i]
            
            button.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)
            
            
        }
    }
    @IBAction func imageBtn3(_ sender: UIButton) {
        
        if imageIsEqualTo(image1: sender.currentImage!, isEqualTo: UIImage(named: "icons8-wodkaglas-filled-50")!) == true {
            
            sender.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)
            
            let percentage = (2*100)/8
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 2) + " L from 2 L recommended daily intake"
            
        }else {
            let percentage = (3*100)/8
            sender.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 3) + " L from 2 L recommended daily intake"
            for i in 0 ..< 3 {
                let button =  waterIntakeButtons[i]
                
                button.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
                
            }
        }
        for i in 3 ..< 8 {
            let button =  waterIntakeButtons[i]
            
            button.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)
            
            
        }
    }
    
    @IBAction func imageBtn4(_ sender: UIButton) {
        if imageIsEqualTo(image1: sender.currentImage!, isEqualTo: UIImage(named: "icons8-wodkaglas-filled-50")!) == true {
            
            sender.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)
            
            let percentage = (3*100)/8
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 3) + " L from 2 L recommended daily intake"
            
        }else {
            let percentage = (4*100)/8
            sender.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 4) + " L from 2 L recommended daily intake"
            for i in 0 ..< 4 {
                let button =  waterIntakeButtons[i]
                
                button.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
                
            }
        }
        for i in 4 ..< 8 {
            let button =  waterIntakeButtons[i]
            
            button.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)
            
            
        }
    }
    @IBAction func imageBtn5(_ sender: UIButton) {
        if imageIsEqualTo(image1: sender.currentImage!, isEqualTo: UIImage(named: "icons8-wodkaglas-filled-50")!) == true {
            
            sender.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)
            
            let percentage = (4*100)/8
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 4) + " L from 2 L recommended daily intake"
            
        }else {
            let percentage = (5*100)/8
            sender.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 5) + " L from 2 L recommended daily intake"
            for i in 0 ..< 5 {
                let button =  waterIntakeButtons[i]
                
                button.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
                
            }
        }
        for i in 5 ..< 8 {
            let button =  waterIntakeButtons[i]
            
            button.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)
            
            
        }
    }
    
    @IBAction func imageBtn6(_ sender: UIButton) {
        if imageIsEqualTo(image1: sender.currentImage!, isEqualTo: UIImage(named: "icons8-wodkaglas-filled-50")!) == true {
            
            sender.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)
            
            let percentage = (5*100)/8
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 5) + " L from 2 L recommended daily intake"
            
        }else {
            let percentage = (6*100)/8
            sender.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 6) + " L from 2 L recommended daily intake"
            for i in 0 ..< 6 {
                let button =  waterIntakeButtons[i]
                
                button.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
                
            }
        }
        for i in 6 ..< 8 {
            let button =  waterIntakeButtons[i]
            
            button.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)
            
            
        }
    }
    @IBAction func imageBtn7(_ sender: UIButton) {
        if imageIsEqualTo(image1: sender.currentImage!, isEqualTo: UIImage(named: "icons8-wodkaglas-filled-50")!) == true {
            
            sender.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)
            
            let percentage = (6*100)/8
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 6) + " L from 2 L recommended daily intake"
            
        }else {
            let percentage = (7*100)/8
            sender.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 7) + " L from 2 L recommended daily intake"
            for i in 0 ..< 7 {
                let button =  waterIntakeButtons[i]
                
                button.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
                
            }
        }
        for i in 7 ..< 8 {
            let button =  waterIntakeButtons[i]
            
            button.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)
            
            
        }
    }
    @IBAction func imageBtn8(_ sender: UIButton) {
        
        // a glas is 0.25L 
        if imageIsEqualTo(image1: sender.currentImage!, isEqualTo: UIImage(named: "icons8-wodkaglas-filled-50")!) == true {
            
            sender.setImage(UIImage(named: "icons8-wodkaglas-50"), for: .normal)
            
            let percentage = (7*100)/8
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 7) + " L from 2 L recommended daily intake"
            
        }else {
            let percentage = (8*100)/8
            sender.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
            waterIntakePercentage.text = String(Int(percentage)) + " %"
            
            waterLiterIndicator.text = String(0.25 * 8) + " L from 2 L recommended daily intake"
        }
        for i in 0 ..< 7 {
            let button =  waterIntakeButtons[i]
            button.setImage(UIImage(named: "icons8-wodkaglas-filled-50"), for: .normal)
        }
 
    }
    
    
    /*
    @IBAction func openMapView(_sender: UIView){
    
        //let placeSearchVC = PlaceSearchViewController()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ParentViewController") as! ParentViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        //self.present(placeSearchVC, animated: true, completion: nil)
        //self.navigationController?.pushViewController(placeSearchVC, animated: true)
    }
    */
    
    func imageIsEqualTo(image1: UIImage, isEqualTo image2: UIImage) -> Bool {
        let data1: NSData = image1.pngData()! as NSData
        let data2: NSData = image2.pngData()! as NSData
        return data1.isEqual(data2)
    }
    
   var interests = Interest.fetchInterests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupSideMenu()
        initUIView()
        waterIntakeButtons = [imageWaterIntake1, imageWaterIntake2, imageWaterIntake3, imageWaterIntake4, imageWaterIntake5, imageWaterIntake6, imageWaterIntake7, imageWaterIntake8]
        fetchLastadded()
    }

    func fetchLastadded() {
        let realm = try! Realm()
        let activities = Array(realm.objects(ActivitySport.self))
        if activities.count > 0
        {
            lasActivitySport = activities[activities.count - 1]
            
            lastAddedActivity.text = lasActivitySport.name + " (" + lasActivitySport.category + ")"
            caloriesLastAddedActivity.text = lasActivitySport.calories + " Kcal"
        }
    
        let nutritionItems = Array(realm.objects(NutritionItem.self))
        if nutritionItems.count > 0
        {
            lastNutritionItem = nutritionItems[nutritionItems.count - 1]
            
            LastAddedNutritionItem.text = lastNutritionItem.name + " (" + lastNutritionItem.category + ")"
            lastAddedCaloriesNutrition.text = lastNutritionItem.calories + " Kcal"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        collectionViewHorizontalExperience.dataSource = self
        collectionViewHorizontalExperience.delegate = self
    }

    fileprivate func initUIView(){
        summaryCompactViewHomeScreen.layer.borderWidth = 0.5
        summaryCompactViewHomeScreen.layer.borderColor = UIColor.lightGray.cgColor
        summaryCompactViewHomeScreen.layer.cornerRadius = 10
        
        categoryWaterUIView.layer.borderWidth = 0.5
        categoryWaterUIView.layer.borderColor = UIColor.lightGray.cgColor
        categoryWaterUIView.layer.cornerRadius = 10
        
        aktivitätUIView.layer.borderWidth = 0.5
        aktivitätUIView.layer.borderColor = UIColor.lightGray.cgColor
        aktivitätUIView.layer.cornerRadius = 10
        
        ernaehrungUIVIew.layer.borderWidth = 0.5
        ernaehrungUIVIew.layer.borderColor = UIColor.lightGray.cgColor
        ernaehrungUIVIew.layer.cornerRadius = 10
        
    }
    
    fileprivate func setupSideMenu() {
        
        let menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as! UISideMenuNavigationController
        
        SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        
        // Set up a cool background image for demo purposes
        // SideMenuManager.default.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    @IBAction func unwindToHomeViewController(segue: UIStoryboardSegue){
        //Check which Controller triggered the action
        if segue.source is AddNewActivityViewController || segue.source is AddNutritionItemViewController || segue.source is SingleActivityViewController || segue.source is NutritionItemViewController{
            
            fetchLastadded()
                // get last added sport activity and calories to show
              /*
 
                lastAddedActivity.text = lasActivitySport.name
                caloriesLastAddedActivity.text = lasActivitySport.calories + " Kcal"
                print("\(String(describing: lasActivitySport.name)) \(String(describing: lasActivitySport.calories))")
            */
        }
    }
}
extension HomeViewController: UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionViewHorizontalExperience {
            return interests.count
        }else {
            return 3
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vC = storyBoard.instantiateViewController(withIdentifier: "LastVisitedRestaurantViewController") as! LastVisitedRestaurantViewController
        // replace with live data
        let restaurantLastvisited = LastVisitedLocation()
        restaurantLastvisited.name = "Hops & Hominy"
        restaurantLastvisited.date = "Do. 22.09.18"
        restaurantLastvisited.yelpId = "AoxdFkE06fQs_ZP0S0VRPw"
        
        
        vC.restaurantLastVisited = restaurantLastvisited
        self.navigationController?.show(vC, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == collectionViewHorizontalExperience {
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "experienceCollectionHorizontalCell", for: indexPath) as! HomeExperienceHorizontalCollectionViewCell
        
        cell.interest = interests[indexPath.item]
        
        return cell
    }
    
}
extension HomeViewController: UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionViewHorizontalExperience.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
    }
}

