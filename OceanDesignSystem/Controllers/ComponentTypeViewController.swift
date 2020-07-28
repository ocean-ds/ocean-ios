//
//  HeadingsViewController.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 24/07/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanComponents
import OceanTokens

class HeadingsViewController: UITableViewController {
    
    var designSystemComponentsType : DesignSystemComponentsType!
    var designSystemTypographyTypeSelected : DesignSystemTypographyType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypographyComponentsCell", for: indexPath) as! StandardCell
            let tipographies = DSTypographies.list
            cell.title.text = tipographies[indexPath.row]
            
            return cell
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DSTypographies.list.count
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.designSystemTypographyTypeSelected = DesignSystemTypographyType.init(rawValue: indexPath.row)
        return indexPath
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "SegueRenderComponents", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Create a variable that you want to send
       
       // Create a new variable to store the instance of PlayerTableViewController
       let destinationVC = segue.destination as! RenderComponentsViewController
        destinationVC.designSystemComponentsType = self.designSystemComponentsType
        destinationVC.designSystemTypographyType = self.designSystemTypographyTypeSelected
       
    }
}
