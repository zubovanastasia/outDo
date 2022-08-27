//
//  MainVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 05.08.2022.
//

import UIKit

protocol MainView: AnyObject {

    func setCells(_ cells: [MainCellModel])
    func setTitle(_ value: String)
}

final class MainVC: UIViewController, MainView {
    
    // MARK: - Outlets
    @IBOutlet private weak var addButton: MainAddButton!
    @IBOutlet private weak var tableView: UITableView!
    private var menuButton: UIButton!
    
    // MARK: - Properties
    var presenter: MainPresenter
    private var cells = [MainCellModel]()
    
    // MARK: - View
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter.viewDidLoad()
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
        
        addButton.onTap = { [weak self] in
            self?.presenter.onTapAdd()
        }
    }
    
    // MARK: - Data
    func updateData() {
        presenter.updateData()
    }
    
    // MARK: - Taps
     @objc private func onTapMenu(_ sender: UIButton) {
         self.presenter.onTapMenu()
     }

//     @IBAction func onTapUpdate(_ sender: UIButton) {
//         self.presenter?.onTapUpdate()
//     }
}

// MARK: - MainView
extension MainVC {
    
    func setCells(_ cells: [MainCellModel]) {
        self.cells = cells
        tableView.reloadData()
    }
    
    func setTitle(_ value: String) {
        self.title = value
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
        let data = cells[indexPath.row]
        switch data.cell {
        case MainSpacerCell.identifier: return 20
        default:
            let size = data.text.getTextSize(width: tableView.bounds.width - 40, font: Styles.shared.getFont(Styles.shared.label.r16mainA05))
            let textHeight = size.height > 150 ? 150 : ceil(size.height)
            return data.text.isEmpty ? 75 : 75 + textHeight//120
        }
    }
}
