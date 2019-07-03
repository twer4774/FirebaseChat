//
//  ChatDetailRouter.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/12.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit

class ChatDetailRouter: ChatDetailRouterProtocol {
    
    static func createChatDetailModule(chatDetailView: ChatDetailView, chat: Channels) {
        let view = chatDetailView
        let interactor = ChatDetailInteractor()
        let presenter = ChatDetailPresenter()
        let router = ChatDetailRouter()
        
        presenter.chat = chat
        chatDetailView.presenter = presenter
        chatDetailView.presenter?.view = view
        chatDetailView.presenter?.router = router
        chatDetailView.presenter?.interactor = interactor
        chatDetailView.presenter?.interactor?.presenter = presenter
        chatDetailView.presenter?.interactor?.remoteDataManager = ChatDetailDataManager()
        chatDetailView.presenter?.interactor?.remoteDataManager?.remoteDataManager = interactor
        
    }
    
    func rewindToChatList(from view: UIViewController) {
        
    }
    
    
    
}
