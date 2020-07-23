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

    //var componentsTypeSelected : CategoryType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let heading1 = Heading { component in
//            component.itemTitle = "teste"
//            component.add(view: Spacer(space: Ocean.size.spacingInsetMd))
//        }
//        self.add(view: heading1 )
//        let heading1 = TitleDescription { component in
//            component.itemTitle = title
//            component.add(view: Spacer(space: Ocean.size.spacingInsetMd))
//        }
        //self.add(view: titleDescripition )
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentsCell", for: indexPath) as! StandardCell
        let components = Components.list
        cell.title.text = components[indexPath.row]
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Components.list.count
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        //self.categoryTypeSelected = CategoryType.init(rawValue: indexPath.row)
        return indexPath
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }


}
