//
//  ChatDetailPresenter.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/12.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit

class ChatDetailPresenter: ChatDetailPresenterProtocol {
    
    var view: ChatDetailViewProtocol?
    var interactor: ChatDetailRequestInteractorProtocol?
    var router: ChatDetailRouterProtocol?
    var chat: Channels?
    
    func viewDidLoad() {
        
        view?.showTitle(with: chat!)
    }
    
    func showChatMessage(with chatMessage: [Message], from view: UIViewController) {
        
    }
    
    func gotoChatList(from view: UIViewController) {
        
    }
    
    func sendMessage(message: Message) {
        interactor?.addMessage(message: message, chat: chat!)
    }
}

extension ChatDetailPresenter: ChatDetailResponseInteractorProtocol {
    func fetchedMessageList(messages: [Message]) {
        
    }
    
}
