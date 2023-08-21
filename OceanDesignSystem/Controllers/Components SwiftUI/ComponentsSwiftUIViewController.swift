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
        case .Button:
            self.present(ButtonSwiftUIViewController(), animated: true, completion: nil)
        }
    }
}
