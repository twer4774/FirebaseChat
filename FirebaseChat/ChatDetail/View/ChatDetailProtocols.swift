//
//  ChatDetailProtocols.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/12.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit

protocol ChatDetailViewProtocol: class {
    var presenter: ChatDetailPresenterProtocol? { get set }
    func showMessageList(messages: [Message])
    func showTitle(with chat: Channels)
}

protocol ChatDetailRequestInteractorProtocol: class {
    var presenter: ChatDetailResponseInteractorProtocol? { get set }
    var remoteDataManager: ChatDetailDataManagerInputProtocol? { get set }
    
    func getMessageList()
    func addMessage(message: Message, chat: Channels)
}

protocol ChatDetailResponseInteractorProtocol: class {
    func fetchedMessageList(messages: [Message])
}

protocol ChatDetailPresenterProtocol: class {
    var view: ChatDetailViewProtocol? { get set }
    var interactor: ChatDetailRequestInteractorProtocol? { get set }
    var router: ChatDetailRouterProtocol? { get set }
    
    func viewDidLoad()
    func showChatMessage(with chatMessage: [Message], from view: UIViewController)
    func sendMessage(message: Message)
    func gotoChatList(from view: UIViewController)
}

protocol ChatDetailRouterProtocol: class {
    static func createChatDetailModule(chatDetailView: ChatDetailView, chat: Channels)
    func rewindToChatList(from view: UIViewController)
}

protocol ChatDetailDataManagerInputProtocol: class {
    //interactor -> datamanager
    var remoteDataManager: ChatDetailDataManagerOutputProtocol? { get set }
    
    func getMessageList()
    func getData() -> [Message]
    func addMessageToFirestore(message: Message, chat: Channels)
}

protocol ChatDetailDataManagerOutputProtocol: class {
     func excuteFetchedMessageList(with messageList: [Message])
}
