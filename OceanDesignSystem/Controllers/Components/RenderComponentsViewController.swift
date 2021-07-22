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
    
    fileprivate func configTypographyComponentCell(_ tableView: UITableView, _ indexPath: IndexPath, _ cell: TypographyComponentCell, _ list: [UILabel]) {
        let rect = CGRect(x: 0, y: 0, width: 394, height: 100)
        
        let container = UIView(frame: rect)
        container.backgroundColor = .lightGray
        cell.addSubview(container)
        
        let typographyComponent = list[indexPath.row]
        typographyComponent.frame = CGRect(x: 10, y: 10, width: rect.width - 40, height: rect.height - 10)
        
        let title = typographyComponent
        title.text = typographyComponent.text
        title.numberOfLines = 2
        container.addSubview(title)
    }
    
    fileprivate func configButtonPrimaryComponentCell(_ tableView: UITableView, _ indexPath: IndexPath, _ cell: ButtonComponentCell, _ list: [Ocean.ButtonPrimary]) {
        
        let buttonComponent = list[indexPath.row]
        buttonComponent.isLoading = false
        buttonComponent.isEnabled = true
        if (buttonComponent.text == "Disabled") {
            buttonComponent.isEnabled = false
        } else if (buttonComponent.text == "Loading") {
            buttonComponent.isLoading = true
        }
        cell.container.addSubview(buttonComponent)
    }
    
    fileprivate func configButtonSecondaryComponentCell(_ tableView: UITableView, _ indexPath: IndexPath, _ cell: ButtonComponentCell, _ list: [Ocean.ButtonSecondary]) {
        
        let buttonComponent = list[indexPath.row]
        buttonComponent.isLoading = false
        buttonComponent.isEnabled = true
        if (buttonComponent.text == "Disabled") {
            buttonComponent.isEnabled = false
        } else if (buttonComponent.text == "Loading") {
            buttonComponent.isLoading = true
        }
        cell.container.addSubview(buttonComponent)
    }
    
    fileprivate func configButtonTextComponentCell(_ tableView: UITableView, _ indexPath: IndexPath, _ cell: ButtonComponentCell, _ list: [Ocean.ButtonText]) {
        
        let buttonComponent = list[indexPath.row]
        buttonComponent.isLoading = false
        buttonComponent.isEnabled = true
        if (buttonComponent.text == "Disabled") {
            buttonComponent.isEnabled = false
        } else if (buttonComponent.text == "Loading") {
            buttonComponent.isLoading = true
        }
        cell.container.addSubview(buttonComponent)
    }
    
    fileprivate func configButtonPrimaryInverseComponentCell(_ tableView: UITableView, _ indexPath: IndexPath, _ cell: ButtonComponentCell, _ list: [Ocean.ButtonPrimaryInverse]) {
        
        let buttonComponent = list[indexPath.row]
        buttonComponent.isLoading = false
        buttonComponent.isEnabled = true
        if (buttonComponent.text == "Disabled") {
            buttonComponent.isEnabled = false
        } else if (buttonComponent.text == "Loading") {
            buttonComponent.isLoading = true
        }
        cell.container.addSubview(buttonComponent)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (self.designSystemComponentsType == DesignSystemComponentsType.Typography){
            if (self.designSystemTypographyType == DesignSystemTypographyType.Headings) {
                let cell = TypographyComponentCell()
                configTypographyComponentCell(tableView, indexPath, cell, Headings.list)
                return cell
            }
            else if (self.designSystemTypographyType == DesignSystemTypographyType.Subtitle) {
                let cell = TypographyComponentCell()
                configTypographyComponentCell(tableView, indexPath, cell, Subtitles.list)
                return cell
            }
            else if (self.designSystemTypographyType == DesignSystemTypographyType.Description) {
                let cell = TypographyComponentCell()
                configTypographyComponentCell(tableView, indexPath, cell, Description.list)
                return cell
            }
            else if (self.designSystemTypographyType == DesignSystemTypographyType.Paragraph) {
                let cell = TypographyComponentCell()
                configTypographyComponentCell(tableView, indexPath, cell, Paragraph.list)
                return cell
            }
            else if (self.designSystemTypographyType == DesignSystemTypographyType.Caption) {
                let cell = TypographyComponentCell()
                configTypographyComponentCell(tableView, indexPath, cell, Caption.list)
                return cell
            }
        } else if (self.designSystemComponentsType == DesignSystemComponentsType.Button){
            if (self.designSystemButtonType == DesignSystemButtonType.ButtonPrimary) {
                let buttonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonComponentCell", for: indexPath) as! ButtonComponentCell
                configButtonPrimaryComponentCell(tableView, indexPath, buttonCell, PrimaryButtons.list)
                return buttonCell
            } else if (self.designSystemButtonType == DesignSystemButtonType.ButtonSecondary) {
                let buttonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonComponentCell", for: indexPath) as! ButtonComponentCell
                configButtonSecondaryComponentCell(tableView, indexPath, buttonCell, SecondaryButtons.list)
                return buttonCell
            } else if (self.designSystemButtonType == DesignSystemButtonType.ButtonText) {
                let buttonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonComponentCell", for: indexPath) as! ButtonComponentCell
                configButtonTextComponentCell(tableView, indexPath, buttonCell, TextButtons.list)
                return buttonCell
            }  else if (self.designSystemButtonType == DesignSystemButtonType.ButtonInverse) {
                let buttonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonComponentCell", for: indexPath) as! ButtonComponentCell
                configButtonPrimaryInverseComponentCell(tableView, indexPath, buttonCell, PrimaryInverseButtons.list)
                return buttonCell
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.designSystemComponentsType == DesignSystemComponentsType.Typography){
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
        } else if (self.designSystemComponentsType == DesignSystemComponentsType.Button){
            if (self.designSystemButtonType == DesignSystemButtonType.ButtonPrimary) {
                return PrimaryButtons.list.count
            } else if (self.designSystemButtonType == DesignSystemButtonType.ButtonSecondary) {
                return SecondaryButtons.list.count
            } else if (self.designSystemButtonType == DesignSystemButtonType.ButtonText) {
                return TextButtons.list.count
            } else if (self.designSystemButtonType == DesignSystemButtonType.ButtonInverse) {
                return PrimaryInverseButtons.list.count
            }
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
        if (self.designSystemComponentsType == DesignSystemComponentsType.Button){
            if (self.designSystemButtonType == DesignSystemButtonType.ButtonPrimary || self.designSystemButtonType == DesignSystemButtonType.ButtonSecondary ||
                self.designSystemButtonType == DesignSystemButtonType.ButtonText ||  self.designSystemButtonType == DesignSystemButtonType.ButtonInverse) {
                return 80
            }
        } else if (self.designSystemComponentsType == DesignSystemComponentsType.Typography){
            return 160
        }
        return 80
        
    }
}
