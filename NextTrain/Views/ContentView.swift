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

#Preview {
    ContentView()
}
