//
//  ChatListProtocols.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/10.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit

protocol ChatListViewProtocol: class {
    func showChatList(with chatList: [Chat])
}

protocol ChatListRequestInteractorProtocol: class {
    var presenter: ChatListResponseInteractorProtocol? { get set }
    var remoteDataManager: ChatListDataManagerInputProtocol? { get set }
    
    func getChatList()
}

protocol ChatListResponseInteractorProtocol: class {
    func fetchedChatList(chatList: [Chat])
}

protocol ChatListPresenterProtocol: class {
    var view: ChatListViewProtocol? { get set }
    var interactor: ChatListRequestInteractorProtocol? { get set }
    var router: ChatListRouterProtocol? { get set }
    
    func viewDidLoad()
    func selectItem(with chat: Chat, from view: UIViewController)
    
}

protocol ChatListRouterProtocol: class {
    static func createChatListModule(chatListView: ChatListView)
    func gotoChat(chat: Chat, from view: UIViewController)
}

protocol ChatListDataManagerInputProtocol: class {
    //interactor -> datamanager
    var remoteRequestHandler: ChatListDataManagerOutputProtocol? { get set }
    
    func getChatList()
    func getData() -> [Chat]
}

protocol ChatListDataManagerOutputProtocol: class {
    //datamanager -> interactor

//    func showError(error:String)
//    func getAllDetail(data: [String:Any]?)

    func excuteFetchedCatList(with chatList: [Chat])
    
}
