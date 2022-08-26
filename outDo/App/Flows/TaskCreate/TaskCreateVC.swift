//
//  TaskCreateVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 26.08.2022.
//

import UIKit

protocol TaskCreateView: AnyObject {
    
}

final class TaskCreateVC: UIViewController, TaskCreateView {

    // MARK: - Properties
    var presenter: TaskCreatePresenter
    
    // MARK: - View
    init(presenter: TaskCreatePresenter) {
        self.presenter = presenter
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
