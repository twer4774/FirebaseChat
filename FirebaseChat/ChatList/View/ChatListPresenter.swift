//
//  ChatListPresenter.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/10.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit

class ChatListPresenter: ChatListPresenterProtocol {
    var view: ChatListViewProtocol?
    var interactor: ChatListRequestInteractorProtocol?
    var router: ChatListRouterProtocol?
    
    func viewDidLoad() {
        interactor?.getChatList()
        print("presenter viewDidLoad")
    }
    
    func createChannel(){
        view?.alertCreateChannel()
    }
    
    func createChannelAction(channelName: String){
        interactor?.addChannel(channelName: channelName)
    }
    
    func selectItem(with chat: Channels, from view: UIViewController) {
        router?.gotoChat(chat: chat, from: view)
    }

}

extension ChatListPresenter: ChatListResponseInteractorProtocol {
    func fetchedChatList(chatList: [Channels]) {
        print("presenter chatList : \(chatList)")
        self.view?.showChatList(with: chatList)
    }
}
