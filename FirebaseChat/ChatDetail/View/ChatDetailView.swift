//
//  ChatDetailView.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/12.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import FirebaseFirestore

class ChatDetailView: MessagesViewController {

    var presenter: ChatDetailPresenterProtocol?
    var messageList: [Message] = []
    var messageListener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageList.removeAll()
        presenter?.viewDidLoad()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
    }

}

extension ChatDetailView: ChatDetailViewProtocol {
    
    func showMessageList(messages: [Message]) {
        
    }
    
    func showTitle(with chat: Channels){
        guard let roomId = chat.dictionary["roomId"] else {
            return
        }
        
        title = roomId as? String
        
    }
}

//MARK: - MessagesDataSource
extension ChatDetailView: MessagesDataSource {
    func currentSender() -> SenderType {
        return ChatUser(senderId: "chatuser", displayName: "chatUser")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
//        return messageList[indexPath.row]
        let message = Message(id: "", content: "hell", sentDate: Date(), user: MockUser(senderId: "", displayName: ""))
        return message
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
//        return messageList.count
        return 3
    }
}

extension ChatDetailView: MessagesDisplayDelegate {
    
}

extension ChatDetailView: MessagesLayoutDelegate {
    
}

extension ChatDetailView: MessageCellDelegate {
    func didTapMessage(in cell: MessageCollectionViewCell) {
        print("meessage")
    }
}

extension ChatDetailView: MessageInputBarDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let sender = Sender(senderId: String(describing: appDelegate.userId), displayName: String(describing: appDelegate.userId))
        let message = Message(id: sender.id, content: text, sentDate: Date(), user: MockUser(senderId: sender.id, displayName: sender.displayName))
        
        presenter?.sendMessage(message: message)
    }
}
