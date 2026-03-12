//
//  Ocean+DatePicker.swift
//  OceanComponents-OceanComponents
//
//  Created by Vini on 21/06/21.
//

import OceanTokens
import UIKit
import FSCalendar

extension Ocean {
    public class DatePicker:
        UIViewController,
        FSCalendarDataSource,
        FSCalendarDelegate,
        FSCalendarDelegateAppearance,
        UIGestureRecognizerDelegate,
        OceanNavigationBar {
        
        // MARK: Properties
        
        public var navigationTitle: String = ""
        public var navigationBackgroundColor: UIColor? = Ocean.color.colorInterfaceLightPure
        public var navigationTintColor: UIColor = Ocean.color.colorBrandPrimaryPure

        public var selectedDate = Date() {
            didSet {
                selectedDate = selectedDate.onlyDate
            }
        }

        public var minimumDate = Date() {
            didSet {
                minimumDate = minimumDate.onlyDate
            }
        }

        public var maximumDate = Date() {
            didSet {
                maximumDate = maximumDate.onlyDate
            }
        }

        public var datesToHide: [Date] = [] {
            didSet {
                datesToHide = datesToHide.map { $0.onlyDate }
            }
        }

        public var subtitle: String = ""
        public var disableWeekend: Bool = true
        public var isTodaySelectable: Bool = true
        public var onReleaseCalendar: ((Date) -> Void)?
        public var onCancel: (() -> Void)?
        public var tooltipConfigurations: [Date: TooltipConfiguration] = [:]

        // MARK: - TooltipConfiguration

        public struct TooltipConfiguration {
            public var text: String
            public var date: Date
            public var showOnOpen: Bool
            public var showOnDateTap: Bool
            public var position: Ocean.Tooltip.Position
            public var onTooltipTouch: (() -> Void)?

            public init(
                text: String,
                date: Date,
                showOnOpen: Bool = false,
                showOnDateTap: Bool = true,
                position: Ocean.Tooltip.Position = .bottom,
                onTooltipTouch: (() -> Void)? = nil
            ) {
                self.text = text
                self.date = date.onlyDate
                self.showOnOpen = showOnOpen
                self.showOnDateTap = showOnDateTap
                self.position = position
                self.onTooltipTouch = onTooltipTouch
            }
        }

        // MARK: Main View
        
        private lazy var titleLabel: UILabel = {
            let label = Ocean.Typography.heading3()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = title
            label.numberOfLines = 2
            label.isHidden = title?.isEmpty == true
            return label
        }()
        
        private lazy var subtitleLabel: UILabel = {
            let label = Ocean.Typography.description()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = subtitle
            label.numberOfLines = 2
            label.isHidden = subtitle.isEmpty
            return label
        }()
        
        private lazy var backView: UIImageView = {
            let view = UIImageView(image: Ocean.icon.chevronLeftSolid?.withRenderingMode(.alwaysTemplate))
            view.contentMode = .scaleAspectFit
            view.widthAnchor.constraint(equalToConstant: Ocean.size.spacingStackSm).isActive = true
            view.heightAnchor.constraint(equalToConstant: Ocean.size.spacingStackSm).isActive = true
            view.tintColor = Ocean.color.colorBrandPrimaryPure
            view.addTapGesture(target: self, selector: #selector(backMonth))
            return view
        }()
        
        private lazy var nextView: UIImageView = {
            let view = UIImageView(image: Ocean.icon.chevronRightSolid?.withRenderingMode(.alwaysTemplate))
            view.contentMode = .scaleAspectFit
            view.widthAnchor.constraint(equalToConstant: Ocean.size.spacingStackSm).isActive = true
            view.heightAnchor.constraint(equalToConstant: Ocean.size.spacingStackSm).isActive = true
            view.tintColor = Ocean.color.colorBrandPrimaryPure
            view.addTapGesture(target: self, selector: #selector(nextMonth))
            return view
        }()
        
        private lazy var navigateButtonsStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.alignment = .fill
                stack.translatesAutoresizingMaskIntoConstraints = false
                
                stack.add([
                    backView,
                    UIView(),
                    nextView
                ])
                
                stack.setMargins(horizontal: Ocean.size.spacingStackXs)
            }
        }()
        
        private lazy var headerStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.alignment = .fill
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.spacing = Ocean.size.spacingStackXxs
                
                stack.add([
                    titleLabel,
                    subtitleLabel,
                    Ocean.Spacer(space: Ocean.size.spacingStackXxs),
                    navigateButtonsStack
                ])
            }
        }()
        
        private lazy var calendar: FSCalendar = {
            let calendar = FSCalendar()
            calendar.locale = Locale(identifier: "pt_BR")
            calendar.translatesAutoresizingMaskIntoConstraints = false
            calendar.dataSource = self
            calendar.delegate = self
            calendar.appearance.caseOptions = [.headerUsesCapitalized, .weekdayUsesSingleUpperCase]
            calendar.placeholderType = .none
            calendar.calendarWeekdayView.backgroundColor = .white
            calendar.daysContainer.backgroundColor = Ocean.color.colorInterfaceLightPure
            calendar.appearance.eventSelectionColor = Ocean.color.colorInterfaceLightPure
            calendar.appearance.selectionColor = Ocean.color.colorComplementaryPure
            calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
            calendar.appearance.todayColor = .clear
            calendar.appearance.titleTodayColor = Ocean.color.colorBrandPrimaryPure
            calendar.appearance.titleFont = UIFont(name: Ocean.font.fontFamilyBaseWeightRegular,
                                                   size: Ocean.font.fontSizeXxs)
            calendar.appearance.titleDefaultColor = Ocean.color.colorInterfaceDarkPure
            calendar.appearance.titlePlaceholderColor = .clear
            calendar.rowHeight = 60
            calendar.calendarHeaderView.backgroundColor = .white
            calendar.appearance.headerMinimumDissolvedAlpha = 0
            calendar.appearance.headerTitleOffset = CGPoint(x: 0, y: -Ocean.size.spacingStackXxs)
            calendar.appearance.headerTitleFont = UIFont(name: Ocean.font.fontFamilyHighlightWeightBold,
                                                         size: Ocean.font.fontSizeXs)
            calendar.appearance.headerTitleColor = Ocean.color.colorInterfaceDarkDeep
            for label in calendar.calendarWeekdayView.weekdayLabels {
                label.font = UIFont(name: Ocean.font.fontFamilyBaseWeightRegular,
                                    size: Ocean.font.fontSizeXxxs)
                label.textColor = Ocean.color.colorInterfaceDarkDown
            }
            calendar.calendarWeekdayView.weekdayLabels[0].text = "Dom"
            calendar.calendarWeekdayView.weekdayLabels[1].text = "Seg"
            calendar.calendarWeekdayView.weekdayLabels[2].text = "Ter"
            calendar.calendarWeekdayView.weekdayLabels[3].text = "Qua"
            calendar.calendarWeekdayView.weekdayLabels[4].text = "Qui"
            calendar.calendarWeekdayView.weekdayLabels[5].text = "Sex"
            calendar.calendarWeekdayView.weekdayLabels[6].text = "Sáb"
            return calendar
        }()
        
        private lazy var calendarTapGesture: UITapGestureRecognizer = {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(handleCalendarTap(_:)))
            gesture.delegate = self
            gesture.cancelsTouchesInView = false
            return gesture
        }()
        
        // MARK: Bottom View
        
        private lazy var confirmButton: Ocean.ButtonPrimary = {
            Ocean.Button.primaryMD { button in
                button.text = "Confirmar"
                button.onTouch = {
                    self.dismiss(animated: true, completion: nil)
                    self.onReleaseCalendar?(self.selectedDate)
                }
            }
        }()
        
        // MARK: Lifecycle View

        public override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            loadDates()
            addCloseButton(action: #selector(closeClick))
        }

        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            setupNavigation()
        }

        public override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            tryShowTooltipOnOpen()
        }
        
        // MARK: Setup
        
        private func setupUI() {
            self.view.backgroundColor = Ocean.color.colorInterfaceLightPure
            self.view.addSubviews(calendar, confirmButton, headerStack)
            calendar.addGestureRecognizer(calendarTapGesture)
            
            NSLayoutConstraint.activate([
                headerStack.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: Ocean.size.spacingStackXxxs),
                headerStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Ocean.size.spacingStackXs),
                headerStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Ocean.size.spacingStackXs),
                calendar.topAnchor.constraint(equalTo: self.headerStack.bottomAnchor, constant: -Ocean.size.spacingStackSm),
                calendar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Ocean.size.spacingStackXs),
                calendar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Ocean.size.spacingStackXs),
                calendar.heightAnchor.constraint(equalToConstant: 328),
                confirmButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Ocean.size.spacingStackXs),
                confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Ocean.size.spacingStackXs),
                confirmButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -Ocean.size.spacingStackXs)
            ])
        }
        
        // MARK: Public functions

        public func show(rootViewController: UIViewController) {
            DispatchQueue.main.async { [weak rootViewController] in
                guard let rootViewController = rootViewController else { return }

                if let presentedViewController = rootViewController.presentedViewController {
                    presentedViewController.dismiss(animated: true) {
                        let navigationController = UINavigationController(rootViewController: self)
                        navigationController.modalTransitionStyle = .coverVertical
                        navigationController.modalPresentationStyle = .overFullScreen
                        rootViewController.present(navigationController, animated: true, completion: nil)
                    }
                } else {
                    let navigationController = UINavigationController(rootViewController: self)
                    navigationController.modalTransitionStyle = .coverVertical
                    navigationController.modalPresentationStyle = .overFullScreen
                    rootViewController.present(navigationController, animated: true, completion: nil)
                }
            }
        }

        public func minimumDate(for calendar: FSCalendar) -> Date {
            return minimumDate
        }

        public func maximumDate(for calendar: FSCalendar) -> Date {
            return maximumDate
        }

        public func calendar(_ calendar: FSCalendar,
                             didSelect date: Date,
                             at monthPosition: FSCalendarMonthPosition) {
            selectedDate = date
        }

        public func calendar(_ calendar: FSCalendar,
                             shouldSelect date: Date,
                             at monthPosition: FSCalendarMonthPosition) -> Bool {
            return isDateEnabled(date: date)
        }
        
        public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            true
        }
        
        @objc private func handleCalendarTap(_ gesture: UITapGestureRecognizer) {
            let point = gesture.location(in: calendar)

            for cell in calendar.visibleCells() {
                guard let fsCell = cell as? FSCalendarCell else { continue }

                let frameInCalendar = fsCell.convert(fsCell.bounds, to: calendar)

                guard frameInCalendar.contains(point) else { continue }

                guard let date = calendar.date(for: fsCell) else { continue }

                let dateOnly = date.onlyDate

                guard let config = tooltipConfiguration(for: dateOnly), config.showOnDateTap else { break }

                showTooltip(for: dateOnly, at: .current, config: config, cell: fsCell)
                break
            }
        }

        public func calendar(_ calendar: FSCalendar,
                             appearance: FSCalendarAppearance,
                             titleDefaultColorFor date: Date) -> UIColor? {
            var color: UIColor = Ocean.color.colorInterfaceDarkUp

            if isDateEnabled(date: date) {
                color = Ocean.color.colorInterfaceDarkPure
            }

            if dateIsToday(date: date) {
                color = Ocean.color.colorBrandPrimaryPure
            }

            return color
        }
        
        // MARK: Private functions

        private func formatter(format: String? = nil) -> DateFormatter {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "pt_BR")
            if format != nil {
                formatter.dateFormat = format
            } else {
                formatter.dateFormat = "yyyy-MM-dd"
            }
            return formatter
        }

        private func getPreviousMonth(date: Date) -> Date {
            return Calendar.current.date(byAdding: .month, value: -1, to: date) ?? date
        }

        private func getNextMonth(date: Date) -> Date {
            return Calendar.current.date(byAdding: .month, value: 1, to: date) ?? date
        }

        private func dateIsToday(date: Date) -> Bool {
            getFormatedDate(date: date) == getFormatedDate(date: Date().onlyDate)
        }

        private func loadDates() {
            calendar.reloadData()
            if !isInRange(date: selectedDate, minDate: minimumDate, maxDate: maximumDate) {
                selectedDate = minimumDate
            }
            calendar.select(selectedDate)
        }

        private func getFormatedDate(date: Date) -> String {
            return formatter().string(from: date)
        }

        private func isDateEnabled(date: Date) -> Bool {
            if !isTodaySelectable, dateIsToday(date: date) {
                return false
            }

            if disableWeekend && Calendar.current.isDateInWeekend(date) {
                return false
            }

            if datesToHide.contains(date) {
                return false
            }

            if isInRange(date: date, minDate: minimumDate, maxDate: maximumDate) {
                return true
            } else {
                return false
            }
        }

        private func isInRange(date: Date, minDate: Date, maxDate: Date) -> Bool {
            return date >= minDate && date <= maxDate
        }
        
        @objc private func closeClick() {
            self.dismiss(animated: true, completion: nil)
            self.onCancel?()
        }
        
        @objc private func backMonth() {
            calendar.setCurrentPage(getPreviousMonth(date: calendar.currentPage), animated: true)
        }
        
        @objc private func nextMonth() {
            calendar.setCurrentPage(getNextMonth(date: calendar.currentPage), animated: true)
        }

        private func tooltipConfiguration(for date: Date) -> TooltipConfiguration? {
            let cal = Calendar.current
            return tooltipConfigurations.first { cal.isDate($0.key, inSameDayAs: date) }?.value
        }

        private func tryShowTooltipOnOpen() {
            let currentPage = calendar.currentPage
            let cal = Calendar.current
            for (configDate, config) in tooltipConfigurations where config.showOnOpen {
                guard cal.isDate(configDate, equalTo: currentPage, toGranularity: .month) else { continue }
                showTooltip(for: configDate, at: .current, config: config, cell: nil)
            }
        }

        private func showTooltip(for date: Date, at monthPosition: FSCalendarMonthPosition, config: TooltipConfiguration, cell: FSCalendarCell? = nil) {
            let targetCell: FSCalendarCell
            if let cell = cell {
                targetCell = cell
            } else if let calendarCell = calendar.cell(for: date, at: monthPosition) {
                targetCell = calendarCell
            } else {
                return
            }
            let tooltip = Ocean.Tooltip { tip in
                tip.message = config.text
                tip.onTouch = config.onTooltipTouch
                tip.indicatorMargin = Ocean.size.spacingStackXxxs
            }
            tooltip.show(target: targetCell, position: config.position, presenter: view)
        }
    }
}
