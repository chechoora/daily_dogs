//
//  WatchView.swift
//  daily_watch_dogs Watch App
//
//  Created by Kyrylo Kharchenko on 17.09.2023.
//

import SwiftUI

struct WatchView: View {
    
    @ObservedObject var viewModel: WatchViewModel
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .loaded(let image):
            AsyncImage(
                url: URL(string: image),
                content: { image in
                    image.resizable()
                        .scaledToFit()
                },
                placeholder: {
                    ProgressView()
                }
            )
        default:
            EmptyView()
        }
    }
}

struct WatchView_Previews: PreviewProvider {
    static var previews: some View {
        WatchView(viewModel: WatchViewModel())
    }
}
