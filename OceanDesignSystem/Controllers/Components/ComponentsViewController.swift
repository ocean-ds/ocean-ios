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

    let componentList = DSComponents.list.sorted()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentsCell", for: indexPath) as! StandardCell
        cell.title.text = componentList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return componentList.count
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let selected = componentList[indexPath.row]
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
        case .Modal:
            performSegue(withIdentifier: "SegueModalComponents", sender: self)
        case .RadioButton:
            self.present(RadioButtonViewController(), animated: true, completion: nil)
        case .DatePicker:
            let datePicker = Ocean.DatePicker()
            datePicker.navigationTitle = "Agendar para"
            datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 10, to: Date())!
            datePicker.datesToHide = [Calendar.current.date(byAdding: .day, value: 2, to: Date())!]
            datePicker.onCancel = {
                print("DatePicker cancel")
            }
            datePicker.onReleaseCalendar = { date in
                print("DatePicker \(date)")
            }
            datePicker.show(rootViewController: self)
        case .AlertBox:
            self.present(AlertBoxViewController(), animated: true, completion: nil)
        case .Divider:
            self.present(DividerViewController(), animated: true, completion: nil)
        case .FilterBar:
            let filterBarViewController = FilterBarViewController()
            filterBarViewController.modalPresentationStyle = .fullScreen
            self.present(filterBarViewController, animated: true, completion: nil)
        case .Tooltip:
            self.present(TooltipViewController(), animated: true, completion: nil)
        case .TextList:
            self.present(TextListViewController(), animated: true, completion: nil)
        case .NavigationBar:
            let navigationController = UINavigationController(rootViewController: NavigationBarViewController())
            navigationController.modalTransitionStyle = .coverVertical
            navigationController.modalPresentationStyle = .overFullScreen
            self.present(navigationController, animated: true, completion: nil)
        case .CardOption:
            self.present(CardOptionViewController(), animated: true, completion: nil)
        case .CardListItem:
            return self.present(CardListItemViewController(), animated: true, completion: nil)
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
        case .BalanceSimple:
            self.present(BalanceSimpleViewController(), animated: true, completion: nil)
        case .Tag:
            self.present(TagViewController(), animated: true, completion: nil)
        case .Badge:
            self.present(BadgeViewController(), animated: true, completion: nil)
        case .TransactionFooter:
            self.present(TransactionFooterViewController(), animated: true, completion: nil)
        case .TransactionList:
            self.present(TransactionListViewController(), animated: true, completion: nil)
        case .FloatVerticalMenuList:
            self.present(FloatVerticalMenuListViewController(), animated: true, completion: nil)
        case .Tab:
            self.present(TabViewController(), animated: true, completion: nil)
        case .CardGroup:
            self.present(CardGroupViewController(), animated: true, completion: nil)
        case .Subheader:
            self.present(SubheaderViewController(), animated: true, completion: nil)
        case .Step:
            self.present(StepViewController(), animated: true, completion: nil)
        case .Chips:
            self.present(ChipsViewController(), animated: true, completion: nil)
        case .ParentChildTextList:
            self.present(ParentChildTextListViewController(), animated: true, completion: nil)
        case .CardCrossSell:
            self.present(CardCrossSellViewController(), animated: true, completion: nil)
        case .GroupCTA:
            self.present(GroupCTAViewController(), animated: true, completion: nil)
        case .OrderedListItem:
            self.present(OrderedListItemViewController(), animated: true, completion: nil)
        case .SettingsListItem:
            self.present(SettingsListItemViewController(), animated: true, completion: nil)
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
