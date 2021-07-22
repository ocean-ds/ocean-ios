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
        let selected = DSComponents.list[indexPath.row]
        self.designSystemComponentsTypeSelected = DesignSystemComponentsType(rawValue: selected)
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch self.designSystemComponentsTypeSelected! {
        case DesignSystemComponentsType.Input:
            performSegue(withIdentifier: "SegueInputComponents", sender: self)
        case DesignSystemComponentsType.Snackbar:
            performSegue(withIdentifier: "SegueSnackbarComponents", sender: self)
        case DesignSystemComponentsType.Button:
            performSegue(withIdentifier: "SegueButtonsComponents", sender: self)
        case DesignSystemComponentsType.Switch:
            performSegue(withIdentifier: "SegueSwitchComponents", sender: self)
        case DesignSystemComponentsType.BottomSheet:
            performSegue(withIdentifier: "SegueBottomSheetComponents", sender: self)
        case DesignSystemComponentsType.RadioButton:
            performSegue(withIdentifier: "SegueRadioButtonComponents", sender: self)
        case DesignSystemComponentsType.DatePicker:
            performSegue(withIdentifier: "SegueDatePickerComponents", sender: self)
        case DesignSystemComponentsType.AlertBox:
            performSegue(withIdentifier: "SegueAlertBoxComponents", sender: self)
        case DesignSystemComponentsType.Divider:
            performSegue(withIdentifier: "SegueDividerComponents", sender: self)
        case DesignSystemComponentsType.Tooltip:
            performSegue(withIdentifier: "SegueTooltipComponents", sender: self)
        case DesignSystemComponentsType.TextList:
            performSegue(withIdentifier: "SegueTextListComponents", sender: self)
        case DesignSystemComponentsType.NavigationBar:
            let navigationController = UINavigationController(rootViewController: NavigationBarViewController())
            navigationController.modalTransitionStyle = .coverVertical
            navigationController.modalPresentationStyle = .overFullScreen
            self.present(navigationController, animated: true, completion: nil)
        default:
            performSegue(withIdentifier: "SegueComponentTypeView", sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (self.designSystemComponentsTypeSelected == DesignSystemComponentsType.Typography) {
            let destinationVC = segue.destination as? ComponentTypeViewController
            destinationVC?.designSystemComponentsType = self.designSystemComponentsTypeSelected
        }
    }
}
