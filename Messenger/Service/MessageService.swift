import Foundation
import Firebase

struct MessageService {
    static let messagesCollection = Firestore.firestore().collection("messages")
    
    static func sendMessage(messageText: String, toUser user: User) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = user.id
        
        let currentUserRef = messagesCollection.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = messagesCollection.document(chatPartnerId).collection(currentUid)
        
        let messageId = currentUserRef.documentID
        let message = Message(messageId: messageId, fromId: currentUid, toId: chatPartnerId, messageText: messageText, timestamp: Timestamp())
        
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
    }
    
    static func observeMessages(chatPartner: User, completion: @escaping ([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        let query = Firestore.firestore().collection("messages")
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)

        query.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot, error == nil else { return }

            let changes = snapshot.documentChanges.filter { $0.type == .added }
            var messages = [Message]()

            for change in changes {
                if let message = try? change.document.data(as: Message.self), message.fromId != currentUid {
                    messages.append(message)
                }
            }

            for (index, message) in messages.enumerated() where !message.isFromCurrentUser{
                messages[index].user = chatPartner
            }

            completion(messages)
        }
    }
}
