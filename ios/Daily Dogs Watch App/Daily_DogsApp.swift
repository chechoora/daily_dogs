//
//  Daily_DogsApp.swift
//  Daily Dogs Watch App
//
//  Created by Kyrylo Kharchenko on 17.09.2023.
//

import SwiftUI

@main
struct Daily_Dogs_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            WatchView(viewModel: WatchViewModel())
        }
    }
}
