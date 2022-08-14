//
//  NavigationDrawerPopup.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

protocol NavigationDrawerView: AnyObject {
    
}

class NavigationDrawerPopup: UIViewController, NavigationDrawerView {

    var presenter: NavigationDrawerPresenter
    
    init(presenter: NavigationDrawerPresenter) {
        self.presenter = presenter
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
