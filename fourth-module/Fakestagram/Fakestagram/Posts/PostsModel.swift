//
//  This file is for educational purposes only. It may contain code snippets, examples, images, and explanations
//  intended to help understand concepts and improve programming skills.
//

import Foundation

class PostsModel {
    var posts = [Post]()
    let requestHandler: RequestHandlerProtocol = RequestHandler()
    
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
    
    public func getUserPostsFromJSON(userId: Int) throws {
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
    
    public func getPostsFromUser(id userId: String, completitionHandler: @escaping (Error?) -> Void) {
        guard let request = buildRequest(byQuery: false, userId: userId) else {
            completitionHandler(UserModelHTTPError.badRequest)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error {
                completitionHandler(error)
                return
            }
        
            guard let httpResponse = (response as? HTTPURLResponse) else {
                completitionHandler(UserModelHTTPError.unexpectedResponse)
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completitionHandler(UserModelHTTPError.badResponse(httpResponse.statusCode))
                return
            }
            
            do {
                guard let data else {
                    completitionHandler(UserModelError.userNotFound)
                    return
                }
                
                let postsDTO = try [PostDTO](data: data)
                self?.posts = postsDTO.map { Post(id: $0.id, title: $0.title, body: $0.body )}
                // all ok
                completitionHandler(nil)
            } catch {
                completitionHandler(error)
            }
        }
        task.resume()
    }
    
    private func buildRequest(byQuery: Bool, userId: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        components.queryItems = [
            URLQueryItem(name: "_page", value: "1"),
            URLQueryItem(name: "_limit", value: "10"),
        ]
        if byQuery {
            components.queryItems?.append(URLQueryItem(name: "userId", value: userId))
            components.path = "posts"
        } else {
            // searching by endpoints
            components.path = "/users/\(userId)/posts"
        }
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
    
    
    // NEW VERSION
    public func getPostsFromUser2(id userId: String, completitionHandler: @escaping (Error?) -> Void) {
        let request = buildEndpoint().getRequest()
                
        requestHandler.get(buildEndpoint()) { (result: Result<[PostDTO], Error>) in
                    switch result {
                    case .success(let postsDTO):
                        self.posts = postsDTO.map { Post(id: $0.id, title: $0.title, body: $0.body )}
                        // no errors
                        completitionHandler(nil)
                    case .failure(let failure):
                        completitionHandler(failure)
                    }
                    
                }
    }
    
    func buildEndpoint() -> EndpointProtocol {
        let queries = [
            URLQueryItem(name: "_page", value: "1"),
            URLQueryItem(name: "_limit", value: "20")
        ]
        
        return UserBaseEndpoint(path: "/posts", queries: queries)
    }
    
    
}
