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
    var profileImageURL: URL?
    
    
    
}

extension User {
    static let testUser = User(id: "", name: "John Ro", profileImageURL: URL(string: "https://images.generated.photos/33a7jX-qCNoWZkSbsvDxuJfl-Ou_poHCWEjHiCFqQ3s/rs:fit:512:512/wm:0.95:sowe:18:18:0.33/czM6Ly9pY29uczgu/Z3Bob3Rvcy1wcm9k/LmNvbmQvMjBhMjAz/NTYtOWJiNy00MGU5/LTk2OGEtMmE2MGI4/OTliM2UyLmpwZw.jpg"))
}
