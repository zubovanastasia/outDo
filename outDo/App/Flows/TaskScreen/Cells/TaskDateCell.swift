//
//  TaskDateCell.swift
//  outDo
//
//  Created by Антон Бондаренко on 29.08.2022.
//

import UIKit

class TaskDateCell: UITableViewCell, ITaskCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        self.backgroundColor = .clear
        titleLabel.style = Styles.shared.label.r18white
        valueLabel.style = Styles.shared.label.b22white
    }
    
    func update(data: TaskCellModel) {
        titleLabel.text = data.title
        valueLabel.text = data.text
    }
}
