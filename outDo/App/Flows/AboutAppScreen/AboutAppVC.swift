//
//  AboutAppVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

final class AboutAppVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var textLabel: UILabel!
   
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    // MARK: - Data
    func updateData() {
        self.title = Locales.value("vc_about_title")
        textLabel.text = Locales.value("vc_about_text")
    }
}
