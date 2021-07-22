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

class ComponentTypeViewController: UITableViewController {
    
    var designSystemComponentsType : DesignSystemComponentsType!
    var designSystemTypographyTypeSelected : DesignSystemTypographyType!
    var designSystemButtonTypeSelected : DesignSystemButtonType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch designSystemComponentsType {
        case .Typography:
            
            let cell = self.getTypographyComponents(indexPath)
            return cell
            
        case .Button:
            
            let cell = self.getButtonComponents(indexPath)
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (designSystemComponentsType == DesignSystemComponentsType.Typography) {
            return DSTypographies.list.count
        } else if (designSystemComponentsType == DesignSystemComponentsType.Button) {
            return DSButtons.list.count
        }
        return 0
        
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch designSystemComponentsType {
        case .Typography:
            self.designSystemTypographyTypeSelected = DesignSystemTypographyType.init(rawValue: indexPath.row)
            break
        case .Button:
            self.designSystemButtonTypeSelected = DesignSystemButtonType.init(rawValue: indexPath.row)
            break
        default:
            break
        }
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
        if (designSystemComponentsType == DesignSystemComponentsType.Typography) {
            destinationVC.designSystemTypographyType = self.designSystemTypographyTypeSelected
        } else if (designSystemComponentsType == DesignSystemComponentsType.Button) {
            destinationVC.designSystemButtonType = self.designSystemButtonTypeSelected
        }
    }
    
    private func getTypographyComponents(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentTypeCell", for: indexPath) as! StandardCell
        let tipographies = DSTypographies.list
        cell.title.text = tipographies[indexPath.row]
        return cell
    }
    
    private func getButtonComponents(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentTypeCell", for: indexPath) as! StandardCell
        let buttons = DSButtons.list
        cell.title.text = buttons[indexPath.row]
        return cell
    }
}
