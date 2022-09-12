//
//  PostsRepository.swift
//  Rocial
//
//  Created by Roshan Mykoo on 9/12/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol PostsRepositoryProtocol {
    func fetchPosts() async throws -> [Post]
    func create(_ post: Post) async throws
    func delete(_ post: Post) async throws
    func favorite(_ post: Post) async throws
    func unfavorite(_ post: Post) async throws
}

#if DEBUG
struct PostsRepositoryStub: PostsRepositoryProtocol {
    func favorite(_ post: Post) async throws {}
    
    func unfavorite(_ post: Post) async throws {}
    
    func delete(_ post: Post) async throws {}
    
    let state: Loadable<[Post]>
    
    func fetchPosts() async throws -> [Post] {
        return try await state.simulate()
    }
    
    func create(_ post: Post) async throws {}
    
}
#endif

struct PostsRepository: PostsRepositoryProtocol {
    //let postsReference = Firestore.firestore().collection("posts")
    let postsReference = Firestore.firestore().collection("posts_v1")
    
    func unfavorite(_ post: Post) async throws {
        let document = postsReference.document(post.id.uuidString)
        try await document.setData(["isFavorite" : false], merge: true)
    }
    
    func favorite(_ post: Post) async throws {
        let document = postsReference.document(post.id.uuidString)
        try await document.setData(["isFavorite" : true], merge: true)
    }
    
    func delete(_ post: Post) async throws {
        let document = postsReference.document(post.id.uuidString)
        try await document.delete()
    }
    
    func fetchPosts() async throws -> [Post] {
        let snapshot = try await postsReference
            .order(by: "timestamp", descending: true)
            .getDocuments()
        return snapshot.documents.compactMap { document in
            try! document.data(as: Post.self)
        }
    }
    
    func create(_ post: Post) async throws {
        let document = postsReference.document(post.id.uuidString)
        try await document.setData(from: post)
    }
}

private extension DocumentReference {
    func setData<T: Encodable>(from value: T) async throws {
        return try await withCheckedThrowingContinuation( { continuation in
            try! setData(from: value) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume()
            }
        })
    }
}
