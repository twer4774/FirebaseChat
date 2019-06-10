//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/10.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginView: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var btnGoogleLogin: GIDSignInButton!
    
    var presenter: LoginPresenterProtocol?
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginRouter.createLoginModule(view: self)
        presenter?.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        
        //Google Login이 된 상태
        handle = Auth.auth().addStateDidChangeListener(){ (auth, user) in
            if user != nil {
                self.presenter?.gotoChatListTransfer(from: self)
            }
        }
        
    }

}

extension LoginView: LoginViewProtocol {
    
    
    func showLoginView() {
        print("show LoginView")
    }
    
    
}

//MARK: - Actions
extension LoginView {
    @IBAction func btnGoogleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
}
