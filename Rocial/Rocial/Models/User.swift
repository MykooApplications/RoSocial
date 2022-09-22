//
//  User.swift
//  Rocial
//
//  Created by Roshan Mykoo on 9/20/22.
//

import Foundation

struct User: Identifiable, Equatable, Codable {
    var id: String
    var name: String
    
    
    
}

extension User {
    static let testUser = User(id: "", name: "John Ro")
}
