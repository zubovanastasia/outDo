//
//  MainVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 05.08.2022.
//

import UIKit

protocol MainView: AnyObject {

}

class MainVC: UIViewController, MainView {
    
    
    @IBOutlet weak var addTask: UIButton!
    @IBOutlet weak var menuTask: UIButton!
    @IBOutlet weak var resetTask: UIButton!
    @IBOutlet weak var dateTask: UIDatePicker!
    private static let taskVCID = "taskVCID"
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var taskView: TaskVC!

    // MARK: - Outlets
    private var menuTask: UIButton!
    
    
    // MARK: - Properties
    var presenter: MainPresenter
    
    
    // MARK: - View
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.register(UINib(nibName: "TaskVC", bundle: nil),
                                forCellReuseIdentifier: MainVC.taskVCID)
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.estimatedRowHeight = 100
        self.tableview.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        cell.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        self.presenter.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
     @IBAction func menuTask(_ sender: UIButton) {
    
     }

     @IBAction func resetTask(_ sender: UIButton) {
    
     }

     @IBAction func addTask(_ sender: UIButton) {
    // TODO: . add
         
     }

override func viewDidLoad() {
    super.viewDidLoad()
    
}
}

    
    // MARK: - Private
    private func configure() {
        menuButton = UIButton(type: .custom)
        menuButton.frame = CGRect(x: 0, y: 0, width: 28, height: 44)
        menuButton.setImage(UIImage(named: Assets.shared.appbarMenu), for: .normal)
        menuButton.addTarget(self, action: #selector(onTapNavbarMenu), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItems = [
            UIBarButtonItem(customView: menuButton)
        ]
    }
    
    // MARK: - Taps
    @objc private func onTapNavbarMenu() {
        self.presenter.onTapNavbarMenu()
    }
}
