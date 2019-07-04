//
//  LoginRouter.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/10.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit

class LoginRouter: LoginRouterProtocol {
    static func createLoginModule(view: LoginView) {
        let view = view
        let presenter = LoginPresenter()
        let router = LoginRouter()
        
        view.presenter = presenter
        view.presenter?.view = view
        view.presenter?.router = router
    }
    
    func gotoChatList(from view: UIViewController) {

        let mainNV = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNV")
        
        view.present(mainNV, animated: true)
        
    }
    
    
    
    
}
