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



class TokensByCategoryViewController: UITableViewController {

    var categoryType : CategoryType!
    var subCategoryTypograpyTypeSelected : SubCategoryTypograpyType!
    var subCategorySizeTypeSelected : SubCategorySizeType!
    
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
            return Colors.list.count
        case .Shadow:
            return Shadows.list().count
        case .Typography:
            return Typographies.subCategories.count
        case .Size:
            return Sizes.subCategories.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch categoryType {
        case .Typography, .Size:
        
            return 60
            
        default:
            return 200
        }
    }

    func getCell(_ indexPath: IndexPath) -> UITableViewCell {
        
        switch categoryType {
        case .Color:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! ColorCell
            let colors = Colors.list
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
            switch indexPath.row {
            case 0:
                cell.colorRender.ocean.shadow.applyLevel1()
            case 1:
                cell.colorRender.ocean.shadow.applyLevel2()
            case 2:
                cell.colorRender.ocean.shadow.applyLevel3()
            case 3:
                cell.colorRender.ocean.shadow.applyLevel4()
            default:
                return UITableViewCell()
            }
            //cell.colorRender.applyShadow(parameters: shadows[shadowName]!)
            return cell;
        case .Typography:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StandardCell", for: indexPath) as! StandardCell
            let fontFamily = Typographies.subCategories[indexPath.row]
            cell.title.text = fontFamily
            return cell;
        case .Size:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StandardCell", for: indexPath) as! StandardCell
            let sizeType = Sizes.subCategories[indexPath.row]
            cell.title.text = sizeType
            return cell;
        default:
            return UITableViewCell()
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if( self.categoryType == CategoryType.Typography) {
            self.subCategoryTypograpyTypeSelected = SubCategoryTypograpyType.init(rawValue: indexPath.row)
        } else {
            self.subCategorySizeTypeSelected = SubCategorySizeType.init(rawValue: indexPath.row)
        }
        
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
            destinationVC.categoryType = categoryType
                destinationVC.subCategoryTypograpyType = self.subCategoryTypograpyTypeSelected
            
        }
        else if (self.categoryType == CategoryType.Size) {
            let destinationVC = segue.destination as! TokensBySubCategoryViewController
            destinationVC.categoryType = categoryType
            destinationVC.subCategorySizeType = self.subCategorySizeTypeSelected
        }
       
        
    }
}


