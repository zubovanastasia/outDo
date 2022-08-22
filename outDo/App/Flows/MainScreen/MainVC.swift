//
//  MainVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 05.08.2022.
//

import UIKit

protocol MainView: AnyObject {

    func setCells(_ cells: [MainCellModel])
}

class MainVC: UIViewController, MainView {
    
    // MARK: - Outlets
    @IBOutlet private weak var addButton: UIButton!
//    @IBOutlet private weak var updateButton: UIButton!
//    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var tableView: UITableView!
    private var menuButton: UIButton!
    
    // MARK: - Properties
    var presenter: MainPresenter?
    private var cells = [MainCellModel]()
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter?.viewDidLoad()
        updateData()
    }
    
    // MARK: - Private
    private func configure() {
        menuButton = UIButton(type: .custom)
        menuButton.frame = CGRect(x: 0, y: 0, width: 28, height: 44)
        menuButton.setImage(UIImage(named: Assets.shared.appbarMenu), for: .normal)
        menuButton.addTarget(self, action: #selector(onTapMenu), for: .touchUpInside)

        self.navigationItem.leftBarButtonItems = [
            UIBarButtonItem(customView: menuButton)
        ]
        
        tableView.register(MainCell.nib, forCellReuseIdentifier: MainCell.identifier)
        tableView.register(MainSpacerCell.nib, forCellReuseIdentifier: MainSpacerCell.identifier)
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        tableView.bounces = false
        
        addButton.style = Styles.shared.button.bevelDfSc
        addButton.setTitle("", for: .normal)
        
        self.view.frame = UIScreen.main.bounds
    }
    
    // MARK: - Data
    func updateData() {
        presenter?.updateData()
    }
    
    // MARK: - Taps
     @objc private func onTapMenu(_ sender: UIButton) {
         self.presenter?.onTapMenu()
     }

//     @IBAction func onTapUpdate(_ sender: UIButton) {
//         self.presenter?.onTapUpdate()
//     }

     @IBAction func onTapAdd(_ sender: UIButton) {
         self.presenter?.onTapAdd()
     }
}

// MARK: - MainView
extension MainVC {
    
    func setCells(_ cells: [MainCellModel]) {
        self.cells = cells
        tableView.reloadData()
    }
}

// MARK: - DataSource
extension MainVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = cells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: data.cell, for: indexPath)
        (cell as? MainCell)?.updateData(data)
        return cell
    }
}

// MARK: - Delegate
extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cells[indexPath.row].cell == MainCell.identifier ? 140 : 20
    }
}
