//
//  TaskVC.swift
//  outDo
//
//  Created by Ruslan Magomedov on 11.08.2022.
//

import UIKit


class TaskVC: UITableViewCell {
    

    @IBOutlet weak var numbTask: UILabel!
    @IBOutlet weak var nameTask: UILabel!
    @IBOutlet weak var minTask: UITextView!
    @IBOutlet weak var dateTask: UILabel!
    @IBOutlet weak var pers1: UIImageView!
    @IBOutlet weak var pers2: UIImageView!
    @IBOutlet weak var pers3: UIImageView!
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(using viewModel : TaskVC ) ->  Void {
        self.dateTask.text = viewModel.dateTime
        self.nameTask.text = viewModel.title
        self.minTask.text = viewModel.details
        self.dateTask.text = viewModel.String?
        self.pers1.image = UIImage(named: "")
        self.pers2.image = UIImage(named: "")
        self.pers3.image = UIImage(named: "")

        self.selectionStyle = .none
    }


}
