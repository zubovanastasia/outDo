//
//  MainCell.swift
//  outDo
//
//  Created by Антон Бондаренко on 15.08.2022.
//

import UIKit

class MainCell: UITableViewCell, MainCellUpdate {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateData(_ data: MainCellModel) {
        //idLabel.text = data.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
