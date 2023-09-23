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
        contentView()
    }
    
    func contentView() -> AnyView {
        switch viewModel.state {
        case .idle:
            return AnyView(Text("Please Open Phone App to login").multilineTextAlignment(.center))
        case .loading:
            return AnyView(ProgressView())
        case .loaded(let images):
            return AnyView(
                VStack {
                    Button(action: {
                        viewModel.reloadImages()
                    }) {
                        Image(systemName: "goforward")
                    }
                    .buttonStyle(PlainButtonStyle())
                    TabView {
                        ForEach(images, id: \.self) { image in
                            displayImage(imageUrl: image)
                        }
                    }
                }
            )
        case .failed(let error):
            return  AnyView(Text(error.messsage))
        }
    }
    
    private func displayImage(imageUrl: String) -> AnyView {
        return AnyView(AsyncImage(
            url: URL(string: imageUrl),
            content: { image in
                image.resizable()
                    .scaledToFit()
            },
            placeholder: {
                ProgressView()
            }
        ))
    }
}

struct WatchView_Previews: PreviewProvider {
    static var previews: some View {
        WatchView(viewModel: WatchViewModel())
    }
}
