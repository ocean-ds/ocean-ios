//
//  RenderComponentsViewController.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 24/07/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanComponents
import OceanTokens


class RenderComponentsViewController: UITableViewController {
    
    var designSystemComponentsType : DesignSystemComponentsType!
    var designSystemTypographyType : DesignSystemTypographyType!
    var designSystemButtonType : DesignSystemButtonType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func configTypographyComponentCell(_ tableView: UITableView, _ indexPath: IndexPath, _ cell: RenderComponentCell, _ list: [UILabel]) {
        let rect = CGRect(x: 10, y: 20, width: tableView.bounds.width - 10, height: 40)
        let typographyComponent = list[indexPath.row]
        typographyComponent.frame = rect
        cell.title = typographyComponent
        cell.title.text = typographyComponent.text
        cell.title.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(cell.title)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = RenderComponentCell()
            
            if (self.designSystemTypographyType == DesignSystemTypographyType.Headings) {
                configTypographyComponentCell(tableView, indexPath, cell, Headings.list)
            }
            else if (self.designSystemTypographyType == DesignSystemTypographyType.Subtitle) {
                configTypographyComponentCell(tableView, indexPath, cell, Subtitles.list)
            }
            else if (self.designSystemTypographyType == DesignSystemTypographyType.Description) {
                configTypographyComponentCell(tableView, indexPath, cell, Description.list)
            }
            else if (self.designSystemTypographyType == DesignSystemTypographyType.Paragraph) {
                configTypographyComponentCell(tableView, indexPath, cell, Paragraph.list)
            }
            else if (self.designSystemTypographyType == DesignSystemTypographyType.Caption) {
            configTypographyComponentCell(tableView, indexPath, cell, Caption.list)
        }
            
            
            return cell
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.designSystemTypographyType == DesignSystemTypographyType.Headings) {
            return Headings.list.count
        }
        else if (self.designSystemTypographyType == DesignSystemTypographyType.Subtitle) {
            return Subtitles.list.count
        }
        else if (self.designSystemTypographyType == DesignSystemTypographyType.Paragraph) {
            return Paragraph.list.count
        }
        else if (self.designSystemTypographyType == DesignSystemTypographyType.Description) {
            return Description.list.count
        }
        else if (self.designSystemTypographyType == DesignSystemTypographyType.Caption) {
            return Caption.list.count
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
           return 80
       
   }
}
