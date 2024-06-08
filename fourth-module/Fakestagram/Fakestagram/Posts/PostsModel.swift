//
//  This file is for educational purposes only. It may contain code snippets, examples, images, and explanations
//  intended to help understand concepts and improve programming skills.
//

import Foundation

class PostsModel {
    var posts = [Post]()
    
    public func post(for id: Int) -> Post {
        return posts[id]
    }
    
    public func getNumberOfPosts() -> Int {
        return posts.count
    }
}

enum PostsModelError: Error, LocalizedError {
    case fileError
    
    var errorDescription: String? {
        switch self {
        case .fileError: "File error"
        }
    }
}

extension PostsModel {
    private func getPostFrom(dto: PostDTO) -> Post {
        return Post(id: dto.id, title: dto.title, body: dto.body)
    }
    
    public func getUserPosts(userId: Int) throws {
        guard let url = Bundle.main.url(forResource: "Posts", withExtension: "json") else {
            throw PostsModelError.fileError
        }
        guard let data = try? Data(contentsOf: url) else { throw PostsModelError.fileError }
        let postDTOs = try [PostDTO](data: data)
        self.posts = postDTOs
            .filter { $0.userId == userId }
            .map {
            postDTO in getPostFrom(dto: postDTO)
        }
    }
}
