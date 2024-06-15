//
//  This file is for educational purposes only. It may contain code snippets, examples, images, and explanations
//  intended to help understand concepts and improve programming skills.
//

import UIKit

class PhotosModel {
    var photos: [Photo]?
    let requestHandler: RequestHandlerProtocol = RequestHandler()
    
    func photo(for index: Int) -> Photo? {
        photos?[index]
    }
    
    func getNumberOfPhotos() -> Int {
        photos?.count ?? 0
    }
    
}

enum PhotosModelError: Error, LocalizedError {
    case fileError
    
    var errorDescription: String? {
        switch self {
        case .fileError: "File error"
        }
    }
}

extension PhotosModel {
    func getPhotoFrom(dto: PhotoDTO, imageNumber: Int) -> Photo {
        return Photo(image: UIImage(named: "images-\(imageNumber + 2)")!, caption: dto.title)
    }
    
    func getAllPhotos() throws {
        guard let url = Bundle.main.url(forResource: "Photos", withExtension: "json") else {
            throw PhotosModelError.fileError
        }
        guard let data = try? Data(contentsOf: url) else { throw PhotosModelError.fileError }
        let photoDTOs = try [PhotoDTO](data: data)
        photos = photoDTOs.enumerated().map {
            (index, photoDto) in return getPhotoFrom(dto: photoDto, imageNumber: index)
        }
    }
    
    public func getAllPhotosFromExternal(userId: String, completitionHandler: @escaping (Error?) -> Void) {
        let request = buildEndpoint().getRequest()
                
                requestHandler.get(buildEndpoint()) { (result: Result<[PhotoDTO], Error>) in
                    switch result {
                    case .success(let photosDTO):
                        self.downloadPhotos(from: photosDTO, completition: { photos in
                            self.photos = photos
                            // successfully downloaded, no errors
                            completitionHandler(nil)
                        })
                    case .failure(let failure):
                        completitionHandler(failure)
                    }
                    
                }
    }
    
    // Downloading resources in batches
    func downloadPhotos(from dtos: [PhotoDTO], completition: @escaping ([Photo]) -> Void) {
        // using URLSession instead of queue
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 3)
        
        // Global queues are always concurrent. Wrapping all code into this que
        
        DispatchQueue.global().async {
            
            var photos = [Photo]()
            print(dtos)
            for dto in dtos {
                guard let url = URL(string: dto.url) else { continue }
                let request = URLRequest(url: url)
                semaphore.wait()
                group.enter()
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data, let image = UIImage(data: data, scale: 2) {
                        photos.append(Photo(image: image, caption: dto.title))
                    }
                    group.leave()
                    semaphore.signal()
                }
                task.resume()
            }

            group.wait()
            completition(photos)
            // end of DispatchQueue
        }
    }
    
    func buildEndpoint() -> EndpointProtocol {
        let queries = [
            URLQueryItem(name: "_page", value: "1"),
            URLQueryItem(name: "_limit", value: "20")
        ]
        
        return UserBaseEndpoint(path: "/photos", queries: queries)
    }
}
