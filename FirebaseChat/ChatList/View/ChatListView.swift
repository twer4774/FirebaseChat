//
//  ChatListView.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/10.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore

class ChatListView: UIViewController {
    
    @IBOutlet weak var btnLogOut: UIButton!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance().signOut()
            //dismiss가 더 안정적이지 않을까???
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError{
            print("로그아웃 에러", signOutError)
        }
    }
}
