//
//  This file is for educational purposes only. It may contain code snippets, examples, images, and explanations
//  intended to help understand concepts and improve programming skills.
//

import UIKit

class PhotosModel {
    var photos: [Photo]?
    
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
}
