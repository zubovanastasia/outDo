//
//  MainPresenter.swift
//  outDo
//
//  Created by Антон Бондаренко on 05.08.2022.
//

import UIKit

protocol MainPresenter: AnyObject {
    
    // MARK: - Coordinator
    var onHandleAction: ((TAction, Any?) -> Void)? { get set }
    
    func onTapNavbarMenu()
}

final class MainPresenterImpl: MainPresenter {
    
    // MARK: - Coordinator
    var onHandleAction: ((TAction, Any?) -> Void)?
    
    private var interactor: MainInteractor
    weak var view: (UIViewController & MainView)?
    
    init(interactor: MainInteractor) {
        self.interactor = interactor
    }
    
    func onTapNavbarMenu() {
        interactor.onTapNavbarMenu()
    }
    var categoryId : Int
    var router : Router
    var useCase: UseCase
    weak var view: MainView?
    
    typealias UseCase = (
        fetchTasks : (_ categoryId : Int, _ completion : @escaping ) -> Void
         
   )
   
   init(categoryId : Int, router : Router, useCase : UseCase) {
       self.categoryId = categoryId
       self.router = router
       self.useCase = useCase
   }
    
    
    extension MainPresenterImpl : MainPresenter {
        
        
        func viewDidLoad() {
            
            DispatchQueue.global(qos: .background).async {
                        
                    }
                    
                    DispatchQueue.main.async {

                        
                    }
            
        }
        
    }
    
}
