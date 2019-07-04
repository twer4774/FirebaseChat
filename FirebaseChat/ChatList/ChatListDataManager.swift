//
//  ChatListDataManager.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/13.
//  Copyright © 2019 Wonik. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

class ChatListDataManager: ChatListDataManagerInputProtocol {
    var remoteRequestHandler: ChatListDataManagerOutputProtocol?
    var db: Firestore!
    var chatList = [Channels]()
    
    func getChatList(){
        
        self.chatList.removeAll()
        self.chatList = getData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.remoteRequestHandler?.excuteFetchedCatList(with: self.chatList)
        }
 
    }
    func getData() -> [Channels]{
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
        
        db.collection("chat2").limit(to: 50).order(by: "roomId").getDocuments
            { (document, error) in

                if let error = error
                {
                    print("error: \(error.localizedDescription)")
                } else {

                    for document in document!.documents{
                        print("doucuments: \(document.documentID) -> \(document.data())")
                        
                        let roomid = Channels(dictionary: document.data())
                        let channel = Channels(roomId: roomid!.roomId, channelId: document.documentID)
                        self.chatList.append(channel)

                    }

                }
        }
        
        return self.chatList
    }
    
    
    func addChannelToFirestore(channelName: String){
        let collection = Firestore.firestore().collection("chat2")
        
        let channel = Channels(roomId: channelName)
        
        collection.addDocument(data: channel.dictionary)
        
        DispatchQueue.main.async {
            self.getChatList()
        }
    }
    
    
}
