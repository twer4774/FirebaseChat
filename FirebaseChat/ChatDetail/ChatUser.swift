//
//  ChatUser.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/22.
//  Copyright © 2019 Wonik. All rights reserved.
//

import Foundation
import MessageKit

struct ChatUser: SenderType, Equatable {
    var senderId : String
    var displayName: String
}
