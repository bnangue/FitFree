//
//  NutritionViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import  RealmSwift

struct ResponseData: Decodable {
    var foodList: [Food]

}
struct Food : Decodable {
    var Lebensmittel: String
    var Kohlenhydrate: String
    var Energiedichte: String
    var Ballaststoffe: String
    var Alkohol: String
    var Kalorien: String
    var Fett: String
    var davonZucker: String
    
    // to macht my object variable with the json object and give a defauft value-- i could also use enum value with Codable
    /// Override the property name to match the respective JSON field name
    enum CodingKeys : String, CodingKey {
        case davonZucker = "davon Zucker"
        case Lebensmittel
        case Kohlenhydrate
        case Energiedichte
        case Ballaststoffe
        case Alkohol
        case Kalorien
        case Fett
    }

}
struct Category {
    let name : String
    var items : [AnyObject]
}

class NutritionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var barcodeButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var sections =  [Category]()
    var listOfNutritionItems: [NutritionItem] = []
    var listOfFoodItems: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
         tableView.tableFooterView = UIView(frame: .zero)
        loadJson()
        fetchData()
        
        sections = [Category(name: "Zuletzt verwendet", items: listOfNutritionItems), Category(name: "Lebensmittel", items: listOfFoodItems as [AnyObject])]
        
       tableView.reloadData()
        
    }
    
    func fetchData(){
        let realm = try! Realm()
        listOfNutritionItems = Array(realm.objects(NutritionItem.self))
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionTitle = sections[section].name
        if listOfNutritionItems.count == 0 && section == 0 {
            sectionTitle = "Einfügen oder aus der Liste wählen"
        }
        return sectionTitle
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nutritionTableCell", for: indexPath)
        
        let sectionData = self.sections[indexPath.section].items
        
            if indexPath.section == 0 {
                
                let nutritionItem  = sectionData[indexPath.row] as! NutritionItem
                cell.textLabel?.text = nutritionItem.name
                cell.detailTextLabel?.text = nutritionItem.category
                
                
            }
            if indexPath.section == 1 {
                
                let nutritionItem  = sectionData[indexPath.row] as! Food
                cell.textLabel?.text = nutritionItem.Lebensmittel
                cell.detailTextLabel?.text = "unbekannt"
            }
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         self.performSegue(withIdentifier: "SingleActivityToAdd", sender: activitiesArray[indexPath.row])
         print("There" + String.init(describing: activitiesArray[indexPath.row].name))
         */
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vC = storyBoard.instantiateViewController(withIdentifier: "NutritionItemViewController") as! NutritionItemViewController
        if indexPath.section == 0 {
            vC.nutritionItem = sections[indexPath.section].items[indexPath.row] as! NutritionItem
        } else {
            // open view for Lebensmittel
           // vC.nutritionItem = sections[indexPath.section].items[indexPath.row] as! Food
        }
        
        
        self.navigationController?.show(vC, sender: self)
        
    }
    
   
    
    func loadJson(){
    
        let  jsonUrl = "https://api.myjson.com/bins/7wmv0"
        
         let url = URL(string: jsonUrl)
        
        URLSession.shared.dataTask(with: url!) {(data, response, err) in
            
             guard let dataJs  = data else { return }
            
            do {
                let json = try JSONDecoder().decode([Food].self, from: dataJs)
               
               
               
                DispatchQueue.main.async {
                    self.listOfFoodItems = json
                    
                    self.sections = [Category(name: "Zuletzt verwendet", items: self.listOfNutritionItems), Category(name: "Lebensmittel", items: self.listOfFoodItems as [AnyObject])]
                    
                    self.tableView.reloadData()
                    
                }
                
            } catch let Jsonerror {
                print("error:\(Jsonerror)")
            }
        }.resume()
 
        
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func barcodeButtonPressed(_ sender: Any) {
        //open barcode scan view controller
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        //perform unwing segue
         self.performSegue(withIdentifier: "unwindToHomeViewController", sender: self)
    }
    
    @IBAction func unwindToNutritionHomeController(segue: UIStoryboardSegue){
        
    }
   
}
