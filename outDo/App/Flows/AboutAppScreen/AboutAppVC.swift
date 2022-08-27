//
//  AboutAppVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

final class AboutAppVC: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Locales.value("vc_about_title")
        textLabel.text = Locales.value("vc_about_text")
    }
}
