//
//  ProfilePresenter.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import Foundation
import UIKit

protocol ProfilePresenter: AnyObject {

    // MARK: - Coordinator
    var onEditImage: VoidClosure? { get set }
    var onEditProfile: VoidClosure? { get set }
    
    func onTapEditImage(image: String?)
    func onTapEditProfile(name: String)
    func updateData()
}

final class ProfilePresenterImpl: ProfilePresenter {
    
    // MARK: - Coordinator
    var onEditImage: VoidClosure?
    var onEditProfile: VoidClosure?
    private var interactor: ProfileInteractor
    weak var view: (UIViewController & ProfileView)?
    
    init(interactor: ProfileInteractor) {
        self.interactor = interactor
    }
    
    func onTapEditImage(image: String?) {
        interactor.onTapEditImage(image: image)
    }
    func onTapEditProfile(name: String) {
        interactor.onTapEditProfile(name: name)
    }
    func updateData() {
    }
}

