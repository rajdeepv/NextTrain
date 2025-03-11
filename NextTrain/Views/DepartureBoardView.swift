//
//  DepartureBoardView.swift
//  NextTrain
//
//  Created by kira on 11/03/2025.
//

import Foundation
import SwiftUI

// Separate View for Each Departure Board
struct DepartureBoardView: View {
    let pair: SourceDestinationPair
    @StateObject private var viewModel = TrainServiceListViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("From: \(pair.source)   To: \(pair.destination)")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .padding(.top, 1)

            List(viewModel.trainServices, id: \.self.scheduledTime) { trainService in
                VStack(alignment: .leading) { TrainServiceView(trainService: trainService) }
                    .padding(.maximum(0, 5))
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                    .frame(maxWidth: .infinity, alignment: .leading)  // Fill horizontal space
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 2, trailing: 20))
            }
            .listStyle(.plain)
            .refreshable {
                viewModel.getNextTrain(
                    fromCRS: pair.source, toCRS: pair.destination)
            }
            .onAppear {
                viewModel.getNextTrain(
                    fromCRS: pair.source, toCRS: pair.destination)
            }
        }
    }
}
