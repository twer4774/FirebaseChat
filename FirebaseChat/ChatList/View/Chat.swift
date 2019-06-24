//
//  Chat.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/10.
//  Copyright © 2019 Wonik. All rights reserved.
//

struct Chat {
    var chatName: String!
//    var chatUsers: [String: String]!
    
    init(chatName: String){
        self.chatName = chatName
    }
    
}

struct Channels{
    var roomId: String    
    var dictionary: [String: Any]{
        return [
            "roomId": roomId
        ]
    }
    
    init(roomId: String){
        self.roomId = roomId
    }
    init?(dictionary: [String: Any]){
        guard let roomId = dictionary["roomId"] as? String else { return nil }
        
        self.init(roomId: roomId)
    }
}
