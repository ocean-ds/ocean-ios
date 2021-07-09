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
    public class DatePicker: UIView, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
        private var dates: [Date]!
        private var firstDateToSchedule: Date!
        var calendarOverlay: UIView!
        var calendarContainer: UIView!
        var calendar: FSCalendar!
        var header: UIView!
        var headerStack: UIStackView!
        var headerYear: UILabel!
        var headerDate: UILabel!
        var backView: UIImageView!

        var calendarButtons: UIStackView!
        var calendarBackForwardButtons: UIStackView!
        var calendarContainerHeight: CGFloat = 473
        var calendarBodyHeight: CGFloat = 300
        var calendarHeaderHeight: CGFloat = 96
        var calendarButtonsContainerHeight: CGFloat = 44
        var selectedDate: Date!
        
        public var onReleaseCalendar: ((Date) -> Void)?
        public var onCancelAction: (() -> Void)?

        public var currentDate: Date? = Date()
        public var minimumDate: Date?
        public var maximumDate: Date?
        public var datesToHide: [Date]?
        
        private lazy var datePickerViewController: UIViewController = {
            let viewController = UIViewController()
            viewController.modalPresentationStyle = .overFullScreen
            viewController.modalTransitionStyle = .crossDissolve
            return viewController
        }()

        func createViews() {
            makeCalendarOverlay()
            makeCalendarContainer()
            makeCalendarHeader()
            makeCalendar()
            configCalendarHeader()
            configWeekDaysText()
            calendarContainer.addSubview(calendar)
            makeCalendarButtons()
            calendarContainer.addSubview(calendarButtons)
            makeBackForwardButtons()
            calendarContainer.addSubview(calendarBackForwardButtons)
            
            self.datePickerViewController.view.addSubview(self)
            
            self.translatesAutoresizingMaskIntoConstraints = false
            self.leftAnchor.constraint(equalTo: self.datePickerViewController.view.leftAnchor).isActive = true
            self.topAnchor.constraint(equalTo: self.datePickerViewController.view.topAnchor).isActive = true
            self.rightAnchor.constraint(equalTo: self.datePickerViewController.view.rightAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: self.datePickerViewController.view.bottomAnchor).isActive = true
        }

        func makeCalendarOverlay() {
            calendarOverlay = UIView()
            calendarOverlay.translatesAutoresizingMaskIntoConstraints = false
            calendarOverlay.backgroundColor = Ocean.color.colorInterfaceDarkPure
            calendarOverlay.alpha = 0.8
            self.addSubview(calendarOverlay)
        }

        func makeCalendarContainer() {
            calendarContainer = UIView()
            calendarContainer.translatesAutoresizingMaskIntoConstraints = false
            calendarContainer.backgroundColor = Ocean.color.colorInterfaceLightPure
            calendarContainer.layer.cornerRadius = Ocean.size.borderRadiusMd
            self.addSubview(calendarContainer)
        }

        func makeCalendarHeader() {
            header = UIView()
            header.translatesAutoresizingMaskIntoConstraints = false
            header.backgroundColor = Ocean.color.colorBrandPrimaryPure
            header.layer.cornerRadius = Ocean.size.borderRadiusMd
            if #available(iOS 11.0, *) {
                header.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            } else {
                // Fallback on earlier versions
            }

            headerStack = UIStackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .horizontal
                stack.alignment = .fill
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingInsetSm))
                stack.addArrangedSubview(UIStackView { stack in
                    stack.axis = .vertical
                    stack.alignment = .leading
                    stack.addArrangedSubview(Spacer(space: Ocean.size.spacingInsetXs))
                    stack.addArrangedSubview(Ocean.Typography.paragraph { component in
                        component.text = "2020"
                        component.textColor = Ocean.color.colorBrandPrimaryUp
                        self.headerYear = component
                    })
                    stack.addArrangedSubview(Ocean.Typography.heading1 { component in
                        component.text = "Seg, 07 de Jul"
                        component.textColor = Ocean.color.colorInterfaceLightPure
                        self.headerDate = component
                    })
                    stack.addArrangedSubview(Spacer(space: Ocean.size.spacingInsetSm))
                })
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingInsetXs))
            }
            header.addSubview(headerStack)
            self.addSubview(header)

            updateHeaderDate(date: firstDateToSchedule)
        }

        func makeCalendar() {
            calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: self.calendarBodyHeight))
            calendar.locale = Locale(identifier: "pt_BR")
            calendar.translatesAutoresizingMaskIntoConstraints = false
            calendar.dataSource = self
            calendar.delegate = self
            calendar.appearance.headerMinimumDissolvedAlpha = 0
            calendar.appearance.headerDateFormat = "MMMM YYYY"
            calendar.appearance.caseOptions = [.headerUsesUpperCase, .weekdayUsesSingleUpperCase]
            calendar.select(firstDateToSchedule)
            selectedDate = firstDateToSchedule
            calendar.placeholderType = .none
            calendar.calendarWeekdayView.backgroundColor = .white
            calendar.daysContainer.backgroundColor = Ocean.color.colorInterfaceLightPure
            calendar.appearance.eventSelectionColor = Ocean.color.colorInterfaceLightPure
            calendar.appearance.selectionColor = Ocean.color.colorComplementaryPure
            calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
            calendar.appearance.todayColor = .clear
            calendar.appearance.titleTodayColor = Ocean.color.colorBrandPrimaryPure
            calendar.appearance.titleFont = UIFont(
                name: Ocean.font.fontFamilyBaseWeightRegular,
                size: Ocean.font.fontSizeXxs)
            calendar.appearance.titleDefaultColor = Ocean.color.colorInterfaceDarkPure
            calendar.appearance.titlePlaceholderColor = .clear
            calendar.rowHeight = 60
        }

        func makeCalendarButtons() {
            calendarButtons = UIStackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.alignment = .fill
                stack.axis = .vertical
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackSm))
                stack.addArrangedSubview(UIStackView { stack in
                    stack.alignment = .trailing
                    stack.axis = .horizontal
                    stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxs))
                    stack.addArrangedSubview(Spacer(space: Ocean.size.spacingInsetXl))
                    stack.addArrangedSubview(Spacer(space: Ocean.size.spacingInsetXxs))
                    stack.addArrangedSubview(Ocean.ButtonText { component in
                        component.text = "CANCELAR"
                        component.onTouch = {
                            self.datePickerViewController.dismiss(animated: true, completion: nil)
                            self.onCancelAction?()
                        }
                    })
                    stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxs))
                    stack.addArrangedSubview(Ocean.ButtonText { component in
                        component.text = "OK"
                        component.onTouch = {
                            self.onReleaseCalendar?(self.selectedDate ?? Date())
                            self.datePickerViewController.dismiss(animated: true, completion: nil)
                        }
                    })
                    stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxs))
                })
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxs))
            }
        }

        func makeBackForwardButtons() {
            calendarBackForwardButtons = UIStackView { stack in
                stack.axis = .horizontal
                stack.alignment = .fill
                stack.translatesAutoresizingMaskIntoConstraints = false

                backView = UIImageView(image: Ocean.icon.chevronLeftOutline)
                backView.widthAnchor.constraint(equalToConstant: Ocean.size.spacingStackSm).isActive = true
                backView.heightAnchor.constraint(equalToConstant: Ocean.size.spacingStackSm).isActive = true
                backView.tintColor = Ocean.color.colorInterfaceDarkDown
                backView.isUserInteractionEnabled = true
                let backTap = UITapGestureRecognizer(target: self, action: #selector(backMonth))
                backView.addGestureRecognizer(backTap)

                let nextView = UIImageView(image: Ocean.icon.chevronRightOutline)
                nextView.widthAnchor.constraint(equalToConstant: Ocean.size.spacingStackSm).isActive = true
                nextView.heightAnchor.constraint(equalToConstant: Ocean.size.spacingStackSm).isActive = true
                nextView.tintColor = Ocean.color.colorInterfaceDarkDown
                nextView.isUserInteractionEnabled = true
                let nextTap = UITapGestureRecognizer(target: self, action: #selector(nextMonth))
                nextView.addGestureRecognizer(nextTap)

                stack.addArrangedSubview(backView)
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxxl))
                stack.addArrangedSubview(nextView)
            }
        }

        func formatter(format: String? = nil) -> DateFormatter {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "pt_BR")
            if format != nil {
                formatter.dateFormat = format
            } else {
                formatter.dateFormat = "yyyy-MM-dd"
            }
            return formatter
        }

        fileprivate func addConstraints() {
            calendarOverlay.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            calendarOverlay.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            calendarOverlay.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            calendarOverlay.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

            calendarContainer.heightAnchor.constraint(
                equalToConstant: self.calendarContainerHeight + Ocean.size.spacingStackSm).isActive = true
            calendarContainer.leftAnchor.constraint(
                equalTo: self.layoutMarginsGuide.leftAnchor,
                constant: Ocean.size.spacingStackXs).isActive = true
            calendarContainer.rightAnchor.constraint(
                equalTo: self.layoutMarginsGuide.rightAnchor,
                constant: -Ocean.size.spacingStackXs).isActive = true
            calendarContainer.centerXAnchor.constraint(
                equalTo: self.layoutMarginsGuide.centerXAnchor).isActive = true
            calendarContainer.centerYAnchor.constraint(
                equalTo: self.layoutMarginsGuide.centerYAnchor).isActive = true

            header.heightAnchor.constraint(equalToConstant: self.calendarHeaderHeight).isActive = true
            header.topAnchor.constraint(equalTo: calendarContainer.topAnchor).isActive = true
            header.leftAnchor.constraint(equalTo: calendarContainer.leftAnchor).isActive = true
            header.rightAnchor.constraint(equalTo: calendarContainer.rightAnchor).isActive = true

            headerStack.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
            headerStack.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
            headerStack.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
            headerStack.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true

            calendar.heightAnchor.constraint(equalToConstant: self.calendarBodyHeight).isActive = true
            calendar.topAnchor.constraint(equalTo: header.bottomAnchor,
                                          constant: Ocean.size.spacingStackXs).isActive = true
            calendar.leftAnchor.constraint(equalTo: calendarContainer.leftAnchor,
                                           constant: Ocean.size.spacingStackXs).isActive = true
            calendar.rightAnchor.constraint(equalTo: calendarContainer.rightAnchor,
                                            constant: -Ocean.size.spacingStackXs).isActive = true

            calendarButtons.topAnchor.constraint(equalTo: calendar.bottomAnchor).isActive = true
            calendarButtons.leftAnchor.constraint(equalTo: calendarContainer.leftAnchor).isActive = true
            calendarButtons.rightAnchor.constraint(equalTo: calendarContainer.rightAnchor).isActive = true

            calendarBackForwardButtons.topAnchor.constraint(equalTo: calendar.topAnchor,
                                                            constant: Ocean.size.spacingInsetXs).isActive = true
            calendarBackForwardButtons.leftAnchor.constraint(equalTo: calendar.leftAnchor).isActive = true
            calendarBackForwardButtons.rightAnchor.constraint(equalTo: calendar.rightAnchor).isActive = true
            calendarBackForwardButtons.heightAnchor.constraint(equalToConstant: Ocean.size.spacingStackSm).isActive = true
        }

        public override func didMoveToSuperview() {
            super.didMoveToSuperview()

            if superview != nil {
                self.addConstraints()
            }
        }

        public convenience init(builder: (DatePicker) -> Void) {
            self.init(frame: .zero)
            builder(self)
            loadDates()
            createViews()
        }
        
        @objc func backMonth() {
            calendar.setCurrentPage(getPreviousMonth(date: calendar.currentPage), animated: true)
        }

        @objc func nextMonth() {
            calendar.setCurrentPage(getNextMonth(date: calendar.currentPage), animated: true)
        }

        func getPreviousMonth(date: Date) -> Date {
            return  Calendar.current.date(byAdding: .month, value: -1, to: date)!
        }

        func getNextMonth(date: Date) -> Date {
            return  Calendar.current.date(byAdding: .month, value: 1, to: date)!
        }

        func configCalendarHeader() {
            calendar.calendarHeaderView.backgroundColor = .white
            calendar.appearance.headerTitleFont = UIFont(
                name: Ocean.font.fontFamilyBaseWeightBold,
                size: Ocean.font.fontSizeXs)
            calendar.appearance.headerTitleColor = Ocean.color.colorInterfaceDarkDeep
        }

        func configWeekDaysText() {
            for label in calendar.calendarWeekdayView.weekdayLabels {
                label.font = UIFont(name: Ocean.font.fontFamilyBaseWeightRegular, size: Ocean.font.fontSizeXxxs)
                label.textColor = Ocean.color.colorInterfaceDarkDown
            }

            calendar.calendarWeekdayView.weekdayLabels[0].text = "D"
            calendar.calendarWeekdayView.weekdayLabels[1].text = "S"
            calendar.calendarWeekdayView.weekdayLabels[2].text = "T"
            calendar.calendarWeekdayView.weekdayLabels[3].text = "Q"
            calendar.calendarWeekdayView.weekdayLabels[4].text = "Q"
            calendar.calendarWeekdayView.weekdayLabels[5].text = "S"
            calendar.calendarWeekdayView.weekdayLabels[6].text = "S"
        }
        
        public func show(rootViewController: UIViewController) {
            rootViewController.present(self.datePickerViewController, animated: true, completion: nil)
        }

        private func getFirstDateToSchedule() {
            for date in dates {
                if isDateEnabled(date: date) {
                    firstDateToSchedule = date
                    break
                }
            }
        }

        private func dateIsToday(date: Date) -> Bool {
            getFormatedDate(date: date) == getFormatedDate(date: Date())
        }

        private func loadDates() {
            dates = datesRange(fromDate: minimumDate!, toDate: maximumDate!)
            getFirstDateToSchedule()
        }

        private func updateHeaderDate(date: Date) {
            let year = formatter(format: "yyyy").string(from: date)
            let day =  capitalizingFirstLetter(value: formatter(format: "E, d 'de' MMM").string(from: date))
            self.headerYear.text = year
            self.headerDate.text = day
        }

        public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            selectedDate = date
            updateHeaderDate(date: date)
        }
        
        private func capitalizingFirstLetter(value: String) -> String {
            return value.prefix(1).uppercased() + value.lowercased().dropFirst()
        }
        
        private func datesRange(fromDate: Date, toDate: Date) -> [Date] {
            if fromDate > toDate { return [Date]() }

            var tempDate = fromDate
            var array = [tempDate]

            while tempDate < toDate {
                tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
                array.append(tempDate)
            }

            return array
        }

        private func getFormatedDate(date: Date) -> String {
            return formatter().string(from: date)
        }

        private func isDateEnabled(date: Date) -> Bool {
            if getFormatedDate(date: date) == getFormatedDate(date: Date()) {
                return false
            }

            if Calendar.current.isDateInWeekend(date) {
                return false
            }

            if let nonAvailableDates = datesToHide {
                if nonAvailableDates.contains(date) {
                    return false
                }
            }

            if dates.contains(date) {
                return true
            } else {
                return false
            }
        }

        public func calendar(_ calendar: FSCalendar,
                             shouldSelect date: Date,
                             at monthPosition: FSCalendarMonthPosition) -> Bool {
            return isDateEnabled(date: date) ? true : false
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
    }
}
