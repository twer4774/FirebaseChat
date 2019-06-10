//
//  LoginProtocols.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/10.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit

protocol LoginViewProtocol {
    
    func showLoginView()
    
}

protocol LoginPresenterProtocol {
    var view: LoginViewProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    
    func viewDidLoad()
    func gotoChatListTransfer(from view: UIViewController)
}

protocol LoginRouterProtocol {
   
    static func createLoginModule(view: LoginView)
    
    func gotoChatList(from view: UIViewController)
}
