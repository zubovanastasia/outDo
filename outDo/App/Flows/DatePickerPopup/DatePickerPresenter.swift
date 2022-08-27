//
//  DatePickerPresenter.swift
//  outDo
//
//  Created by Антон Бондаренко on 27.08.2022.
//

import UIKit

protocol DatePickerPresenter: AnyObject {
    
    var onApply: DateClosure? { get set }
    
    func initMinimumDate()
    func initDate()
    func hide()
    func onTapApply(_ date: Date)
    func onTapCancel()
    func setDate(_ value: Date, animated: Bool)
    func setMinimumDate(_ value: Date)
    func updateData()
    func viewDidDisappear()
}

final class DatePickerPresenterImpl: DatePickerPresenter {
    
    var onApply: DateClosure?
    
    private let interactor: DatePickerInteractor
    weak var view: (UIViewController & DatePickerView)?
    
    init(interactor: DatePickerInteractor) {
        self.interactor = interactor
    }
    
    func viewDidDisappear() {
        guard let view = view else { return }
        DialogBuilder.shared.remove(view)
    }
    
    func initMinimumDate() {
        setMinimumDate(interactor.minDate)
    }
    
    func initDate() {
        setDate(interactor.date, animated: false)
    }
    
    func hide() {
        guard let view = view else { return }
        DialogBuilder.shared.remove(view, animated: true)
    }
    
    func setDate(_ value: Date, animated: Bool) {
        view?.setDate(value, animated: animated)
    }
    
    func setMinimumDate(_ value: Date) {
        view?.setMinimumDate(value)
    }
    
    func onTapApply(_ date: Date) {
        interactor.onTapApply(date)
    }
    
    func onTapCancel() {
        interactor.onTapCancel()
    }
    
    func updateData() {
        view?.setTitle(Locales.value("popup_dialogPicker_title"))
        view?.setTitleButtonApply(Locales.value("dialog_button_save"))
        view?.setTitleButtonCancel(Locales.value("dialog_button_cancel"))
        setDate(interactor.date, animated: true)
    }
}
