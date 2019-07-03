//
//  ChatDetailDataManager.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/22.
//  Copyright © 2019 Wonik. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

class ChatDetailDataManager: ChatDetailDataManagerInputProtocol {
    
    var remoteDataManager: ChatDetailDataManagerOutputProtocol?
    var db: Firestore!
    var messageList: [Message]?
    
    func getMessageList() {
        self.messageList = getData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.remoteDataManager?.excuteFetchedMessageList(with: self.messageList!)
        }
    }
    
    func getData() -> [Message] {
        return [Message(id: "", content: "", sentDate: Date(), user: MockUser(senderId: "", displayName: ""))]
    }
    
    func addMessageToFirestore(message: Message, chat: Channels) {
        print("message: \(message), channel: \(chat)")

        let collection = Firestore.firestore().collection("chat2").document("\(chat.channelId!)").collection("thread")
        print("collection: \(collection) - data: \(message.representation)")
        collection.addDocument(data: message.representation){
            error in
            if let err = error {
                print("error: \(err.localizedDescription)")
                return
            }

        }
        
    }
    
    
}
