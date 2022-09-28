//
//  CommentsViewModel.swift
//  Rocial
//
//  Created by Roshan Mykoo on 9/27/22.
//

import Foundation


@MainActor

class CommentsViewModel: ObservableObject {
    @Published var comments: Loadable<[Comment]> = .loading
    private let commentsRepository: CommentsRepositoryProtocol
    
    init(commentsRepository: CommentsRepositoryProtocol) {
        self.commentsRepository = commentsRepository
    }
    
    func fetchComments() {
        Task {
            do {
                comments = .loaded(try await commentsRepository.fetchComments())
            } catch {
                print("[CommentsViewModel] Cannot fetch comments: \(error)")
                comments = .error(error)
            }
        }
    }
    
    func makeCommentRowViewModel(for comment: Comment) -> CommentRowViewModel {
        let deleteAction = { [weak self] in
            try await self?.commentsRepository.delete(comment)
            self?.comments.value?.removeAll { $0.id == comment.id }
        }
        return CommentRowViewModel(
            comment: comment,
            deleteAction: commentsRepository.canDelete(comment) ? deleteAction : nil
        )
    }
    
 
}
