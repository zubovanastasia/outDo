//
//  TaskDescriptionCell.swift
//  outDo
//
//  Created by Антон Бондаренко on 29.08.2022.
//

import UIKit

final class TaskDescriptionCell: UITableViewCell, ITaskCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        self.backgroundColor = .clear
        titleLabel.style = Styles.shared.label.r20white
        valueLabel.style = Styles.shared.label.r18whiteA07
    }
    
    func update(data: TaskCellModel) {
        titleLabel.text = data.title
        valueLabel.text = data.text
    }
}