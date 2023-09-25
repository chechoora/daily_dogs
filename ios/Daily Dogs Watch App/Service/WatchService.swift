//
//  WatchService.swift
//  daily_watch_dogs Watch App
//
//  Created by Kyrylo Kharchenko on 17.09.2023.
//

import Foundation
import Alamofire

class WatchService {
    
    internal var apiKey: String? = nil
    
    func fetchFavoriteImages() async throws -> [String] {
        if let key = apiKey {
            return try await withUnsafeThrowingContinuation { continuation in
                AF.request("https://api.thedogapi.com/v1/favourites", method: .get, headers: HTTPHeaders(["Content-Type": "application/json", "x-api-key": key])).responseDecodable(of:[FavoriteDisplayModel].self) { response in
                    let result = response.result
                    switch result {
                    case .success(let favoriteList):
                        let images = self.mapResponseToImageList(favoriteList: favoriteList)
                        continuation.resume(returning: images)
                        return
                    case .failure(let error):
                        continuation.resume(throwing: WatchServiceError(messsage: error.localizedDescription))
                        return
                    }
                }
            }
        } else {
            throw WatchServiceError(messsage: "ApiKey is not initilised")
        }
    }
    
    func mapResponseToImageList(favoriteList: [FavoriteDisplayModel]) -> [String] {
        let images = favoriteList.map { favoriteModel in
            return favoriteModel.image?.url
        }
        return images.compactMap{ $0 } as [String]
    }
}

struct WatchServiceError: Error {
    let messsage: String
}
