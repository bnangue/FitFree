//
//  ActivitiesViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import RealmSwift

class ActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addActivityButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var activitiesArray: [ActivitySport] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
         tableView.tableFooterView = UIView(frame: .zero)
        // Do any additional setup after loading the view.
        
        fetchData()
        tableView.reloadData()
    }
    

    func fetchData(){
        let realm = try! Realm()
        activitiesArray = Array(realm.objects(ActivitySport.self))
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SingleActivityToAdd"{
            
            guard let object = sender as? ActivitySport else { return }
            
            let viewControllerDestionation = segue.destination as? SingleActivityViewController
            viewControllerDestionation?.activitySport = object
             print("Here" + String.init(describing: object.name))
        }
    }
 */
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityTableCell", for: indexPath)
        
        let activitySport  = activitiesArray[indexPath.row]
        cell.textLabel?.text = activitySport.name
        cell.detailTextLabel?.text = activitySport.category
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
        let vC = storyBoard.instantiateViewController(withIdentifier: "SingleActivityViewController") as! SingleActivityViewController
        vC.activitySport = activitiesArray[indexPath.row]
        
        self.navigationController?.show(vC, sender: self)
        
    }

    
    @IBAction func backButtonPressed(_ sender: Any) {
        //return to preview screen
        self.performSegue(withIdentifier: "unwindToHomeViewController", sender: self)

    }
    
    @IBAction func unwindToActivityHomeController(segue: UIStoryboardSegue){
      
        
    }
}
