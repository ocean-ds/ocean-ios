//
//  ComponentsSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 18/08/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens
import OceanComponents

class ComponentsSwiftUIViewController: UITableViewController {
    var designSystemComponentsTypeSelected : DesignSystemComponentsSwiftUIType!

    let componentList = DSComponents.listSwiftUI.sorted()

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
        self.designSystemComponentsTypeSelected = DesignSystemComponentsSwiftUIType(rawValue: selected)
        return indexPath
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch self.designSystemComponentsTypeSelected! {
        case .Alert:
            self.present(AlertSwiftUIViewController(), animated: true, completion: nil)
        case .Button:
            self.present(ButtonSwiftUIViewController(), animated: true, completion: nil)
        case .Link:
            self.modalPresentationStyle = .fullScreen
            self.present(LinkSwiftUIViewController(), animated: true, completion: nil)
        case .OrderedListItem:
            self.present(OrderedListItemSwiftUIViewController(), animated: true, completion: nil)
        case .ProgressIndicator:
            self.present(CircularProgressIndicatorSwiftUIViewController(), animated: true, completion: nil)
        case .StatusListItem:
            self.present(StatusListItemSwiftUIViewController(), animated: true, completion: nil)
        case .Tag:
            self.present(TagSwiftUIViewController(), animated: true, completion: nil)
        case .Typography:
            self.present(TypographySwiftUIViewController(), animated: true, completion: nil)
        case .Badge:
            self.present(BadgeSwiftUIViewController(), animated: true, completion: nil)
        case .CardListItem:
            self.present(CardListItemSwiftUIViewController(), animated: true, completion: nil)
        case .Accordion:
            self.present(AccordionSwiftUIViewController(), animated: true, completion: nil)
        case .Divider:
            self.present(DividerSwiftUIViewController(), animated: true, completion: nil)
        case .Input:
            self.present(InputSwiftUIViewController(), animated: true, completion: nil)
        case .FilterBar:
            self.present(FilterBarSwiftUIViewController(), animated: true, completion: nil)
        case .Tab:
            self.present(TabSwiftUIViewController(), animated: true, completion: nil)
        case .Subheader:
            self.present(SubheaderSwiftUIViewController(), animated: true, completion: nil)
        case .TransactionListItem:
            self.present(TransactionListItemSwiftUIViewController(), animated: true, completion: nil)
        case .FileUploader:
            self.present(FileUploaderSwiftUIViewController(), animated: true, completion: nil)
        case .InvertedTextListItem:
            self.present(InvertedTextListItemSwiftUIViewController(), animated: true, completion: nil)
        case .RadioButtonGroup:
            self.present(RadioButtonGroupSwiftUIViewController(), animated: true, completion: nil)
        case .CheckboxGroup:
            self.present(CheckboxGroupSwiftUIViewController(), animated: true, completion: nil)
        }
    }
}
