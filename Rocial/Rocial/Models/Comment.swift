//
//  Comment.swift
//  Rocial
//
//  Created by Roshan Mykoo on 9/27/22.
//

import Foundation

struct Comment: Identifiable, Equatable, Codable {
    var content: String
    var author: User
    var timestamp = Date()
    var id = UUID()
    
    
    
}

extension Comment {
    static let testComment = Comment(content: "asdf l;kj qw oiu zxvc,mn asdf oij", author: User.testUser)
    
    
}
