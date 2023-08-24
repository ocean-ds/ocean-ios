//
//  ButtonViewController.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 26/08/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class ButtonViewController : UIViewController {
    
    @IBOutlet weak var types: UISegmentedControl!
    @IBOutlet weak var normalOrIconOrModified: UISegmentedControl!
    @IBOutlet weak var unblockedOrBlocked: UISegmentedControl!
    @IBOutlet weak var states: UISegmentedControl!
    @IBOutlet weak var sizes: UISegmentedControl!

    var buttonPrimary : Ocean.ButtonPrimary!
    var buttonSecondary : Ocean.ButtonSecondary!
    var buttonInverse : Ocean.ButtonPrimaryInverse!
    var buttonText : Ocean.ButtonText!
    var buttonTextCritical : Ocean.ButtonTextCritical!
    var buttonPrimaryCritical: Ocean.ButtonPrimaryCritical!
    var buttonSecondaryCritical : Ocean.ButtonSecondaryCritical!
    
    //var button : Ocean.Button!
    
    public override func viewDidLoad() {
        self.buttonPrimary = Ocean.Button.primarySM { button in
            button.text = "Small"
        }
        self.addButton(view: self.buttonPrimary)
    }
    
    private func addButton(view: UIView) {
        self.view.subviews.forEach { view in
            if !(view is UISegmentedControl), !(view is UIStackView) {
                view.removeFromSuperview()
            }
        }
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.generateConstraintsButtonBottom(view: view)
    }
    
    fileprivate func configButton(_ button: Ocean.ButtonPrimary) {
        button.isHighlighted = false
        button.isEnabled = true
        button.isLoading = false
        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
        if (self.states.selectedSegmentIndex == 1) {
            button.isPressed = true
        } else if (self.states.selectedSegmentIndex == 2) {
            button.isEnabled = false
        } else if (self.states.selectedSegmentIndex == 3) {
            button.isLoading = true
            button.icon = nil
        }
    }
    
    fileprivate func configButton(_ button: Ocean.ButtonSecondary) {
        button.isHighlighted = false
        button.isEnabled = true
        button.isLoading = false
        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
        if (self.states.selectedSegmentIndex == 1) {
            button.isPressed = true
        } else if (self.states.selectedSegmentIndex == 2) {
            button.isEnabled = false
        }
        else if (self.states.selectedSegmentIndex == 3) {
            button.isLoading = true
            button.icon = nil
        }
    }
    
    fileprivate func configButton(_ button: Ocean.ButtonText) {
        button.isHighlighted = false
        button.isEnabled = true
        button.isLoading = false
        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
        if (self.states.selectedSegmentIndex == 1) {
            button.isPressed = true
        } else if (self.states.selectedSegmentIndex == 2) {
            button.isEnabled = false
        }
        else if (self.states.selectedSegmentIndex == 3) {
            button.isLoading = true
            button.leftIcon = nil
        }
    }
    
    fileprivate func configButton(_ button: Ocean.ButtonTextCritical) {
        button.isHighlighted = false
        button.isEnabled = true
        button.isLoading = false
        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
        if (self.states.selectedSegmentIndex == 1) {
            button.isPressed = true
        } else if (self.states.selectedSegmentIndex == 2) {
            button.isEnabled = false
        }
        else if (self.states.selectedSegmentIndex == 3) {
            button.isLoading = true
            button.leftIcon = nil
        }
    }
    
    fileprivate func configButton(_ button: Ocean.ButtonPrimaryInverse) {
        button.isHighlighted = false
        button.isEnabled = true
        button.isLoading = false
        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
        if (self.states.selectedSegmentIndex == 1) {
            button.isPressed = true
        } else if (self.states.selectedSegmentIndex == 2) {
            button.isEnabled = false
        } else if (self.states.selectedSegmentIndex == 3) {
            button.isLoading = true
            button.icon = nil
        }
    }
    
    fileprivate func configButton(_ button: Ocean.ButtonPrimaryCritical) {
        button.isHighlighted = false
        button.isEnabled = true
        button.isLoading = false
        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
        if (self.states.selectedSegmentIndex == 1) {
            button.isPressed = true
        } else if (self.states.selectedSegmentIndex == 2) {
            button.isEnabled = false
        } else if (self.states.selectedSegmentIndex == 3) {
            button.isLoading = true
            button.icon = nil
        }
    }
    
    func updateChanges() {
        self.buttonPrimary?.isHidden = true
        self.buttonPrimary = nil
        self.buttonSecondary?.isHidden = true
        self.buttonSecondary = nil
        self.buttonText?.isHidden = true
        self.buttonText = nil
        self.buttonTextCritical?.isHidden = true
        self.buttonTextCritical = nil
        self.buttonInverse?.isHidden = true
        self.buttonInverse = nil
        self.buttonPrimaryCritical?.isHidden = true
        self.buttonPrimaryCritical = nil
        self.buttonSecondaryCritical?.isHidden = true
        self.buttonSecondaryCritical = nil

        switch self.types.selectedSegmentIndex {
        case 0: //primary
            if (self.sizes.selectedSegmentIndex == 0) {
                self.buttonPrimary = Ocean.Button.primarySM { button in
                    button.text = "Small"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                    }
                }
            } else if (self.sizes.selectedSegmentIndex == 1) {
                self.buttonPrimary = Ocean.Button.primaryMD { button in
                    button.text = "Medium"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                }
            } else if (self.sizes.selectedSegmentIndex == 2) {
                self.buttonPrimary = Ocean.Button.primaryLG { button in
                    button.text = "Large"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                }
            }
            configButton(self.buttonPrimary)
            self.addButton(view: self.buttonPrimary)
            break
        case 1: //secondary
            if (self.sizes.selectedSegmentIndex == 0) {
                self.buttonSecondary = Ocean.Button.secondarySM { button in
                    button.text = "Small"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                }
            } else if (self.sizes.selectedSegmentIndex == 1) {
                self.buttonSecondary = Ocean.Button.secondaryMD { button in
                    button.text = "Medium"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                    
                }
            } else if (self.sizes.selectedSegmentIndex == 2) {
                self.buttonSecondary = Ocean.Button.secondaryLG { button in
                    button.text = "Large"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                    
                }
            }
            configButton(self.buttonSecondary)
            self.addButton(view: self.buttonSecondary)
            break
        case 2: //inverse
            self.buttonInverse = nil
            if (self.sizes.selectedSegmentIndex == 0) {
                self.buttonInverse = Ocean.Button.primaryInverseSM { button in
                    button.text = "Small"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                }
            } else if (self.sizes.selectedSegmentIndex == 1) {
                self.buttonInverse = Ocean.Button.primaryInverseMD { button in
                    button.text = "Medium"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                }
            } else if (self.sizes.selectedSegmentIndex == 2) {
                self.buttonInverse = Ocean.Button.primaryInverseLG { button in
                    button.text = "Large"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                }
            }
            configButton(self.buttonInverse)
            self.addButton(view: self.buttonInverse)
            break
        case 3: //text
            if (self.sizes.selectedSegmentIndex == 0) {
                switch self.normalOrIconOrModified.selectedSegmentIndex {
                case 0,  1: // Normal, Icon
                    self.buttonText = Ocean.Button.textSM { button in
                        button.text = "Small"
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1

                        if self.normalOrIconOrModified.selectedSegmentIndex == 1 {
                            button.leftIcon = Ocean.icon.plusOutline
                            button.rightIcon = Ocean.icon.plusOutline
                        }
                    }
                case 2: // Modified
                    self.buttonText = Ocean.Button.textModifiedSM { button in
                        button.text = "Small"
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                default: break
                }

            } else if (self.sizes.selectedSegmentIndex == 1) {
                switch self.normalOrIconOrModified.selectedSegmentIndex {
                case 0,  1:
                    self.buttonText = Ocean.Button.textMD { button in
                        button.text = "Medium"
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1

                        if self.normalOrIconOrModified.selectedSegmentIndex == 1 {
                            button.leftIcon = Ocean.icon.plusOutline
                            button.rightIcon = Ocean.icon.plusOutline
                        }
                    }
                case 2:
                    self.buttonText = Ocean.Button.textModifiedMD { button in
                        button.text = "Medium"
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                default: break
                }
            } else if (self.sizes.selectedSegmentIndex == 2) {
                switch self.normalOrIconOrModified.selectedSegmentIndex {
                case 0,  1:
                    self.buttonText = Ocean.Button.textLG { button in
                        button.text = "Large"
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1

                        if self.normalOrIconOrModified.selectedSegmentIndex == 1 {
                            button.leftIcon = Ocean.icon.plusOutline
                            button.rightIcon = Ocean.icon.plusOutline
                        }
                    }
                case 2:
                    self.buttonText = Ocean.Button.textModifiedLG { button in
                        button.text = "Large"
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                default: break
                }
            }
            configButton(self.buttonText)
            self.addButton(view: self.buttonText)
            break
        case 4: //textCritical
            if (self.sizes.selectedSegmentIndex == 0) {
                switch self.normalOrIconOrModified.selectedSegmentIndex {
                case 0,  1: // Normal, Icon
                    self.buttonTextCritical = Ocean.Button.textCriticalSM { button in
                        button.text = "Small"
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                        
                        if self.normalOrIconOrModified.selectedSegmentIndex == 1 {
                            button.leftIcon = Ocean.icon.plusOutline
                            button.rightIcon = Ocean.icon.plusOutline
                        }
                    }
                case 2: // Modified
                    self.buttonTextCritical = Ocean.Button.textCriticalModifiedSM { button in
                        button.text = "Small"
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                default: break
                }
                
            } else if (self.sizes.selectedSegmentIndex == 1) {
                switch self.normalOrIconOrModified.selectedSegmentIndex {
                case 0,  1:
                    self.buttonTextCritical = Ocean.Button.textCriticalMD { button in
                        button.text = "Medium"
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                        
                        if self.normalOrIconOrModified.selectedSegmentIndex == 1 {
                            button.leftIcon = Ocean.icon.plusOutline
                            button.rightIcon = Ocean.icon.plusOutline
                        }
                    }
                case 2:
                    self.buttonTextCritical = Ocean.Button.textCriticalModifiedMD { button in
                        button.text = "Medium"
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                default: break
                }
            } else if (self.sizes.selectedSegmentIndex == 2) {
                switch self.normalOrIconOrModified.selectedSegmentIndex {
                case 0,  1:
                    self.buttonTextCritical = Ocean.Button.textCriticalLG { button in
                        button.text = "Large"
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                        
                        if self.normalOrIconOrModified.selectedSegmentIndex == 1 {
                            button.leftIcon = Ocean.icon.plusOutline
                            button.rightIcon = Ocean.icon.plusOutline
                        }
                    }
                case 2:
                    self.buttonTextCritical = Ocean.Button.textCriticalModifiedLG { button in
                        button.text = "Large"
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                default: break
                }
            }
            configButton(self.buttonTextCritical)
            self.addButton(view: self.buttonTextCritical)
            break
        case 5: //primaryCritical
            if (self.sizes.selectedSegmentIndex == 0) {
                self.buttonPrimaryCritical = Ocean.Button.primaryCriticalSM { button in
                    button.text = "Small"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                    }
                }
            } else if (self.sizes.selectedSegmentIndex == 1) {
                self.buttonPrimaryCritical = Ocean.Button.primaryCriticalMD { button in
                    button.text = "Medium"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                }
            } else if (self.sizes.selectedSegmentIndex == 2) {
                self.buttonPrimaryCritical = Ocean.Button.primaryCriticalLG { button in
                    button.text = "Large"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                }
            }
            configButton(self.buttonPrimaryCritical)
            self.addButton(view: self.buttonPrimaryCritical)
            break
        case 6: //secondaryCritical
            if (self.sizes.selectedSegmentIndex == 0) {
                self.buttonSecondaryCritical = Ocean.Button.secondaryCriticalSM { button in
                    button.text = "Small"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                    }
                }
            } else if (self.sizes.selectedSegmentIndex == 1) {
                self.buttonSecondaryCritical = Ocean.Button.secondaryCriticalMD { button in
                    button.text = "Medium"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                }
            } else if (self.sizes.selectedSegmentIndex == 2) {
                self.buttonSecondaryCritical = Ocean.Button.secondaryCriticalLG { button in
                    button.text = "Large"
                    if (self.normalOrIconOrModified.selectedSegmentIndex == 1) {
                        button.icon = Ocean.icon.plusOutline
                        button.isBlocked = self.unblockedOrBlocked.selectedSegmentIndex == 1
                    }
                }
            }
            configButton(self.buttonSecondaryCritical)
            self.addButton(view: self.buttonSecondaryCritical)
            break
        default:
            break
        }
    }
    
    @IBAction func onValueChangedTypes(_ sender: Any) {
        updateChanges()
    }
    
    @IBAction func onValueChangedIcon(_ sender: Any) {
        updateChanges()
    }
    
    @IBAction func onValueChangedBlocked(_ sender: Any) {
        updateChanges()
    }
    
    @IBAction func onValueChangedStates(_ sender: Any) {
        updateChanges()
    }
    
    @IBAction func onValueChangedSizes(_ sender: Any) {
        updateChanges()
    }
    
    private func generateConstraintsButtonBottom(view:AnyObject) -> Void {
        view.centerXAnchor?.constraint(equalTo: self.view.centerXAnchor).isActive = true
        view.centerYAnchor?.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}
