//
//  Ocean+ModalDateRange.swift
//  Pods
//
//  Created by Acassio Mendonça on 23/01/25.
//

import OceanTokens

class ModalDateRangeView: UIView {

    public lazy var rootViewController: UIViewController = UIViewController()

    public var beginDate: Date? = nil

    public var endDate: Date? = nil

    public var onFilter: (DateInterval?) -> Void = { _ in }

    private lazy var titleLabel: UIView = {
        Ocean.Typography.heading4 { label in
            label.text = "Período"
        }
    }()

    private lazy var beginDateInput: Ocean.InputTextField = {
        Ocean.InputTextField { input in
            input.title = "Data inicial"
            input.placeholder = "dd/mm/aaaa"
            input.text = beginDate?.shortDateFormat() ?? ""
            input.image = Ocean.icon.calendarOutline
            input.keyboardType = .numberPad
//            input.parameters.onMask = { $0.maskDate() }
            input.onInfoIconTouched = { [weak self] in
                guard let self = self else { return }
                self.showDatePicker(title: "Data inicial",
                                    minDate: Date(timeIntervalSince1970: 0),
                                    selectedDate: beginDate ?? Date()) { date in
                    self.beginDate = date
//                    self.updateUI()
                }
            }
            input.onValueChanged = { [weak self]  value in
                guard let self = self else { return }
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

    private lazy var endDateInput: Ocean.InputTextField = {
        Ocean.InputTextField { input in
            input.title = "Data final"
            input.placeholder = "dd/mm/aaaa"
            input.text = endDate?.shortDateFormat() ?? ""
            input.image = Ocean.icon.calendarOutline
            input.keyboardType = .numberPad
//            input.parameters.onMask = { $0.maskDate() }
            input.onInfoIconTouched = { [weak self] in
                guard let self = self else { return }
                self.showDatePicker(title: "Data inicial",
                                    minDate: Date(timeIntervalSince1970: 0),
                                    selectedDate: endDate ?? Date()) { date in
                    self.endDate = date
//                    self.updateUI()
                }
            }
            input.onValueChanged = { [weak self]  value in
                guard let self = self else { return }
                beginDate = nil
                guard value.count >= 10 else { return }

                if let date = value.shortDateNullable() {
                    endDate = date
                } else {
                    input.errorMessage = "A data informada não é válida."
                }
            }
        }
    }()

    private lazy var contentStack: Ocean.StackView = {
        Ocean.StackView { stack in
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false

            stack.add([
                titleLabel,
                Ocean.Spacer(space: Ocean.size.spacingStackXxs),
                beginDateInput,
                Ocean.Spacer(space: Ocean.size.spacingStackXs),
                endDateInput
            ])
        }
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        add(view: contentStack)
    }

    func showModal(on viewController: UIViewController) {
        Ocean.Modal(viewController)
            .withCustomView(view: self)
            .withActionPrimary(text: "Filtrar", action: filter)
            .withActionSecondary(text: "Limpar", action: clear)
            .withDismiss(true)
            .build()
            .show()
    }

    private func filter() {
        //Validar data
        guard let beginDate = beginDate, let endDate = endDate else { return }

        onFilter(DateInterval(start: beginDate, end: endDate))
    }

    private func clear() {
        beginDate = nil
        endDate = nil
        onFilter(nil)
    }

    private func showDatePicker(title: String,
                                minDate: Date?,
                                selectedDate: Date?,
                                completion: @escaping (Date) -> Void) {
        let datePicker = Ocean.DatePicker()
        datePicker.navigationTitle = title
        datePicker.disableWeekend = false
        datePicker.minimumDate = minDate ?? Date(timeIntervalSince1970: 0)
        datePicker.maximumDate = Date(timeIntervalSince1970: .greatestFiniteMagnitude)
        datePicker.selectedDate = selectedDate ?? Date()
        datePicker.isTodaySelectable = true
        datePicker.onReleaseCalendar = completion
        datePicker.show(rootViewController: rootViewController)
    }
}


extension Ocean {
    public class ModalDateRange: Modal {
        
    }
}

extension Date {
    public func shortDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale.init(identifier: "pt-br")
        return formatter.string(from: self)
    }
}

extension String {
    public func shortDate() -> Date {
        return self.shortDateNullable() ?? Date()
    }

    public func shortDateNullable() -> Date? {
        if self.isEmpty {
            return nil
        }

        let type1 = DateFormatter()
        type1.dateFormat = "yyyy-MM-dd"

        let type2 = DateFormatter()
        type2.dateFormat = "dd/MM/yyyy"

        return type2.date(from: self) ?? type1.date(from: self)
    }
}
