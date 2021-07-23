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
            case .Input:
                performSegue(withIdentifier: "SegueInputComponents", sender: self)
            case .Snackbar:
                performSegue(withIdentifier: "SegueSnackbarComponents", sender: self)
            case .Button:
                performSegue(withIdentifier: "SegueButtonsComponents", sender: self)
            case .Switch:
                performSegue(withIdentifier: "SegueSwitchComponents", sender: self)
            case .BottomSheet:
                performSegue(withIdentifier: "SegueBottomSheetComponents", sender: self)
            case .RadioButton:
                performSegue(withIdentifier: "SegueRadioButtonComponents", sender: self)
            case .DatePicker:
                performSegue(withIdentifier: "SegueDatePickerComponents", sender: self)
            case .AlertBox:
                performSegue(withIdentifier: "SegueAlertBoxComponents", sender: self)
            case .Divider:
                performSegue(withIdentifier: "SegueDividerComponents", sender: self)
            case .Tooltip:
                performSegue(withIdentifier: "SegueTooltipComponents", sender: self)
            case .TextList:
                performSegue(withIdentifier: "SegueTextListComponents", sender: self)
            case .NavigationBar:
                let navigationController = UINavigationController(rootViewController: NavigationBarViewController())
                navigationController.modalTransitionStyle = .coverVertical
                navigationController.modalPresentationStyle = .overFullScreen
                self.present(navigationController, animated: true, completion: nil)
            case .OptionCard:
                self.present(OptionCardViewController(), animated: true, completion: nil)
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
