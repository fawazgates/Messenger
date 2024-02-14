//
//  User.swift
//  Messenger
//
//  Created by User on 15/02/24.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    @DocumentID var uid: String?
    let fullname: String
    let email: String
    var profilImageURL: String
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
}

extension User {
    static let MOCK_USER = User(fullname: "fawaz gates", email: "fawaz@upi.edu", profilImageURL: "fawaz")
}
