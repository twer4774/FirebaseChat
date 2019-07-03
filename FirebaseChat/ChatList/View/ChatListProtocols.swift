//
//  ChatListProtocols.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/10.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit

protocol ChatListViewProtocol: class {
    func showChatList(with chatList: [Channels])
    func alertCreateChannel()
}

protocol ChatListRequestInteractorProtocol: class {
    var presenter: ChatListResponseInteractorProtocol? { get set }
    var remoteDataManager: ChatListDataManagerInputProtocol? { get set }
    
    func getChatList()
    func addChannel(channelName: String)
}

protocol ChatListResponseInteractorProtocol: class {
    func fetchedChatList(chatList: [Channels])
}

protocol ChatListPresenterProtocol: class {
    var view: ChatListViewProtocol? { get set }
    var interactor: ChatListRequestInteractorProtocol? { get set }
    var router: ChatListRouterProtocol? { get set }
    
    func viewDidLoad()
    func createChannel()
    func createChannelAction(channelName: String)
    func selectItem(with chat: Channels, from view: UIViewController)
    
}

protocol ChatListRouterProtocol: class {
    static func createChatListModule(chatListView: ChatListView)
    func gotoChat(chat: Channels, from view: UIViewController)
}

protocol ChatListDataManagerInputProtocol: class {
    //interactor -> datamanager
    var remoteRequestHandler: ChatListDataManagerOutputProtocol? { get set }
    
    func getChatList()
    func getData() -> [Channels]
    
    func addChannelToFirestore(channelName: String)
}

protocol ChatListDataManagerOutputProtocol: class {
    //datamanager -> interactor

    func excuteFetchedCatList(with chatList: [Channels])
    
}
