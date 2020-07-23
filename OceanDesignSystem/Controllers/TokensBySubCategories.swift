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

    var subCategoryType : SubCategoryTypograpyType!
    
    //@IBOutlet weak var labelTest: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = getCell(indexPath)
        return categoryCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch subCategoryType {
        case .FontFamilyWithWeight:
            return Typographies.fontFamilies.count
        case .FontSize:
            return Typographies.fontSizes.count
        case .FontLineHeight:
            return Typographies.lineHeights.count
        
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 200
        
    }

    func getCell(_ indexPath: IndexPath) -> UITableViewCell {
        
        switch subCategoryType {
        case .FontFamilyWithWeight:

            let cell = tableView.dequeueReusableCell(withIdentifier: "TypographyCell", for: indexPath) as! TypographyCell
            //let typographies = Typographies.list()

            let fontFamilyKey = Typographies.fontFamiliesKeys()[indexPath.row]
            cell.title.text = fontFamilyKey
            cell.subTitle.text = Typographies.fontFamilies[fontFamilyKey]
            return cell;
            
        case .FontSize:

            let cell = tableView.dequeueReusableCell(withIdentifier: "TypographyCell", for: indexPath) as! TypographyCell
            let fontSizeKey = Typographies.fontSizesKeys()[indexPath.row]
            cell.title.text = fontSizeKey
            cell.subTitle.text = String(Typographies.fontSizes[fontSizeKey]!)
            cell.subTitle.font = UIFont(name: Ocean.font.fontFamilyBaseWeightLight, size: CGFloat(Typographies.fontSizes[fontSizeKey]!))
            
            return cell;
        case .FontLineHeight:

                   let cell = tableView.dequeueReusableCell(withIdentifier: "TypographyCell", for: indexPath) as! TypographyCell
                   let fontLineHeightKey = Typographies.fontLineHeightsKeys()[indexPath.row]
                   cell.title.text = fontLineHeightKey + " \(Typographies.lineHeights[fontLineHeightKey])"
                   cell.subTitle.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"
                   
                   cell.subTitle.setLineHeight(lineHeight: CGFloat(Typographies.lineHeights[fontLineHeightKey]!))
                   
                   
                   return cell;
        default:
            return UITableViewCell()
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
}


