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
import OceanComponents

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
            if (self.subCategorySizeType == SubCategorySizeType.SpacingInline) {
                return 260
            } else {
                return 120
            }
            
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
            cell.subTitle.text =
            "\(Typographies.fontSizes[fontSizeKey]!)"
            cell.subTitle.font = UIFont(name: Ocean.font.fontFamilyBaseWeightLight, size: CGFloat(Typographies.fontSizes[fontSizeKey]!))
            
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
            cell.viewWithBorder.layer.borderColor = yourColor.cgColor
            cell.viewWithBorder.layer.cornerRadius = Ocean.size.borderRadiusNone
            cell.viewWithBorder.layer.borderWidth = Ocean.size.borderWidthNone
            
            cell.contentView.backgroundColor = UIColor(red: 1.00, green: 0.72, blue: 0.70, alpha: 1.00)
            cell.constraintViewHeight.constant = 60
            cell.constraintViewWidth.constant = 60
            
            if (borderKey.contains("Radius")) {
                self.configBorderRadius(cell,radius: Borders.list[borderKey]! )
            } else {
                self.configBorderSize(cell, size: Borders.list[borderKey]!)
            }
            
            switch borderKey {
            case "borderRadiusCircular":
                cell.viewWithBorder.ocean.radius.applyCircular()
            case "borderRadiusLg":
                cell.viewWithBorder.ocean.radius.applyLg()
            case "borderRadiusMd":
                cell.viewWithBorder.ocean.radius.applyMd()
            case "borderRadiusNone":
                cell.viewWithBorder.ocean.radius.applyNone()
            case "borderRadiusPill":
                cell.viewWithBorder.ocean.radius.applyPill()
            case "borderRadiusSm":
                cell.viewWithBorder.ocean.radius.applySm()
            case "borderWidthHairline":
                cell.viewWithBorder.ocean.borderWidth.applyHairline()
            case "borderWidthHeavy":
                cell.viewWithBorder.ocean.borderWidth.applyHeavy()
            case "borderWidthNone":
                cell.viewWithBorder.ocean.borderWidth.applyNone()
            case "borderWidthThick":
                cell.viewWithBorder.ocean.borderWidth.applyThick()
            case "borderWidthThin":
                cell.viewWithBorder.ocean.borderWidth.applyThin()
            case "borderRadiusPartialTop":
                cell.viewWithBorder.ocean.radius.top().applyMd()
            case "borderRadiusPartialBottom":
                cell.viewWithBorder.ocean.radius.bottom().applyMd()
            case "borderRadiusPartialLeading":
                cell.viewWithBorder.ocean.radius.leading().applyMd()
            case "borderRadiusPartialTrailing":
                cell.viewWithBorder.ocean.radius.trailing().applyMd()
            default:
                return UITableViewCell()
            }
            return cell;
        case .Opacity:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BorderCell", for: indexPath) as! BorderCell
            let opacityKey = Opacities.keys()[indexPath.row]
            cell.title.text = opacityKey
            cell.viewWithBorder.backgroundColor = UIColor.black
            cell.viewWithBorder.backgroundColor = cell.viewWithBorder.backgroundColor?.withAlphaComponent(Opacities.list[opacityKey]!)
            return cell;
        case .SpacingInline:
            let spaceKey = Spaces.keys()[indexPath.row]
            if (spaceKey.contains("Stack")) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "StackSpacesCell", for: indexPath) as! StackSpacesCell
                cell.viewStackRender.backgroundColor = UIColor(red: 1.00, green: 0.72, blue: 0.70, alpha: 1.00)
                cell.title.text = spaceKey
                cell.stackSize.constant = Spaces.list[spaceKey]!
            } else if (spaceKey.contains("Inset")) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "InsetSpacesCell", for: indexPath) as! InsetSpacesCell
                cell.viewStackRender.backgroundColor = UIColor(red: 1.00, green: 0.72, blue: 0.70, alpha: 1.00)
                cell.title.text = spaceKey
                
                for inset in cell.insetSizes {
                    inset.constant = Spaces.list[spaceKey]!
                }
                
            } else if (spaceKey.contains("Inline")) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "InlineSpacesCell", for: indexPath) as! InlineSpacesCell
                cell.viewStackRender.backgroundColor = UIColor(red: 1.00, green: 0.72, blue: 0.70, alpha: 1.00)
                cell.title.text = spaceKey
                if (Spaces.list[spaceKey]! == 0 ) {
                    cell.inlineSize.constant = cell.viewStackRender.bounds.width
                } else {
                    cell.inlineSize.constant = Spaces.list[spaceKey]!
                }
                
                
            }
            
            return UITableViewCell();
            
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func configBorderRadius(_ cell:BorderCell, radius: CGFloat) {
        if (radius >= Ocean.size.borderRadiusPill) {
            cell.constraintViewWidth.constant = 60 * 3
        }
        //cell.viewWithBorder.applyRadius(radius: radius)
    }
    
    private func configBorderSize(_ cell:BorderCell, size: CGFloat) {
        cell.constraintViewHeight.constant = 60
        cell.constraintViewWidth.constant = 60
        //cell.viewWithBorder.layer.borderWidth = size
    }
}

