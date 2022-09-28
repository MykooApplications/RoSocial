//
//  Post.swift
//  Rocial
//
//  Created by Roshan Mykoo on 9/12/22.
//

import Foundation

struct Post: Identifiable, Equatable {
    var title: String
    var content: String
    var author: User
    var timestamp = Date()
    var id = UUID()
    var isFavorite = false
    

    func contains(_ string: String) -> Bool {
        let properties = [title, content, author.name].map { $0.lowercased() }
        let query = string.lowercased()
        let matches = properties.filter { $0.contains(query) }
        return !matches.isEmpty
    }
}

extension Post: Codable {
    enum CodingKeys: CodingKey {
        case title, content, author, timestamp, id
    }
}

extension Post {
    static let testPost = Post(
        title: "Lorem ipsum",
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        author: User.testUser
    )
}

private extension Post {
    func setting<T>(_ property: WritableKeyPath<Post, T>, to newValue: T) -> Post
    {
        var post = self
        post[keyPath: property] = newValue
        return post
    }
}

