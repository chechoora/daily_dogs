//
//  WatchViewModel.swift
//  daily_watch_dogs Watch App
//
//  Created by Kyrylo Kharchenko on 17.09.2023.
//

import Foundation

class WatchViewModel: ObservableObject {
    
    @Published private(set) var state = State.idle
    private var watchService = WatchService()
    private var apiKeyReciver = ApiKeyReciver()

    private var images: [String] = []
    
    init() {
        apiKeyReciver.fetchApiKey(onApiKeyObtained: { apiKey in
            self.watchService.apiKey = apiKey
            self.reloadImages()
        })
    }

    private func fetchRandomFavoriteImages() async {
        state = .loading
        do {
            let imagesResult = try await watchService.fetchFavoriteImages()
            if (imagesResult.isEmpty) {
                state = .failed(error: DisplayError(messsage: "No image to display"))
            } else {
                self.images = imagesResult
                state = .loaded(images: images)
            }
        } catch let serviceError as WatchServiceError {
            state = .failed(error: DisplayError(messsage: serviceError.messsage))
        } catch {
            state = .failed(error: DisplayError(messsage: "Classic something went wrong"))
        }
    }
    
    func reloadImages() {
        Task {
            await self.fetchRandomFavoriteImages()
        }
    }
}

enum State {
    case idle
    case loading
    case failed(error: DisplayError)
    case loaded(images: [String])
}

struct DisplayError: Error {
    let messsage: String
}
