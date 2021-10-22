//
//  Ocean+FilterViewController.swift
//  OceanComponents
//
//  Created by Vini on 07/07/21.
//

import UIKit
import OceanTokens

extension Ocean {
    public class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, OceanNavigationBar {
        private var placeholder: String?
        private var values: [CellModel]?
        private var contentValues: [CellModel]?
        
        public var navigationTitle: String? = ""
        public var navigationBackgroundColor: UIColor? = Ocean.color.colorInterfaceLightPure
        public var navigationTintColor: UIColor = Ocean.color.colorBrandPrimaryPure
        
        private lazy var mainStack: UIStackView = {
            UIStackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.alignment = .fill
                stack.distribution = .fillProportionally
                stack.axis = .vertical
                
                stack.addArrangedSubview(Ocean.Input.search { input in
                    input.placeholder = self.placeholder ?? ""
                    input.onValueChanged = { value in
                        if value.isEmpty {
                            self.contentValues = self.values
                        } else {
                            self.contentValues = self.values?.filter({ model in
                                let titleProcessed = model.title.lowercased().folding(options: .diacriticInsensitive, locale: .current)
                                let valueProcessed = value.lowercased().folding(options: .diacriticInsensitive, locale: .current)
                                return titleProcessed.contains(valueProcessed)
                            })
                        }
                        
                        self.emptyLabel.attributedText = !(self.contentValues?.isEmpty ?? true) ? NSAttributedString() : self.getEmptyMessage(value: value)
                        self.tableView.reloadData()
                    }
                })
                stack.addArrangedSubview(Ocean.Spacer(space: Ocean.size.spacingStackXs))
            }
        }()
        
        private lazy var emptyLabel: UILabel = {
            let label = UILabel()
            label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
            label.textColor = Ocean.color.colorInterfaceDarkUp
            label.textAlignment = .center
            label.text = ""
            label.numberOfLines = 2
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private lazy var emptyView: UIView = {
            let view = UIView()
            view.addSubview(emptyLabel)
            
            NSLayoutConstraint.activate([
                emptyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Ocean.size.spacingStackXs),
                emptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Ocean.size.spacingStackXs),
                emptyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Ocean.size.spacingStackXs)
            ])
            
            return view
        }()
        
        private lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.tableHeaderView = UIView()
            tableView.tableFooterView = UIView()
            tableView.backgroundView = emptyView
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle =  .none
            return tableView
        }()
        
        private var heightCell: CGFloat {
            get {
                return 48
            }
        }

        var onValueSelected: ((CellModel) -> Void)?
        
        init(title: String?,
             placeholder: String?,
             values: [CellModel]) {
            self.navigationTitle = title
            self.placeholder = placeholder
            self.values = values
            self.contentValues = values
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            setupNavigation()
            showNavigation()
            addCloseButton(action: #selector(closeClick))
            self.view.backgroundColor = Ocean.color.colorInterfaceLightPure
            self.view.addSubview(mainStack)
            self.view.addSubview(tableView)
            
            if #available(iOS 11.0, *) {
                NSLayoutConstraint.activate([
                    mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    mainStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                    constant: Ocean.size.spacingStackXs),
                    mainStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                     constant: -Ocean.size.spacingStackXs),
                    mainStack.heightAnchor.constraint(equalToConstant: 64),
                    
                    tableView.topAnchor.constraint(equalTo: mainStack.bottomAnchor),
                    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
                ])
            } else {
                NSLayoutConstraint.activate([
                    mainStack.topAnchor.constraint(equalTo: view.topAnchor),
                    mainStack.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                    constant: Ocean.size.spacingStackXs),
                    mainStack.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                     constant: -Ocean.size.spacingStackXs),
                    mainStack.heightAnchor.constraint(equalToConstant: 64),
                    
                    tableView.topAnchor.constraint(equalTo: mainStack.bottomAnchor),
                    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            }
        }
        
        @objc func closeClick() {
            self.dismiss(animated: true, completion: nil)
        }
        
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return contentValues?.count ?? 0
        }

        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = Ocean.BottomSheetCell()

            cell.model = contentValues?[indexPath.row]

            return cell
        }

        public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return heightCell
        }

        public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let value = contentValues?[indexPath.row] {
                self.dismiss(animated: true, completion: nil)
                self.onValueSelected?(value)
            }
        }
        
        private func getEmptyMessage(value: String) -> NSAttributedString {
            let message = "Não foram econtrados resultados para\n"
            let messageBold = "＂\(value)＂"
            let fontSize = Ocean.font.fontSizeXxs
            let fontMedium = Ocean.font.fontFamilyBaseWeightMedium
            let fontBold = Ocean.font.fontFamilyBaseWeightBold
            let attr = NSMutableAttributedString()
            attr.append(NSAttributedString(string: message,
                                           attributes: [NSAttributedString.Key.font: UIFont(name: fontMedium, size: fontSize)!]))
            attr.append(NSAttributedString(string: messageBold,
                                           attributes: [NSAttributedString.Key.font: UIFont(name: fontBold, size: fontSize)!]))
            return attr
        }
    }
}
