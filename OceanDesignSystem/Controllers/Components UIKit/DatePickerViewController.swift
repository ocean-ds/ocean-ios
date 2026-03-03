//
//  DatePickerViewController.swift
//  OceanDesignSystem
//
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens
import OceanComponents

final class DatePickerViewController: UIViewController {

    private lazy var stack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = Ocean.size.spacingStackXs
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setMargins(horizontal: Ocean.size.spacingStackXs)
        return stack
    }()

    private lazy var basicExampleButton: Ocean.ButtonPrimary = {
        Ocean.Button.primaryMD { [weak self] button in
            button.text = "Exemplo básico"
            button.onTouch = { self?.showBasicExample() }
        }
    }()

    private lazy var tooltipExampleButton: Ocean.ButtonPrimary = {
        Ocean.Button.primaryMD { [weak self] button in
            button.text = "Exemplo com tooltip"
            button.onTouch = { self?.showTooltipExample() }
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Ocean.color.colorInterfaceLightPure
        title = "DatePicker"

        stack.add([
            Ocean.Typography.description { label in
                label.text = "Toque em um dos botões para abrir o DatePicker."
                label.numberOfLines = 0
            },
            Ocean.Spacer(space: Ocean.size.spacingStackXxs),
            basicExampleButton,
            tooltipExampleButton
        ])

        view.addSubview(stack)
        stack.oceanConstraints
            .topToTop(to: view, constant: Ocean.size.spacingStackSm, safeArea: true)
            .leadingToLeading(to: view)
            .trailingToTrailing(to: view)
            .make()
    }

    private func showBasicExample() {
        let datePicker = Ocean.DatePicker()
        datePicker.navigationTitle = "Agendar para"
        datePicker.title = "Para qual dia você quer agendar?"
        datePicker.subtitle = "Você precisa ter saldo disponível no dia escolhido para que a transferência seja realizada."
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -10, to: Date())!
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())!
        datePicker.datesToHide = [Calendar.current.date(byAdding: .day, value: 1, to: Date())!]
        datePicker.selectedDate = Calendar.current.date(byAdding: .day, value: -12, to: Date())!
        datePicker.isTodaySelectable = false
        datePicker.onCancel = { print("DatePicker cancel") }
        datePicker.onReleaseCalendar = { date in print("DatePicker \(date)") }
        datePicker.show(rootViewController: self)
    }

    private func showTooltipExample() {
        let tooltipDate1 = Calendar.current.date(byAdding: .day, value: 3, to: Date())!.onlyDate
        let tooltipDate2 = Calendar.current.date(byAdding: .day, value: 5, to: Date())!.onlyDate
        let datePicker = Ocean.DatePicker()
        datePicker.navigationTitle = "Agendar para"
        datePicker.title = "Escolha uma data"
        datePicker.subtitle = "As datas desabilitadas possuem restrição. Toque nelas para ver o motivo."
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -10, to: Date())!
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())!
        datePicker.datesToHide = [tooltipDate1, tooltipDate2]
        datePicker.selectedDate = Date()
        datePicker.isTodaySelectable = true
        let tooltipConfig1 = Ocean.DatePicker.TooltipConfiguration(
            text: "Esta data não está disponível para agendamento. Tente escolher outro dia.",
            date: tooltipDate1,
            showOnOpen: true,
            showOnDateTap: true,
            position: .bottom,
            onTooltipTouch: { print("Tooltip data 1 foi tocado") }
        )
        let tooltipConfig2 = Ocean.DatePicker.TooltipConfiguration(
            text: "Manutenção programada nesta data. Escolha outro dia.",
            date: tooltipDate2,
            showOnOpen: false,
            showOnDateTap: true,
            position: .bottom,
            onTooltipTouch: { print("Tooltip data 2 foi tocado") }
        )
        datePicker.tooltipConfigurations = [tooltipDate1: tooltipConfig1, tooltipDate2: tooltipConfig2]
        datePicker.onCancel = { print("DatePicker cancel") }
        datePicker.onReleaseCalendar = { date in print("DatePicker \(date)") }
        datePicker.show(rootViewController: self)
    }
}
