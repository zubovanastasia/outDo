//
//  DialogRootVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

final class DialogRootVC: UIViewController {

    weak var delegate: UIWindow?
    var transition = PanelTransition()
    var needDarkness = true {
        didSet {
            transition.needDarkness = needDarkness
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
}
