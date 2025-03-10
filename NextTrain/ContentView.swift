import SwiftUI

struct ContentView: View {
    @State private var sourceDestinationPairs: [SourceDestinationPair] = [
        SourceDestinationPair(source: "BXH", destination: "LBG"),
        SourceDestinationPair(source: "CST", destination: "BXH")
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Dynamically create departure board views
                ForEach(sourceDestinationPairs, id: \.self) { pair in
                    DepartureBoardView(pair: pair)
                        .padding(.top)
                }

                NavigationLink(destination: SettingsView(sourceDestinationPairs: $sourceDestinationPairs)) {
                    Text("Go to Settings")
                        .padding()
                        .foregroundColor(.blue)
                }
            }
            .navigationTitle("Next Trains")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Separate View for Each Departure Board
struct DepartureBoardView: View {
    let pair: SourceDestinationPair
    @StateObject private var viewModel = TrainServiceListViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Departures from \(pair.source) to \(pair.destination)")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .padding(.top, 10)

            List(viewModel.trainServices, id: \.self.scheduledTime) { trainService in
                VStack(alignment: .leading, spacing: 10) {
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
                .padding(.vertical)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .frame(maxWidth: .infinity, alignment: .leading) // Fill horizontal space
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .refreshable {
                viewModel.getNextTrain(fromCRS: pair.source, toCRS: pair.destination)
            }
        }
        .onAppear {
            viewModel.getNextTrain(fromCRS: pair.source, toCRS: pair.destination)
        }
    }
}

