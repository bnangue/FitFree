//
//  SingleActivityViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import RealmSwift
class SingleActivityViewController: UIViewController {

    @IBOutlet weak var activityNameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var caloryTextField: UITextField!
    @IBOutlet weak var recommandationLabelText: UILabel!
    @IBOutlet weak var durationTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var activitySport = ActivitySport()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    

    func updateUI(){
        activityNameTextField.text = activitySport.name
        categoryTextField.text = activitySport.category
        descriptionTextField.text = activitySport.activityDescription
        caloryTextField.text = activitySport.calories
         durationTextField.text = activitySport.duration
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveButtonPressed(_ sender: Any) {
        //save the activity
        
        let duration =  durationTextField!.text
        let calories =  caloryTextField!.text
        
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
        
        let newActivitySport = ActivitySport()
        newActivitySport.setValue(self.activityNameTextField.text, forKey: "name")
        newActivitySport.setValue(self.categoryTextField.text, forKey: "category")
        newActivitySport.setValue(self.descriptionTextField.text, forKey: "activityDescription")
        newActivitySport.setValue(self.durationTextField.text, forKey: "duration")
        newActivitySport.setValue(self.caloryTextField.text, forKey: "calories")
        
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.add(newActivitySport)
                
                print("Added \(newActivitySport.name) to Realm Database")
                
                self.performSegue(withIdentifier: "unwindToHomeViewController", sender: newActivitySport)
                
            }
        } catch {
            print(error)
        }

    }
    
}
