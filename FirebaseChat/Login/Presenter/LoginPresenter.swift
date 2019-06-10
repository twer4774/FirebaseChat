//
//  LoginPresenter.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/10.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginPresenter: LoginPresenterProtocol {
    
    var view: LoginViewProtocol?
    var router: LoginRouterProtocol?
    var loginView = LoginView()
    
    
    
    func viewDidLoad() {
        view?.showLoginView()
    }
    
    
    func gotoChatListTransfer(from view: UIViewController){
        router?.gotoChatList(from: view)
    }
}

