//
//  NavigationDrawerPopup.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

protocol NavigationDrawerView: AnyObject {
    
    func animateDrawer(_ isOpened: Bool)
    
    func setCells(_ cells: [NavigationDrawerCellModel])
    func setTitleAccount(_ value: String)
    func setTitleName(_ value: String)
}

final class NavigationDrawerPopup: UIViewController, NavigationDrawerView {

    // MARK: - Outlets
    @IBOutlet private weak var darkView: UIView!
    @IBOutlet private weak var drawerView: UIView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var accountLabel: UILabel!
    @IBOutlet private weak var sep: UIView!
    
    // MARK: - Constraints
    @IBOutlet private weak var cCenterY: NSLayoutConstraint!
    @IBOutlet private weak var cLeading: NSLayoutConstraint!
    @IBOutlet private weak var cWidth: NSLayoutConstraint!
    @IBOutlet private weak var cHeightHeader: NSLayoutConstraint!
    
    // MARK: - Properties
    let presenter: NavigationDrawerPresenter
    private var cells = [NavigationDrawerCellModel]()
    
    // MARK: - View
    init(presenter: NavigationDrawerPresenter) {
        self.presenter = presenter
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addGestures()
        updateData()
    }
    
    // MARK: - Private
    private func configure() {
        // fix size
        self.view.frame = UIScreen.main.bounds
        
        darkView.alpha = 0
        cWidth.constant = 300
        cLeading.constant = -cWidth.constant
        
        tableView.register(NavigationDrawerCell.nib, forCellReuseIdentifier: NavigationDrawerCell.identifier)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.isScrollEnabled = false
        tableView.bounces = false
        tableView.rowHeight = Styles.shared.button.sizeLg
        
        nameLabel.style = Styles.shared.label.b22main
        accountLabel.style = Styles.shared.label.b229796a9
        sep.backgroundColor = Styles.shared.color.sep
        
        cHeightHeader.constant = 120 + Styles.shared.view.topInset
        cCenterY.constant = Styles.shared.view.topInset * 0.5
        
        Styles.shared.addShadow(drawerView, x: 2, y: 15, a: 0.2, blur: 3, cornerRadius: 0)
    }
    
    private func addGestures() {
        darkView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(onTapView)))
        headerView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(onTapHeader)))
    }
   
    func animateDrawer(_ isOpened: Bool) {
        if isOpened {
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.darkView.alpha = 0.3
                self?.cLeading.constant = 0
                self?.view.layoutIfNeeded()
            }
        }
        else {
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.darkView.alpha = 0
                self?.cLeading.constant = -(self?.cWidth.constant ?? 0)
                self?.view.layoutIfNeeded()
            } completion: { [weak self] _ in
                guard let self = self else { return }
                DialogBuilder.shared.remove(self)
            }
        }
    }
    
    // MARK: - Data
    func updateData() {
        presenter.updateData()
    }
    
    // MARK: - Taps
    @objc func onTapHeader() {
        presenter.onTapAction(.profile, nil)
    }
    
    @objc private func onTapView() {
        presenter.isOpened = false
    }
}

// MARK: - View
extension NavigationDrawerPopup {
    
    func setCells(_ cells: [NavigationDrawerCellModel]) {
        self.cells = cells
        tableView.reloadData()
    }
    
    func setTitleAccount(_ value: String) {
        accountLabel.text = value
    }
    
    func setTitleName(_ value: String) {
        nameLabel.text = value
    }
}

//MARK: - TableView DataSource
extension NavigationDrawerPopup: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NavigationDrawerCell.identifier, for: indexPath)
        (cell as? NavigationDrawerCellUpdate)?.update(cells[indexPath.row])
        return cell
    }
}

// MARK: - TableView Delegate
extension NavigationDrawerPopup: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = cells[indexPath.row]
        presenter.onTapAction(data.action, data)
    }
}
