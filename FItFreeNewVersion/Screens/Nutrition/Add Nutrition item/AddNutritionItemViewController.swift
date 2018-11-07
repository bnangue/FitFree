//
//  AddNutritionItemViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import RealmSwift

class AddNutritionItemViewController: UIViewController {

    @IBOutlet weak var saveUIButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var lebensmittelTextField: UITextField!
    @IBOutlet weak var CategoryTextField: UITextField!
    @IBOutlet weak var portionDescriptionTextField: UITextField!
    @IBOutlet weak var portionSizeTextField: UITextField!
    @IBOutlet weak var portionUnitLabelText: UITextField!
    @IBOutlet weak var caloryPerPortiontextField: UITextField!
    @IBOutlet weak var caloryUnitLabeltext: UILabel!
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var barcodeButton: UIButton!
    
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
            
            guard let object = sender as? NutritionItem else { return }
            let destinationViewController = segue.destination as? HomeViewController
            destinationViewController?.lastNutritionItem = object
            
        }
    }
 
    
    @IBAction func saveFoodButtonPressed(_ sender: UIBarButtonItem) {
        let name =  lebensmittelTextField!.text
        let category = CategoryTextField!.text
        let servingDescription =  portionDescriptionTextField!.text
        let servingSize =  portionSizeTextField!.text
        let servingunit =  portionUnitLabelText!.text
        let calories =  caloryPerPortiontextField!.text

        
        if (name?.isEmpty)! {
            self.lebensmittelTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            self.lebensmittelTextField.layer.borderColor = UIColor.black.cgColor
        }
        if (category?.isEmpty)! {
            self.CategoryTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            self.CategoryTextField.layer.borderColor = UIColor.black.cgColor
        }
        if (servingDescription?.isEmpty)! {
            self.portionDescriptionTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            self.portionDescriptionTextField.layer.borderColor = UIColor.black.cgColor
        }
        if (servingSize?.isEmpty)! {
            self.portionSizeTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            self.portionSizeTextField.layer.borderColor = UIColor.black.cgColor
        }
        if (servingunit?.isEmpty)! {
            self.portionUnitLabelText.layer.borderColor = UIColor.red.cgColor
        } else {
            self.portionUnitLabelText.layer.borderColor = UIColor.black.cgColor
        }
        if (calories?.isEmpty)! {
            self.caloryPerPortiontextField.layer.borderColor = UIColor.red.cgColor
        } else {
            self.caloryPerPortiontextField.layer.borderColor = UIColor.black.cgColor
        }
      
        
        let nutritionItem = NutritionItem()
        nutritionItem.setValue(self.lebensmittelTextField.text, forKey: "name")
        nutritionItem.setValue(self.CategoryTextField.text, forKey: "category")
        nutritionItem.setValue(self.portionDescriptionTextField.text, forKey: "servingDescription")
        nutritionItem.setValue(self.portionSizeTextField.text, forKey: "servingSize")
        nutritionItem.setValue(self.portionUnitLabelText.text, forKey: "servingUnit")
        nutritionItem.setValue(self.caloryPerPortiontextField.text, forKey: "calories")
        
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.add(nutritionItem)
                
                print("Added \(nutritionItem.name) to Realm Database")
                
                self.lebensmittelTextField.text = ""
                self.CategoryTextField.text = ""
                self.portionDescriptionTextField.text = ""
                self.portionSizeTextField.text = ""
                self.portionUnitLabelText.text = ""
                self.caloryPerPortiontextField.text = ""
                
                self.performSegue(withIdentifier: "unwindToHomeViewController", sender: nutritionItem)
                
            }
        } catch {
            print(error)
        }

    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToNutritionHomeController", sender: self)

    }
    
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func barcodeButtonPressed(_ sender: UIButton) {
    }
}
