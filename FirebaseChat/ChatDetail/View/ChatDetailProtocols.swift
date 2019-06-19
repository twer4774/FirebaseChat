//
//  ChatDetailProtocols.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/12.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit

protocol ChatDetailViewProtocol {
    var presenter: ChatDetailPresenterProtocol? { get set }
    func showMessageList(messages: [Message])
}

protocol ChatDetailRequestInteractorProtocol {
    var presenter: ChatDetailResponseInteractorProtocol? { get set }
    func getMessageList()
}

protocol ChatDetailResponseInteractorProtocol {
    func fetchedMessageList(messages: [Message])
}

protocol ChatDetailPresenterProtocol {
    var view: ChatDetailViewProtocol? { get set }
    var interactor: ChatDetailRequestInteractorProtocol? { get set }
    var router: ChatDetailRouterProtocol? { get set }
    
    func viewDidLoad()
    func showChatMessage(with chatMessage: [Chat], from view: UIViewController)
    func gotoChatList(from view: UIViewController)
}

protocol ChatDetailRouterProtocol {
    static func createChatDetailModule(chatDetailView: ChatDetailView, chat: Chat)
    func rewindToChatList(from view: UIViewController)
}
