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
    
    init() {
        Task {
          await fetchRandomFavoriteImage()
        }
    }

    
    func fetchRandomFavoriteImage() async {
        state = .loading
        let images = await watchService.fetchFavoriteImages()
        state = .loaded(image: "https://cdn2.thedogapi.com/images/SkvZgx94m.jpg")
    }
}

enum State {
    case idle
    case loading
    case failed(error: Error)
    case loaded(image: String)
}
