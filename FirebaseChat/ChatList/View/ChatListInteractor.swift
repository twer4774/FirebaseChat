//
//  ChatListInteractor.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/10.
//  Copyright © 2019 Wonik. All rights reserved.
//


import UIKit
import FirebaseFirestore

class ChatListInteractor: ChatListRequestInteractorProtocol {
    weak var presenter: ChatListResponseInteractorProtocol?
    var remoteDataManager: ChatListDataManagerInputProtocol?
    var chatList = [Channels]()
    var db: Firestore!
    
    func getChatList() {
        print("getChatList")
        remoteDataManager?.getChatList()
    }
    
    func addChannel(channelName: String){
        remoteDataManager?.addChannelToFirestore(channelName: channelName)
    }
    
}
extension ChatListInteractor: ChatListDataManagerOutputProtocol {
    func excuteFetchedCatList(with chatList: [Channels]){
        print("ChatListDataManagerOutputProtocol \(chatList)")
        presenter?.fetchedChatList(chatList: chatList)
        
    }
}
