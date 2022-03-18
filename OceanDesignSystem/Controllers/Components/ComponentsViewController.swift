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
            self.present(SwitchViewController(), animated: true, completion: nil)
        case .BottomSheet:
            performSegue(withIdentifier: "SegueBottomSheetComponents", sender: self)
        case .RadioButton:
            self.present(RadioButtonViewController(), animated: true, completion: nil)
        case .DatePicker:
            self.present(DatePickerViewController(), animated: true, completion: nil)
        case .AlertBox:
            self.present(AlertBoxViewController(), animated: true, completion: nil)
        case .Divider:
            self.present(DividerViewController(), animated: true, completion: nil)
        case .Tooltip:
            self.present(TooltipViewController(), animated: true, completion: nil)
        case .TextList:
            self.present(TextListViewController(), animated: true, completion: nil)
        case .NavigationBar:
            let navigationController = UINavigationController(rootViewController: NavigationBarViewController())
            navigationController.modalTransitionStyle = .coverVertical
            navigationController.modalPresentationStyle = .overFullScreen
            self.present(navigationController, animated: true, completion: nil)
        case .OptionCard:
            self.present(OptionCardViewController(), animated: true, completion: nil)
        case .CheckBox:
            self.present(CheckBoxViewController(), animated: true, completion: nil)
        case .ProgressIndicator:
            self.present(ProgressIndicatorViewController(), animated: true, completion: nil)
        case .BottomNavigationBar:
            self.present(BottomNavigationBarViewController(), animated: true, completion: nil)
        case .Carousel:
            self.present(CarouselViewController(), animated: true, completion: nil)
        case .Shortcut:
            self.present(ShortcutViewController(), animated: true, completion: nil)
        case .Balance:
            self.present(BalanceViewController(), animated: true, completion: nil)
        case .Tag:
            self.present(TagViewController(), animated: true, completion: nil)
        case .Badge:
            self.present(BadgeViewController(), animated: true, completion: nil)
        case .Card:
            self.present(CardViewController(), animated: true, completion: nil)
        case .TransactionList:
            self.present(TransactionListViewController(), animated: true, completion: nil)
        case .FloatVerticalMenuList:
            self.navigationController?.pushViewController(FloatVerticalMenuListViewController(), animated: true)
        case .CardContent:
            self.present(CardContentViewController(), animated: true, completion: nil)
        case .Subheader:
            self.present(SubheaderViewController(), animated: true, completion: nil)
        case .Step:
            self.present(StepViewController(), animated: true, completion: nil)
        case .Chips:
            self.present(ChipsViewController(), animated: true, completion: nil)
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
