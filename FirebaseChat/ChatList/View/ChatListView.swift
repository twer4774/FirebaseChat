//
//  ChatListView.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/10.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit

class ChatListView: UIViewController {

    @IBOutlet weak var tbChatList: UITableView!

    var presenter: ChatListPresenterProtocol?
    var chatList: [Chat]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChatListRouter.createChatListModule(chatListView: self)
//        chatList?.removeAll()
        presenter?.viewDidLoad()
    }
}

extension ChatListView: ChatListViewProtocol {
    func showChatList(with chatList: [Chat]) {
        self.chatList = chatList
        tbChatList.reloadData()
        print("view chatList: \(chatList)")
    }
}

extension ChatListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let list = chatList else {
            return 2
        }
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tbChatList.dequeueReusableCell(withIdentifier: "chatListCell", for: indexPath) as? ChatListCell else {
            return UITableViewCell()
        }
        
        if let chatList = self.chatList {
            cell.chatName.text = chatList[indexPath.row].chatName
        } else {
            cell.chatName.text = "ChatName"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectItem(with: chatList![indexPath.row], from: self)
    }
}
