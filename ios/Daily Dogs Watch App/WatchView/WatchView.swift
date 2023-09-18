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
        contentView().gesture(
            LongPressGesture().onEnded { _ in 
                viewModel.reloadImage()
            }
        )
    }
    
    func contentView() -> AnyView {
        switch viewModel.state {
        case .loading:
            return AnyView(ProgressView())
        case .loaded(let image):
            return AnyView(AsyncImage(
                url: URL(string: image),
                content: { image in
                    image.resizable()
                        .scaledToFit()
                },
                placeholder: {
                    ProgressView()
                }
            ))
        case .failed(let error):
            return  AnyView(Text(error.messsage))
        default:
            return AnyView(EmptyView())
        }
    }
}

struct WatchView_Previews: PreviewProvider {
    static var previews: some View {
        WatchView(viewModel: WatchViewModel())
    }
}
