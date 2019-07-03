//
//  ChatListRouter.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/10.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit

class ChatListRouter: ChatListRouterProtocol {
    static func createChatListModule(chatListView: ChatListView) {
        let view = chatListView
        let interactor = ChatListInteractor()
        let presenter = ChatListPresenter()
        let router = ChatListRouter()
        
        /*
         주의
         Module화 시킬때 순서가 중요하다.
         chatListView.presenter?.interactor = interactor
         chatListView.presenter?.interactor?.presenter = presenter
         위의 두 함수는 다른 함수들보다 위에 있어서는 안되고 순서도 변경해서는 안된다. VIPER의 흐름 때문
         */
        chatListView.presenter = presenter
        chatListView.presenter?.view = view
        chatListView.presenter?.router = router
        chatListView.presenter?.interactor = interactor
        chatListView.presenter?.interactor?.presenter = presenter
        chatListView.presenter?.interactor?.remoteDataManager = ChatListDataManager()
        chatListView.presenter?.interactor?.remoteDataManager?.remoteRequestHandler = interactor
        
        
    }
    
    func gotoChat(chat: Channels, from view: UIViewController) {
        let chatVC = view.storyboard?.instantiateViewController(withIdentifier: "ChatDetailView") as! ChatDetailView
        
        ChatDetailRouter.createChatDetailModule(chatDetailView: chatVC, chat: chat)
        view.navigationController?.pushViewController(chatVC, animated: true)
    }

}
