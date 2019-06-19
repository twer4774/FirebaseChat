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
    var chatList = [Chat]()
    
    func getChatList(){
        
        self.chatList = getData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.remoteRequestHandler?.excuteFetchedCatList(with: self.chatList)
        }
 
    }
    func getData() -> [Chat]{
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
        
        db.collection("chat2").order(by: "roomId").getDocuments
            { (document, error) in
                
                if let error = error
                {
                    print("error: \(error.localizedDescription)")
                } else {
                    
                    for document in document!.documents{
                        print("doucuments: \(document.documentID) -> \(document.data())")
                        self.chatList.append(Chat(chatName: document.documentID))
                    }
                    
                }
        }
        
        return self.chatList
    }
    
    
    
}
