//
//  MainInteractor.swift
//  outDo
//
//  Created by Антон Бондаренко on 22.08.2022.
//

import Foundation
import UIKit.UIColor

protocol MainInteractor: AnyObject {
    
    func onTapAdd()
    func onTapMenu()
    func onTapUpdate()
    func updateCells()
    func viewDidLoad()
}

final class MainInteractorImpl: MainInteractor {
    
    private let tasksProvider: TasksProvider
    weak var presenter: MainPresenter?
    
    init(tasksProvider: TasksProvider) {
        self.tasksProvider = tasksProvider
    }
    
    func onTapAdd() {
        presenter?.onHandleAction?(.add, nil)
    }
    
    func onTapMenu() {
        DialogBuilder.shared.showNavigationDrawer { [weak self] action, data in
            self?.presenter?.onHandleAction?(action, data)
        }
    }
    
    func onTapUpdate() {
        
    }
    
    func updateCells() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            let cells = self?.construct() ?? [MainCellModel]()
            DispatchQueue.main.async { [weak self] in
                self?.presenter?.setCells(cells)
            }
        }
    }
    
    func viewDidLoad() {
        makeApiTasksGet()
    }
    
    // MARK: - Api
    private func makeApiTasksGet() {
        tasksProvider.tasksGet { [weak self] response in
            self?.updateCells()
        }
    }
}

// MARK: - Factory
extension MainInteractorImpl {
    
    private func construct() -> [MainCellModel] {
        var arr = [MainCellModel]()
        tasksProvider.tasks.forEach({
            arr.append(getSpacerCell())
            arr.append(getCell(for: $0))
        })
        return arr
    }
    
    private func getSpacerCell() -> MainCellModel {
        return MainCellModelBuilder(MainSpacerCell.identifier).build()
    }
    
    private func getCell(for task: Task) -> MainCellModel {
        return MainCellModelBuilder(MainCell.identifier)
            .setTitle(task.title)
            .setText(task.text)
            .setStateColor(UIColor.getMainStateColor(task.state))
            .setBgColor(UIColor.getMainBgColor(task.state))
            .build()
    }
}
