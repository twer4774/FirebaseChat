//
//  ChatDetailInteractor.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/12.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit

class ChatDetailInteractor: ChatDetailRequestInteractorProtocol {
    var presenter: ChatDetailResponseInteractorProtocol?
    var remoteDataManager: ChatDetailDataManagerInputProtocol?
    
    func getMessageList(channel: Channels) {
        remoteDataManager?.getMessageList(channel: channel)
    }
    
    func addMessage(message: Message, chat: Channels) {
        remoteDataManager?.addMessageToFirestore(message: message, chat: chat)
    }
}

extension ChatDetailInteractor: ChatDetailDataManagerOutputProtocol {
    func excuteFetchedMessageList(with messageList: [Message]) {
        presenter?.fetchedMessageList(messages: messageList)
    }
}
