//
//  AddNewActivityViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewActivityViewController: UIViewController {

    @IBOutlet weak var activityNameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var caloryTextField: UITextField!
    
    @IBOutlet weak var saveItemButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "unwindToHomeViewController" {
            
            guard let object = sender as? ActivitySport else { return }
            let destinationViewController = segue.destination as? HomeViewController
            destinationViewController?.lasActivitySport = object
          
        }
    }
 

    @IBAction func saveItemClicked(_ sender: Any) {
        //save the new activity - to execute if save to database successful
        
        let activityName =  activityNameTextField!.text
        let category =  categoryTextField!.text
        let activityDescription =  descriptionTextField!.text
        let duration =  durationTextField!.text
        let calories =  caloryTextField!.text
       
        if (activityName?.isEmpty)! {
            self.activityNameTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            self.activityNameTextField.layer.borderColor = UIColor.black.cgColor
        }
        if (category?.isEmpty)! {
            self.categoryTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            self.categoryTextField.layer.borderColor = UIColor.black.cgColor
        }
        if (activityDescription?.isEmpty)! {
            self.descriptionTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            self.descriptionTextField.layer.borderColor = UIColor.black.cgColor
        }
        if (duration?.isEmpty)! {
            self.durationTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            self.durationTextField.layer.borderColor = UIColor.black.cgColor
        }
        if (calories?.isEmpty)! {
            self.caloryTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            self.caloryTextField.layer.borderColor = UIColor.black.cgColor
        }
        
        let activitySport = ActivitySport()
        activitySport.setValue(self.activityNameTextField.text, forKey: "name")
         activitySport.setValue(self.categoryTextField.text, forKey: "category")
         activitySport.setValue(self.descriptionTextField.text, forKey: "activityDescription")
         activitySport.setValue(self.durationTextField.text, forKey: "duration")
         activitySport.setValue(self.caloryTextField.text, forKey: "calories")
        
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.add(activitySport)
            
                print("Added \(activitySport.name) to Realm Database")
                
                self.activityNameTextField.text = ""
                 self.categoryTextField.text = ""
                 self.descriptionTextField.text = ""
                 self.durationTextField.text = ""
                 self.caloryTextField.text = ""
                
                 self.performSegue(withIdentifier: "unwindToHomeViewController", sender: activitySport)
                
            }
        } catch {
            print(error)
        }

        
       

    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        //return to previous page
        self.performSegue(withIdentifier: "unwindToActivityHomeController", sender: self)

    }
}
