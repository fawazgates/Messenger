//
//  ChatViewModel.swift
//  Messenger
//
//  Created by User on 18/02/24.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messagetext = ""
    @Published var messages = [Message]()
    
    let user: User
    
    init(user: User) {
        self.user = user
        observeMessages()
    }
    
    func observeMessages() {
        MessageService.observeMessages(chatPartner: user) { messages in self.messages.append(contentsOf: messages)
        }
    }
    
    func sendMessage() {
        MessageService.sendMessage(messageText: messagetext, toUser: user)
    }
}
