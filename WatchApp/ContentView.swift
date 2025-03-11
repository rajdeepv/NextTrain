//
//  ContentView.swift
//  WatchApp Watch App
//
//  Created by kira on 11/03/2025.
//

import SwiftUI

struct WatchAppContentView: View {
    @StateObject private var viewModel = TrainServiceListViewModel()
    let source = "BXH"
    let destination = "LBG"

    var body: some View {
        VStack {
            Text("Next Train")
                .font(.headline)
                .padding(.bottom, 2)

            if viewModel.trainServices.isEmpty {
                Text("Loading...")
                    .font(.caption)
            } else {
                List(viewModel.trainServices.prefix(3), id: \.scheduledTime) { train in
                    VStack(alignment: .leading) {
                        Text(train.destination)
                            .font(.subheadline)
                            .bold()
                        Text("STD: \(train.scheduledTime)")
                            .font(.caption)
                        Text("Platform: \(train.platform)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .onAppear {
            viewModel.getNextTrain(fromCRS: source, toCRS: destination)
        }.refreshable { viewModel.getNextTrain(fromCRS: source, toCRS: destination) }
    }
}

#Preview {
    WatchAppContentView()
}
