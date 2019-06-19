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
        
        let chatListVC = view.storyboard?.instantiateViewController(withIdentifier: "ChatListView") as! ChatListView
        //화면을 전환하기 전에, 다음 화면에 대한 모듈을 만들어준다.
//        ChatListRouter.createChatListModule(chatListView: chatListVC)
        view.present(chatListVC, animated: true)
        
    }
    
    
    
    
}
