//
//  RightSideMenuTableViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit

struct DateRecord {
    var imageLogo : UIImage?
    var data : String?
}

struct SectionObject {
    var sectionName : String?
    var sectionObject : DateRecord?
}


class RightSideMenuTableViewController: UITableViewController {

     var sections = [SectionObject(sectionName: "Laufen", sectionObject: DateRecord(imageLogo: #imageLiteral(resourceName: "icons8-laufen-filled-50"), data: "24.000 Schritte")),SectionObject(sectionName: "Fahrradfahren", sectionObject: DateRecord(imageLogo: #imageLiteral(resourceName: "icons8-radfahren-auf-straße-50"), data: "23.9 Km")),SectionObject(sectionName: "Kalorienverbrauch", sectionObject: DateRecord(imageLogo: #imageLiteral(resourceName: "icons8elementfeuer"), data: "804.23 Kcal")), SectionObject(sectionName: "Schlafen", sectionObject: DateRecord(imageLogo: #imageLiteral(resourceName: "icons8-schlafen-im-bett-50"), data: "Keine Daten"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.sections[section]
        
        return section.sectionName
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rightSideMenuCell", for: indexPath) as! RightSideMenuTableViewCell

        // Configure the cell... let section = self.sections[indexPath.section]
        let section = self.sections[indexPath.section]
        let dataRecord = section.sectionObject
        
        cell.imageSideMenu.image = dataRecord?.imageLogo
        cell.labelSideMenu.text = dataRecord?.data

        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
}
