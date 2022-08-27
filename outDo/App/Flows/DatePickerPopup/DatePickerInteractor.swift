//
//  DatePickerInteractor.swift
//  outDo
//
//  Created by Антон Бондаренко on 27.08.2022.
//

import Foundation

protocol DatePickerInteractor: AnyObject {
    
    var date: Date { get }
    var minDate: Date { get }
    
    func onTapApply(_ date: Date)
    func onTapCancel()
}

final class DatePickerInteractorImpl: DatePickerInteractor {
    
    weak var presenter: DatePickerPresenter?
    var date: Date
    var minDate: Date
    
    init(date: Date?) {
        self.date = date ?? Date()
        self.minDate = Date()
    }
    
    func onTapApply(_ date: Date) {
        presenter?.onApply?(date)
        presenter?.hide()
    }
    
    func onTapCancel() {
        presenter?.hide()
    }
}
