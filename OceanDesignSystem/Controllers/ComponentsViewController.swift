//
//  ComponentsViewController.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 15/07/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens
import OceanComponents

class ComponentsViewController: UITableViewController {

    var designSystemComponentsTypeSelected : DesignSystemComponentsType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentsCell", for: indexPath) as! StandardCell
        let components = DSComponents.list
        cell.title.text = components[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DSComponents.list.count
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.designSystemComponentsTypeSelected = DesignSystemComponentsType.init(rawValue: indexPath.row)
        return indexPath
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if (self.designSystemComponentsTypeSelected == DesignSystemComponentsType.TextArea) {
            performSegue(withIdentifier: "SegueTextAreaComponents", sender: self)
        } else if (self.designSystemComponentsTypeSelected == DesignSystemComponentsType.Snackbar) {
            performSegue(withIdentifier: "SegueSnackbarComponents", sender: self)
        } else {
            performSegue(withIdentifier: "SegueComponentTypeView", sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (self.designSystemComponentsTypeSelected != DesignSystemComponentsType.TextArea && self.designSystemComponentsTypeSelected != DesignSystemComponentsType.Snackbar) {
            let destinationVC = segue.destination as! ComponentTypeViewController
            destinationVC.designSystemComponentsType = self.designSystemComponentsTypeSelected
        }
        
    }
}
