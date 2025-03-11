import SwiftUI

struct ContentView: View {
    @AppStorage("sourceDestinationPairs") private var storedPairsData: Data?

    @State private var sourceDestinationPairs: [SourceDestinationPair] = [
        SourceDestinationPair(source: "BXH", destination: "LBG"),
        SourceDestinationPair(source: "CST", destination: "BXH"),
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Dynamically create departure board views
                ForEach(sourceDestinationPairs, id: \.self) { pair in
                    DepartureBoardView(pair: pair)
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
        .onAppear {
            loadPairs()
        }
    }

    // Load pairs from UserDefaults
    private func loadPairs() {
        if let storedData = storedPairsData,
            let decodedPairs = try? JSONDecoder().decode([SourceDestinationPair].self, from: storedData)
        {
            sourceDestinationPairs = decodedPairs
        } else {
            sourceDestinationPairs = [
                SourceDestinationPair(source: "BXH", destination: "LBG"),
                SourceDestinationPair(source: "CST", destination: "BXH"),
            ]
        }
    }
}

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
        }
        .onAppear {
            viewModel.getNextTrain(
                fromCRS: pair.source, toCRS: pair.destination)
        }
    }
}

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

#Preview {
    ContentView()
}
