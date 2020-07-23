//
//  TokensBySubCategories.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 23/07/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens

class TokensBySubCategoryViewController: UITableViewController {
    var categoryType : CategoryType!
    var subCategoryTypograpyType : SubCategoryTypograpyType!
    var subCategorySizeType : SubCategorySizeType!
    
    //@IBOutlet weak var labelTest: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.categoryType == CategoryType.Typography) {
            let categoryCell = getCellSubCategoryTypograpy(indexPath)
            return categoryCell
        }
        let categoryCell = getCellSubCategorySize(indexPath)
        return categoryCell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.categoryType == CategoryType.Typography) {
            switch subCategoryTypograpyType {
            case .FontFamilyWithWeight:
                return Typographies.fontFamilies.count
            case .FontSize:
                return Typographies.fontSizes.count
            case .FontLineHeight:
                return Typographies.lineHeights.count
            
            default:
                return 0
            }
        } else if (self.categoryType == CategoryType.Size) {
            switch subCategorySizeType {
            case .Border:
                return Borders.list.count
            case .Opacity:
                return Opacities.list.count
            case .SpacingInline:
                return Spaces.list.count
            default:
                return 0
            }
        }
        return 0;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.categoryType == CategoryType.Size) {
           return 120
        }
        return 200
        
    }

    func getCellSubCategoryTypograpy(_ indexPath: IndexPath) -> UITableViewCell {
        
        switch subCategoryTypograpyType {
        case .FontFamilyWithWeight:

            let cell = tableView.dequeueReusableCell(withIdentifier: "SubTypographyCell", for: indexPath) as! TypographyCell
            let fontFamilyKey = Typographies.fontFamiliesKeys()[indexPath.row]
            cell.title.text = fontFamilyKey
            
            cell.subTitle.text = Typographies.fontFamilies[fontFamilyKey]
            cell.subTitle.font = UIFont(name: Typographies.fontFamilies[fontFamilyKey]!, size: 20.0)
            return cell;
            
        case .FontSize:

            let cell = tableView.dequeueReusableCell(withIdentifier: "SubTypographyCell", for: indexPath) as! TypographyCell
            let fontSizeKey = Typographies.fontSizesKeys()[indexPath.row]
            cell.title.text = fontSizeKey
            cell.subTitle.text = String(Typographies.fontSizes[fontSizeKey]!)
            cell.subTitle.font = UIFont(name: Ocean.font.fontFamilyBaseWeightLight, size: CGFloat(Typographies.fontSizes[fontSizeKey]!))
            
            return cell;
        case .FontLineHeight:

                   let cell = tableView.dequeueReusableCell(withIdentifier: "SubTypographyCell", for: indexPath) as! TypographyCell
                   let fontLineHeightKey = Typographies.fontLineHeightsKeys()[indexPath.row]
                   cell.title.text = fontLineHeightKey + " -  \(Typographies.lineHeights[fontLineHeightKey]!)"
                   cell.subTitle.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"
                   
                   cell.subTitle.setLineHeight(lineHeight: CGFloat(Typographies.lineHeights[fontLineHeightKey]!))
                   
                   
                   return cell;
        default:
            return UITableViewCell()
        }
        
        
    }
    
    func getCellSubCategorySize(_ indexPath: IndexPath) -> UITableViewCell {
        
        switch subCategorySizeType {
        case .Border:

            let cell = tableView.dequeueReusableCell(withIdentifier: "BorderCell", for: indexPath) as! BorderCell
            let borderKey = Borders.keys()[indexPath.row]
            cell.title.text = borderKey
            let yourColor : UIColor = UIColor.lightGray
            cell.viewWithBorder.layer.masksToBounds = true
            cell.viewWithBorder.layer.borderColor = yourColor.cgColor
            cell.viewWithBorder.layer.borderWidth = Borders.list[borderKey]!
            
            return cell;
        case .Opacity:

            let cell = tableView.dequeueReusableCell(withIdentifier: "BorderCell", for: indexPath) as! BorderCell
            let opacityKey = Opacities.keys()[indexPath.row]
            cell.title.text = opacityKey
            cell.viewWithBorder.backgroundColor = UIColor.black.withAlphaComponent(Opacities.list[opacityKey]!)
            return cell;
        case .SpacingInline:

            let cell = tableView.dequeueReusableCell(withIdentifier: "SpacesCell", for: indexPath) as! SpacesCell
            let spaceKey = Spaces.keys()[indexPath.row]
            cell.title.text = spaceKey
            cell.spaceSize.constant = Spaces.list[spaceKey]!
            
        return cell;
        
        default:
            return UITableViewCell()
        }
        
        
    }

    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
}


