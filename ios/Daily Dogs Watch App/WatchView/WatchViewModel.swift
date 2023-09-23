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
    private var images: [String] = []
    
    init() {
        watchService.onServiceReady = {
            Task {
                await self.fetchRandomFavoriteImage()
            }
        }
        watchService.startService()
    }

    
    private func fetchRandomFavoriteImage() async {
        state = .loading
        let imagesResult = await watchService.fetchFavoriteImages()
        let images = (try? imagesResult.get()) ?? []
        if (images.isEmpty) {
            state = .failed(error: DisplayError(messsage: "No image to display"))
        } else {
            self.images = images
            state = .loaded(images: images)
        }
    }
    
    func reloadImages() {
        Task {
            await self.fetchRandomFavoriteImage()
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
