//
//  WatchViewModel.swift
//  daily_watch_dogs Watch App
//
//  Created by Kyrylo Kharchenko on 17.09.2023.
//

import Foundation

class WatchViewModel: ObservableObject {
    
    @Published private(set) var state = State.idle
    
    private let watchService = WatchService()
    private let watchSesseionManager = WatchSessionManager()
    
    private var images: [String] = []
    
    init() {
        Task {
          await fetchRandomFavoriteImage()
        }
    }

    
    func fetchRandomFavoriteImage() async {
        state = .loading
        let imagesResult = await watchService.fetchFavoriteImages()
        let images = (try? imagesResult.get()) ?? []
        if (images.isEmpty) {
            state = .failed(error: DisplayError(messsage: "No image to display"))
        } else {
            self.images = images
            state = .loaded(image: images.randomElement()!)
        }
    }
    
    func reloadImage() {
        state = .loaded(image: images.randomElement()!)
    }
}

enum State {
    case idle
    case loading
    case failed(error: DisplayError)
    case loaded(image: String)
}

struct DisplayError: Error {
    let messsage: String
}
