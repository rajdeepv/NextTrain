//
//  TrainServiceView.swift
//  NextTrain
//
//  Created by kira on 11/03/2025.
//

import Foundation
import SwiftUI

struct TrainServiceView: View {

    let trainService: TrainServiceViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Destination: \(trainService.destination)")
                .font(.headline)
                .foregroundColor(.blue)
                .padding(.horizontal)

            HStack {
                Label("STD:", systemImage: "clock")
                Text(trainService.scheduledTime)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)

            HStack {
                Label("Actual:", systemImage: "arrow.right.circle")
                Text(trainService.actualTime)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)

            HStack {
                Label("Platform:", systemImage: "train.side.front.car")
                Text(trainService.platform)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)

        }
    }
}
