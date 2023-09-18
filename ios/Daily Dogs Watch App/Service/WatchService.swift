//
//  WatchService.swift
//  daily_watch_dogs Watch App
//
//  Created by Kyrylo Kharchenko on 17.09.2023.
//

import Foundation
import Alamofire

class WatchService {
    
    func fetchFavoriteImages() async -> Result<[String], Error> {
        do {
            return try await withUnsafeThrowingContinuation { continuation in
                AF.request("https://api.thedogapi.com/v1/favourites", method: .get, headers: HTTPHeaders(["Content-Type": "application/json", "x-api-key": "live_OWXbYSTDtAOAlvRZHydWrS0jMDCfclQrijE78Fw3w1i6gRNbY98FprMnkc7coKbV"])).responseDecodable(of:[FavoriteDisplayModel].self) { response in
                    let result = response.result
                    switch result {
                    case .success(let favoriteList):
                        let images = self.mapResponseToImageList(favoriteList: favoriteList)
                        continuation.resume(returning: Result.success(images))
                        return
                    case .failure(let error):
                        continuation.resume(throwing: error)
                        return
                    }
                }
            }
        } catch let error {
            return Result.failure(error)
        }
    }
    
    func mapResponseToImageList(favoriteList: [FavoriteDisplayModel]) -> [String] {
        let images = favoriteList.map { favoriteModel in
            return favoriteModel.image?.url
        }
        return images.compactMap{ $0 } as [String]
    }
    
}
