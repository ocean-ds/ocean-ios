//
//  ViewController.swift
//  OceanDesignSystem
//
//  Created by Alexandro Gomes on 26/06/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens

class TokensViewController: UITableViewController {

    var categoryTypeSelected : CategoryType!
    
    //@IBOutlet weak var labelTest: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StandardCell", for: indexPath) as! StandardCell
        let categories = Categories.loadCategories()
        let category = categories[indexPath.row]
        cell.title.text = category
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Categories.loadCategories().count
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.categoryTypeSelected = CategoryType.init(rawValue: indexPath.row)
        return indexPath
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Create a variable that you want to send
        
        // Create a new variable to store the instance of PlayerTableViewController
        let destinationVC = segue.destination as! TokensByCategoryViewController
        destinationVC.categoryType = self.categoryTypeSelected
    }
}

