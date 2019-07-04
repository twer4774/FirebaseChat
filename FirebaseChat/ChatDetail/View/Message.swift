//
//  Message.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/12.
//  Copyright © 2019 Wonik. All rights reserved.
//

import Firebase
import MessageKit
import FirebaseFirestore


struct Message: MessageType {

    let id: String?
    let content: String
    let sentDate: Date
    var kind: MessageKind{
        return .text(content)
    }
    
    
    var messageId: String{
        return id ?? UUID().uuidString
    }
    
    var user: MockUser
    
    var sender: SenderType {
        return user
    }
    
    var representation: [String: Any]{
        var rep: [String : Any] = [
            "created": sentDate,
            "senderID": sender.senderId,
            "senderName": sender.displayName,
            "content": content
        ]
        
        return rep
    }
}

struct MockUser: SenderType, Equatable {
    var senderId: String
    var displayName: String
}


