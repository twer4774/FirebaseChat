//
//  ChatListView.swift
//  FirebaseChat
//
//  Created by Wonik on 2019/06/10.
//  Copyright © 2019 Wonik. All rights reserved.
//

import UIKit
import FirebaseUI
import FirebaseFirestore
import GoogleSignIn

class ChatListView: UIViewController {

    @IBOutlet weak var tbChatList: UITableView!
    @IBOutlet weak var btnCreateChannel: UIBarButtonItem!
    
    var presenter: ChatListPresenterProtocol?
    var chatList: [Channels]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChatListRouter.createChatListModule(chatListView: self)
        chatList?.removeAll()
        presenter?.viewDidLoad()
    }
    
   
}

extension ChatListView: ChatListViewProtocol {
    func showChatList(with chatList: [Channels]) {
        self.chatList = chatList
        tbChatList.reloadData()
        print("view chatList: \(chatList)")
    }
    
    func alertCreateChannel() {
        let alert = UIAlertController(title: "Create Channel", message: "Enter Channel Name", preferredStyle: .alert)
        
        alert.addTextField { (tf) in
            tf.placeholder = "Please enter a channel name to add"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (result) in
            self.presenter?.createChannelAction(channelName: alert.textFields![0].text!)
        }))
        
        self.present(alert, animated: true)
    }
}

extension ChatListView {
    @IBAction func btnCreateChannel(_ sender: Any) {
        presenter?.createChannel()
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
        } catch {
            
        }
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
            cell.chatName.text = chatList[indexPath.row].dictionary["roomId"] as! String
        } else {
            cell.chatName.text = "ChatName"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectItem(with: chatList![indexPath.row], from: self)
    }
}
