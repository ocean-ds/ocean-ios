//
//  TokensByCategoryViewController.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 22/07/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens

enum SubCategoryTypograpyType: Int {
    case FontFamilyWithWeight
    case FontSize
    case FontLineHeight
}


class ColorCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var colorRender: UIView!
}

class TypographyCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
}

class TokensByCategoryViewController: UITableViewController {

    var categoryType : CategoryType!
    var subCategoryTypeSelected : SubCategoryTypograpyType!
    
    //@IBOutlet weak var labelTest: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = getCell(indexPath)
        return categoryCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch categoryType {
        case .Color:
            return Colors.list().count
        case .Shadow:
            return Shadows.list().count
        case .Typography:
            return Typographies.subCategories.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch categoryType {
        case .Typography:
            return 60
        default:
            return 200
        }
    }

    func getCell(_ indexPath: IndexPath) -> UITableViewCell {
        
        switch categoryType {
        case .Color:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! ColorCell
            let colors = Colors.list()
            //let keys : [String] = Array(colors.keys)
            let colorName = Colors.keys()[indexPath.row]
            cell.title.text = colorName
            cell.colorRender.backgroundColor = colors[colorName]
            return cell;
            
        case .Shadow:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! ColorCell
            let shadows = Shadows.list()
            
            let shadowName = Shadows.keys()[indexPath.row]
            cell.title.text = shadowName
            cell.colorRender.applyShadow2(parameters: shadows[shadowName]!)
            return cell;
        case .Typography:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StandardCell", for: indexPath) as! StandardCell
            let fontFamily = Typographies.subCategories[indexPath.row]
            cell.title.text = fontFamily
            return cell;
        default:
            return UITableViewCell()
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.subCategoryTypeSelected = SubCategoryTypograpyType.init(rawValue: indexPath.row)
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "SegueSubCategory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Create a variable that you want to send
        if (self.categoryType == CategoryType.Typography) {
                // Create a new variable to store the instance of PlayerTableViewController
                let destinationVC = segue.destination as! TokensBySubCategoryViewController
                destinationVC.subCategoryType = self.subCategoryTypeSelected
            
        }
       
        
    }
}


