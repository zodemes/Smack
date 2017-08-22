//
//  ChatVC.swift
//  Smack
//
//  Created by Tushar Katyal on 19/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    
    //outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var messageField: UITextField!
    
    @IBOutlet weak var channelName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
    
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        view.bindToKeyboard()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        // notifcation observed when user selects the channel
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
               
                if success {
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
            })
        }
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    @objc func channelSelected(_ notif : Notification){
        
        updateWithChannel()
    }
    
    
    func updateWithChannel(){
        
        let channelTitle = MessageService.instance.selectedChannel?.channelName ?? ""
        channelName.text = "#\(channelTitle)"
        getMessages()
    }
    
    @objc func userDataDidChange(_ notif : Notification) {
       
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            channelName.text = "Please Log in"
        }
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannels(completion: { (success) in
            
            if success {
              if  MessageService.instance.channels.count > 0 {
                MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                self.updateWithChannel()
              } else {
                
                self.channelName.text = "No channels Yet!"
                }
            }
        })
    }

    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?.channelId else {return}
        
        MessageService.instance.findAllMessageForChannel(channelId: channelId) { (success) in
            
            
        }
        
    }
    // To send message
    @IBAction func sendMessagePressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.channelId else {return}
            guard let message = messageField.text , messageField.text != "" else {
                self.messageField.resignFirstResponder() 
                return}
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                
                if success {
                    self.messageField.text = ""
                    self.messageField.resignFirstResponder()
                }
            })
        }
    }
    
    
    
    
    
    
    
    
    
}
