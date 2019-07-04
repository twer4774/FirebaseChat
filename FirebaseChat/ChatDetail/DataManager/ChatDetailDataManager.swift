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
    var channel: Channels?
    
    func getMessageList(channel: Channels) {
        self.messageList = getData(channel: channel)
        self.channel = channel
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.remoteDataManager?.excuteFetchedMessageList(with: self.messageList!)
        }
    }
    
    func getData(channel: Channels) -> [Message] {

        db = Firestore.firestore()
        db.collection("chat2/\(channel.channelId!)/thread").order(by: "created").getDocuments { (document, error) in
            
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else {
                for document in document!.documents{
                    print("doucuments: \(document.documentID) -> \(document.data())")
    
                    let data = document.data()
                    let id = data["senderID"] as! String
                    let content = data["content"] as! String
                    let created = data["created"] as! Timestamp
                    let date = created.dateValue()
                    let sentDate = self.timeStampToString(time: date)

                    self.messageList!.append(Message(id: id, content: content, sentDate: sentDate, user: MockUser(senderId: id, displayName: id)))
                }
            }
        }
        
        return [Message(id: "", content: "", sentDate: Date(), user: MockUser(senderId: "", displayName: ""))]

    }
    
    func timeStampToString(time: Date) -> Date{
        
        let formatter = DateFormatter()
        //타임스탬프 형식 받아오기
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        formatter.locale = Locale(identifier: "ko_KR")
        
        let result = formatter.string(from: time)
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter2.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        formatter2.locale = Locale(identifier: "ko_KR")
        
        let resultDate = formatter.date(from: result)!
        
        return resultDate
        
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
        
        self.getMessageList(channel: self.channel!)
    }
    
    
}
