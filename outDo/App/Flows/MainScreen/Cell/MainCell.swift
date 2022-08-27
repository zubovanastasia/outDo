//
//  MainCell.swift
//  outDo
//
//  Created by Антон Бондаренко on 22.08.2022.
//

import UIKit

final class MainCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var asigneeImage: UIImageView!
    @IBOutlet private weak var stateView: UIView!
    
    // MARK: - View
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    // MARK: - Private
    private func configure() {
        self.backgroundColor = .clear
        self.contentView.layer.cornerRadius = Styles.shared.view.cornerDf
        self.contentView.backgroundColor = .white
        self.selectedBackgroundView?.layer.masksToBounds = true
        self.selectedBackgroundView?.layer.cornerRadius = Styles.shared.view.cornerDf
        self.selectedBackgroundView?.backgroundColor = .gray
        bgView.backgroundColor = .gray
        
        titleLabel.style = Styles.shared.label.r18main
        descLabel.style = Styles.shared.label.r16mainA05
        dateLabel.style = Styles.shared.label.r16mainA05
    }
    
    // MARK: - Data
    func updateData(_ data: MainCellModel) {
        titleLabel.text = data.title
        descLabel.text = data.text
        dateLabel.text = data.date
        stateView.backgroundColor = data.stateColor
        self.contentView.backgroundColor = data.bgColor
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.bgView.alpha = highlighted ? 0.3 : 0
        }
    }
}
