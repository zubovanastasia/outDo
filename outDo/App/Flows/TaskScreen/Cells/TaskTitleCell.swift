//
//  TaskTitleCell.swift
//  outDo
//
//  Created by Антон Бондаренко on 29.08.2022.
//

import UIKit

class TaskTitleCell: UITableViewCell, ITaskCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        self.backgroundColor = .clear
        titleLabel.style = Styles.shared.label.b22white
    }
    
    func update(data: TaskCellModel) {
        titleLabel.text = data.title
    }
}
