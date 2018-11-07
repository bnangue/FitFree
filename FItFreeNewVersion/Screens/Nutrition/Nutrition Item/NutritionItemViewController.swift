//
//  NutritionItemViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import RealmSwift

class NutritionItemViewController: UIViewController {

    @IBOutlet weak var nutritionItemNameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var portionDescriptionTextField: UITextField!
    @IBOutlet weak var portionSizetextField: UITextField!
    @IBOutlet weak var portionUnitLabelText: UILabel!
    @IBOutlet weak var caloryTextField: UITextField!
    
    @IBOutlet weak var recommandationLabelText: UILabel!
    @IBOutlet weak var saveItemButton: UIButton!
    
    var nutritionItem = NutritionItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    

    func updateUI() {
        nutritionItemNameTextField.text = nutritionItem.name
        categoryTextField.text = nutritionItem.category
        portionDescriptionTextField.text = nutritionItem.servingDescription
        portionSizetextField.text = nutritionItem.servingSize
        portionUnitLabelText.text = nutritionItem.servingUnit
         caloryTextField.text = nutritionItem.calories
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveItemButtonClicked(_ sender: UIButton) {
       
        let servingSize =  portionSizetextField!.text
        let calories =  caloryTextField!.text
        
        
      
        if (servingSize?.isEmpty)! {
            self.portionSizetextField.layer.borderColor = UIColor.red.cgColor
        } else {
            self.portionSizetextField.layer.borderColor = UIColor.black.cgColor
        }
        
        if (calories?.isEmpty)! {
            self.caloryTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            self.caloryTextField.layer.borderColor = UIColor.black.cgColor
        }
        
        
        
        let newNutritionItem = NutritionItem()
        newNutritionItem.setValue(self.nutritionItemNameTextField.text, forKey: "name")
        newNutritionItem.setValue(self.categoryTextField.text, forKey: "category")
        newNutritionItem.setValue(self.portionDescriptionTextField.text, forKey: "servingDescription")
        
        newNutritionItem.setValue(self.portionUnitLabelText.text, forKey: "servingUnit")
        newNutritionItem.setValue(self.portionSizetextField.text, forKey: "servingSize")
        newNutritionItem.setValue(self.caloryTextField.text, forKey: "calories")
        
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.add(newNutritionItem)
                
                print("Added \(newNutritionItem.name) to Realm Database")
                
                self.performSegue(withIdentifier: "unwindToHomeViewController", sender: newNutritionItem)
                
            }
        } catch {
            print(error)
        }


    }
    
}
