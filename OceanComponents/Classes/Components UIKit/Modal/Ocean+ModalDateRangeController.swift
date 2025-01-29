//
//  Ocean+ModalDateRangeViewController.swift
//  Pods
//
//  Created by Acassio Mendonça on 23/01/25.
//

import OceanTokens
extension Ocean {
    public class ModalDateRangeViewController: BaseModalViewController {

        // MARK: - Properties

        var contentTitle: String?
        var beginDate: Date? = nil
        var endDate: Date? = nil
        public var onFilter: (Date?, Date?) -> Void = { _, _ in }
        public var onValueSelected: (Date?) -> Void = { _ in }

        // MARK: - Private properties

        private var validationErrors: [String: String] = [:]

        private lazy var titleLabel: UIView = {
            Ocean.Typography.heading4 { label in
                label.text = self.contentTitle ?? "Período"
            }
        }()

        private lazy var showDatePickerBeginDateButton: UIButton = {
            UIButton { button in
                if let icon = Ocean.icon.calendarOutline?.withRenderingMode(.alwaysTemplate) {
                    button.setImage(icon, for: .normal)
                    button.addTarget(self, action: #selector(self.showBeginDatePicker), for: .touchUpInside)
                    button.tintColor = Ocean.color.colorInterfaceDarkUp
                    button.contentMode = .scaleAspectFit
                }
            }
        }()

        private lazy var beginDateInput: Ocean.InputTextField = {
            Ocean.InputTextField { input in
                input.translatesAutoresizingMaskIntoConstraints = false
                input.title = "Data inicial"
                input.placeholder = "dd/mm/aaaa"
                input.text = beginDate?.shortDateFormat() ?? ""
                input.keyboardType = .numberPad
                input.rightButton = showDatePickerBeginDateButton
                input.onValueChanged = { [weak self]  value in
                    guard let self = self else { return }

                    input.errorMessage = ""
                    input.text = value.applyDateMask()
                    beginDate = nil
                    guard value.count >= 10 else { return }

                    if let date = value.shortDateNullable() {
                        beginDate = date
                    } else {
                        input.errorMessage = "A data informada não é válida."
                    }
                }
            }
        }()

        private lazy var showDatePickerEndDateButton: UIButton = {
            UIButton { button in
                if let icon = Ocean.icon.calendarOutline?.withRenderingMode(.alwaysTemplate) {
                    button.setImage(icon, for: .normal)
                    button.addTarget(self, action: #selector(self.showEndDatePicker), for: .touchUpInside)
                    button.tintColor = Ocean.color.colorInterfaceDarkUp
                    button.contentMode = .scaleAspectFit
                }
            }
        }()

        private lazy var endDateInput: Ocean.InputTextField = {
            Ocean.InputTextField { input in
                input.translatesAutoresizingMaskIntoConstraints = false
                input.title = "Data final"
                input.placeholder = "dd/mm/aaaa"
                input.text = endDate?.shortDateFormat() ?? ""
                input.keyboardType = .numberPad
                input.rightButton = showDatePickerEndDateButton
                input.onValueChanged = { [weak self]  value in
                    guard let self = self else { return }

                    input.errorMessage = ""
                    input.text = value.applyDateMask()
                    endDate = nil
                    guard value.count >= 10 else { return }

                    if let date = value.shortDateNullable() {
                        endDate = date
                    } else {
                        input.errorMessage = "A data informada não é válida."
                    }
                }
            }
        }()

        private lazy var spaceWhenMessageErrorIsEmpty: Ocean.Spacer = {
            let view = Ocean.Spacer()
            view.space = Ocean.size.spacingStackXs

            return view
        }()

        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.alignment = .fill
                stack.distribution = .fill
                stack.spacing = 0
                stack.translatesAutoresizingMaskIntoConstraints = false

                stack.add([
                    titleLabel,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    beginDateInput,
                    spaceWhenMessageErrorIsEmpty,
                    endDateInput,
                    Ocean.Spacer(space: Ocean.size.spacingStackXxs),
                ])
            }
        }()

        private lazy var clearButton: Ocean.ButtonSecondary = {
            Ocean.Button.secondaryMD { button in
                button.text = "Limpar"
                button.onTouch = self.clear
            }
        }()

        private lazy var filterButton: Ocean.ButtonPrimary = {
            Ocean.Button.primaryMD { button in
                button.text = "Filtrar"
                button.onTouch = self.filter
            }
        }()

        private lazy var bottomStack: Ocean.StackView = {
            Ocean.StackView { view in
                view.translatesAutoresizingMaskIntoConstraints = false
                view.axis = .horizontal
                view.distribution = .fillEqually
                view.alignment = .center
                view.spacing = Ocean.size.spacingStackXs

                view.add([clearButton, filterButton])
            }
        }()

        // MARK: - Lifecycle

        public override func viewDidLoad() {
            super.viewDidLoad()

            setupUI()
        }

        // MARK: - Setup

        public override func makeView() {
            mainStack.addArrangedSubview(closeView)

            spTransitionDelegate.customHeight = 392
        }

        private func setupUI() {
            view.addSubview(contentStack)
            view.addSubview(bottomStack)

            setupConstraints()
        }

        private func setupConstraints() {
            mainStack.oceanConstraints
                .topToTop(to: view, safeArea: true)
                .leadingToLeading(to: view, constant: Ocean.size.spacingStackSm, safeArea: true)
                .trailingToTrailing(to: view, constant: -Ocean.size.spacingStackSm, safeArea: true)
                .make()

            contentStack.oceanConstraints
                .topToBottom(to: mainStack)
                .bottomToTop(to: bottomStack, constant: -8)
                .leadingToLeading(to: mainStack)
                .trailingToTrailing(to: mainStack)
                .make()

            bottomStack.oceanConstraints
                .topToBottom(to: contentStack)
                .bottomToBottom(to: view, safeArea: true)
                .leadingToLeading(to: view, constant: Ocean.size.spacingStackSm, safeArea: true)
                .trailingToTrailing(to: view, constant: -Ocean.size.spacingStackSm, safeArea: true)
                .make()

            showDatePickerBeginDateButton.oceanConstraints
                .width(constant: 24)
                .height(constant: 24)
                .make()

            showDatePickerEndDateButton.oceanConstraints
                .width(constant: 24)
                .height(constant: 24)
                .make()
        }

        // MARK: - Private methods

        private func updateUI() {
            beginDateInput.text = beginDate?.shortDateFormat() ?? ""
            endDateInput.text = endDate?.shortDateFormat() ?? ""
        }

        private func isValidate() -> Bool {
            validationErrors.removeAll()

            if beginDate == nil {
                validationErrors["beginDate"] = "Este campo não pode ficar em branco."
            }

            if endDate == nil {
                validationErrors["endDate"] = "Este campo não pode ficar em branco."
            }

            if let beginDate = beginDate, let endDate = endDate, beginDate > endDate {
                validationErrors["beginDate"] = "A data inicial deve ser menor ou igual a data final"
            }

            return validationErrors.isEmpty
        }

        private func updateErrorStates() {
            spaceWhenMessageErrorIsEmpty.isHidden = !validationErrors.isEmpty
            beginDateInput.errorMessage = validationErrors["beginDate"] ?? ""
            endDateInput.errorMessage = validationErrors["endDate"] ?? ""
        }

        private func filter() {
            guard isValidate(), let beginDate = beginDate, let endDate = endDate else {
                updateErrorStates()
                return
            }

            onFilter(beginDate, endDate)
            dismiss(animated: true, completion: nil)
        }

        private func clear() {
            beginDate = nil
            endDate = nil
            validationErrors.removeAll()
            onFilter(nil, nil)
            dismiss(animated: true, completion: nil)
        }

        @objc
        private func showBeginDatePicker() {
            showDatePicker(title: "Data inicial",
                           minDate: Date(timeIntervalSince1970: 0),
                           maxDate: endDate,
                           selectedDate: beginDate ?? endDate) { [weak self] date in
                guard let self = self else { return }
                self.beginDate = date
                self.validationErrors.removeValue(forKey: "beginDate")
                self.updateErrorStates()
                self.updateUI()
            }
        }

        @objc
        private func showEndDatePicker() {
            showDatePicker(title: "Data final",
                           minDate: beginDate,
                           maxDate: nil,
                           selectedDate: endDate) { [weak self] date in
                guard let self = self else { return }
                self.endDate = date
                self.validationErrors.removeValue(forKey: "endDate")
                self.updateErrorStates()
                self.updateUI()
            }
        }

        private func showDatePicker(title: String,
                                    minDate: Date?,
                                    maxDate: Date?,
                                    selectedDate: Date?,
                                    completion: @escaping (Date) -> Void) {
            let datePicker = Ocean.DatePicker()
            datePicker.navigationTitle = title
            datePicker.disableWeekend = false
            datePicker.minimumDate = minDate ?? Date(timeIntervalSince1970: 0)
            datePicker.maximumDate = maxDate ?? Date(timeIntervalSince1970: .greatestFiniteMagnitude)
            datePicker.selectedDate = selectedDate ?? Date()
            datePicker.isTodaySelectable = true
            datePicker.onReleaseCalendar = completion
            datePicker.show(rootViewController: self)
        }
    }
}
