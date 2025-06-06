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
        case .Alert:
            self.present(AlertSwiftUIViewController(), animated: true, completion: nil)
        case .Button:
            self.present(ButtonSwiftUIViewController(), animated: true, completion: nil)
        case .Link:
            self.modalPresentationStyle = .fullScreen
            self.present(LinkSwiftUIViewController(), animated: true, completion: nil)
        case .OrderedListItem:
            self.present(OrderedListItemSwiftUIViewController(), animated: true, completion: nil)
        case .ProgressIndicator:
            self.present(CircularProgressIndicatorSwiftUIViewController(), animated: true, completion: nil)
        case .StatusListItem:
            self.present(StatusListItemSwiftUIViewController(), animated: true, completion: nil)
        case .Tag:
            self.present(TagSwiftUIViewController(), animated: true, completion: nil)
        case .Typography:
            self.present(TypographySwiftUIViewController(), animated: true, completion: nil)
        case .Badge:
            self.present(BadgeSwiftUIViewController(), animated: true, completion: nil)
        case .CardListItem:
            self.present(CardListItemSwiftUIViewController(), animated: true, completion: nil)
        case .Accordion:
            self.present(AccordionSwiftUIViewController(), animated: true, completion: nil)
        case .Divider:
            self.present(DividerSwiftUIViewController(), animated: true, completion: nil)
        case .Input:
            self.present(InputSwiftUIViewController(), animated: true, completion: nil)
        case .FilterBar:
            self.present(FilterBarSwiftUIViewController(), animated: true, completion: nil)
        case .Tab:
            self.present(TabSwiftUIViewController(), animated: true, completion: nil)
        case .Subheader:
            self.present(SubheaderSwiftUIViewController(), animated: true, completion: nil)
        case .TransactionListItem:
            self.present(TransactionListItemSwiftUIViewController(), animated: true, completion: nil)
        case .FileUploader:
            self.present(FileUploaderSwiftUIViewController(), animated: true, completion: nil)
        case .InvertedTextListItem:
            self.present(InvertedTextListItemSwiftUIViewController(), animated: true, completion: nil)
        case .InlineTextListItem:
            self.present(InlineTextListItemSwiftUIViewController(), animated: true, completion: nil)
        case .RadioButtonGroup:
            self.present(RadioButtonGroupSwiftUIViewController(), animated: true, completion: nil)
        case .ChartBar:
            self.present(ChartBarSwiftUIViewController(), animated: true, completion: nil)
        case .CheckboxGroup:
            self.present(CheckboxGroupSwiftUIViewController(), animated: true, completion: nil)
        case .CardCTA:
            self.present(CardCTASwiftUIViewController(), animated: true, completion: nil)
        case .CardCrossSell:
            self.present(CardCrossSellSwiftUIViewController(), animated: true, completion: nil)
        case .CardGroup:
            self.present(CardGroupSwiftUIViewController(), animated: true, completion: nil)
        case .TextListItem:
            self.present(TextListItemSwiftUIViewController(), animated: true, completion: nil)
        case .Step:
            self.present(StepSwiftUIViewController(), animated: true, completion: nil)
        case .Tooltip:
            self.present(TooltipSwiftUIViewController(), animated: true, completion: nil)
        case .ScoreChart:
            self.present(ScoreChartSwiftUIViewController(), animated: true, completion: nil)
        case .ScrollableTab:
            self.present(ScrollableTabSwiftUIViewController(), animated: true, completion: nil)
        case .CardOption:
            self.present(CardOptionSwiftUIViewController(), animated: true, completion: nil)
        case .Onboarding:
            self.present(OnboardingSwiftUIViewController(), animated: true, completion: nil)
        case .Balance:
            self.present(BalanceSwiftUIViewController(), animated: true, completion: nil)
        case .ParentChild:
            self.present(ParentChildSwiftUIViewController(), animated: true, completion: nil)
        case .Carousel:
            self.present(CarouselSwiftUIViewController(), animated: true, completion: nil)
        case .Shortcut:
            self.present(ShortcutSwiftUIViewController(), animated: true, completion: nil)
        case .ProgressBar:
            self.present(ProgressBarSwiftUIViewController(), animated: true, completion: nil)
        case .TransactionFooter:
            self.present(TransactionFooterSwiftUIViewController(), animated: true, completion: nil)
        case .Switch:
            self.present(SwitchSwiftUIViewController(), animated: true, completion: nil)
        case .SimpleBalance:
            self.present(SimpleBalanceSwiftUIViewController(), animated: true, completion: nil)
        case .SettingsListItem:
            self.present(SettingsListItemSwiftUIViewController(), animated: true, completion: nil)
        case .ContentList:
            self.present(ContentListSwiftUIViewController(), animated: true, completion: nil)
        case .ChartCard:
            self.present(ChartCardSwiftUIViewController(), animated: true, completion: nil)
        case .ExpandableTextListItem:
            self.present(ExpandableTextListItemSwiftUIViewController(), animated: true, completion: nil)
        }
    }
}
