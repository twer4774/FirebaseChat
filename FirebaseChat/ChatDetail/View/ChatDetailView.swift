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
        messageList = messages
        messageList.removeFirst()
        print("view: \(messages)")
        messagesCollectionView.reloadData()
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
        return messageList[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    //사용자이름 표시
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if !isPreviousMessageSameSender(at: indexPath) {
            let name = message.sender.displayName
            return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
        }
        return nil
    }
    
    //메시지 시간 표시-------------------------------------------
    func isTimeLabelVisible(at indexPath: IndexPath) -> Bool{
        return indexPath.section % 1 == 0 && !isPreviousMessageSameSender(at: indexPath)
    }
    
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
        if self.messageList.count > 0{
            guard indexPath.section - 1 >= 0 else { return false }
            return messageList[indexPath.section].sender.senderId == messageList[indexPath.section - 1].sender.senderId
        } else {
            return false
        }
    }
}

extension ChatDetailView: MessagesDisplayDelegate {
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath,
                             in messagesCollectionView: MessagesCollectionView) -> Bool {
        return false
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath,
                      in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        
        return .bubbleTail(corner, .curved)
    }
}

extension ChatDetailView: MessagesLayoutDelegate {
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath,
                        in messagesCollectionView: MessagesCollectionView) -> CGSize {
        
        return CGSize(width: 0, height: 8)
    }
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath,
                           with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 0
    }
}

extension ChatDetailView: MessageCellDelegate {
    func didTapMessage(in cell: MessageCollectionViewCell) {
        print("meessage")
    }
}

extension ChatDetailView: MessageInputBarDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        
        let ud = UserDefaults.standard
        let id = ud.string(forKey: "sender")!
        let sender = Sender(senderId: id, displayName: id)
        
        //1. Date(현재 날짜)를 formatter에 맞춰 변경한다.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        let currentTime = dateFormatter.string(from: Date())
        
        //2. formatter를 Date를 포맷으로 변경한다.
        let sentDate = dateFormatter.date(from: currentTime)
        
        let message = Message(id: sender.id, content: text, sentDate: sentDate!, user: MockUser(senderId: sender.id, displayName: sender.displayName))
        
        presenter?.sendMessage(message: message)
        
        inputBar.inputTextView.text = ""
    }
}
