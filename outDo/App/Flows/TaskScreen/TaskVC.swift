//
//  TaskVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 29.08.2022.
//

import UIKit

protocol TaskView: AnyObject {
    
    func setTitle(_ value: String)
    func setTitleButton(_ value: String)
    func setCells(_ cells: [TaskCellModel])
}

final class TaskVC: UIViewController, TaskView {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var stateButton: UIButton!
    
    // MARK: - Properties
    var presenter: TaskPresenter
    private var cells = [TaskCellModel]()
    
    // MARK: - View
    init(presenter: TaskPresenter) {
        self.presenter = presenter
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        updateData()
    }
    
    // MARK: - Private
    private func configure() {
        [TaskTitleCell.self, TaskDescriptionCell.self, TaskDateCell.self].forEach({
            tableView.register($0.nib, forCellReuseIdentifier: $0.identifier)
        })
        tableView.bounces = false
        stateButton.style = Styles.shared.button.bevelDfSc
    }
    
    // MARK: - Data
    func updateData() {
        presenter.updateData()
    }
    
    // MARK: - Taps
    @IBAction func onTapStateButton(_ sender: UIButton) {
        presenter.onTapStateButton()
    }
}

// MARK: - TaskView
extension TaskVC {
    
    func setTitle(_ value: String) {
        self.title = value
    }
    
    func setTitleButton(_ value: String) {
        stateButton.setTitle(value, for: .normal)
    }
    
    func setCells(_ cells: [TaskCellModel]) {
        self.cells = cells
        tableView.reloadData()
    }
}

// MARK: - DataSource
extension TaskVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = cells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: data.cell, for: indexPath)
        (cell as? ITaskCell)?.update(data: data)
        return cell
    }
}

// MARK: - Delegate
extension TaskVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = cells[indexPath.row]
        switch data.cell {
        case TaskTitleCell.identifier:
            return 30 + data.text.getTextSize(width: tableView.bounds.width - 40, font: Styles.shared.getFont(Styles.shared.label.b22main)).height
        case TaskDateCell.identifier:
            return 40
        case TaskDescriptionCell.identifier:
            return 50 + data.text.getTextSize(width: tableView.bounds.width - 40, font: Styles.shared.getFont(Styles.shared.label.r18main)).height
        default:
            return .zero
        }
    }
}
