//
//  NavigationDrawerCell.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

final class NavigationDrawerCell: UITableViewCell, NavigationDrawerCellUpdate {

    // MARK: - Outlets
    @IBOutlet private weak var sep: UIView!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - View
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    // MARK: - Private
    private func configure() {
        self.backgroundColor = .clear
        sep.backgroundColor = .sep
        titleLabel.style = Styles.shared.label.r20main
    }
    
    // MARK: - Data
    func update(_ data: NavigationDrawerCellModel) {
        titleLabel.text = data.title
        iconImage.image = !data.icon.isEmpty ? UIImage(named: data.icon) : nil
    }
}

