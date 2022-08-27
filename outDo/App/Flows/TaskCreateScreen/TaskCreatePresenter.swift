//
//  TaskCreatePresenter.swift
//  outDo
//
//  Created by Антон Бондаренко on 26.08.2022.
//

import UIKit

protocol TaskCreatePresenter: AnyObject {
    
    // MARK: - Coordinator
    var onBack: VoidClosure? { get set }
    
    func back()
    func onDidChangeTitle(_ value: String)
    func onDidChangeText(_ value: String)
    func onTapDate()
    func onTapSave()
    func setDate()
    func updateData()
}

final class TaskCreatePresenterImpl: TaskCreatePresenter {
    
    // MARK: - Coordinator
    var onBack: VoidClosure?
    
    private var interactor: TaskCreateInteractor
    weak var view: (UIViewController & TaskCreateView)?
    
    init(interactor: TaskCreateInteractor) {
        self.interactor = interactor
    }
    
    func back() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func onDidChangeTitle(_ value: String) {
        interactor.onDidChangeTitle(value)
    }
    
    func onDidChangeText(_ value: String) {
        interactor.onDidChangeText(value)
    }
    
    func onTapDate() {
        interactor.onTapDate()
    }
    
    func onTapSave() {
        interactor.onTapSave()
    }
    
    func setDate() {
        view?.setTextfield(interactor.task.fromDateValue > 0 ? interactor.task.fromDateDate.withFormat("d MMM, HH:mm") : "", for: .date)
    }
    
    func updateData() {
        view?.setTitle(Locales.value("vc_taskCreate_title"))
        view?.setTitleSave(Locales.value("navbar_create"))
        view?.setPlaceholder(Locales.value("vc_taskCreate_name"), for: .title)
        view?.setPlaceholder(Locales.value("vc_taskCreate_date"), for: .date)
        view?.setPlaceholder(Locales.value("vc_taskCreate_desc"), for: .desc)
        view?.setTextfield(interactor.task.title, for: .title)
        view?.setTextfield(interactor.task.text, for: .desc)
        setDate()
    }
}

