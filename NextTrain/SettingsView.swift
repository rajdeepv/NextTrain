import SwiftUI

struct SourceDestinationPair: Codable, Hashable {
    let source: String
    let destination: String
}

struct SettingsView: View {
    @Binding var sourceDestinationPairs: [SourceDestinationPair] // Binding to ContentView
    @State private var source = ""
    @State private var destination = ""
    
    var body: some View {
        VStack {
            Text("Configure Source and Destination")
                .font(.title2)
                .padding()

            // Form to input new source-destination pairs
            HStack {
                TextField("Source", text: $source)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("Destination", text: $destination)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            Button("Add Pair") {
                if !source.isEmpty && !destination.isEmpty {
                    let newPair = SourceDestinationPair(source: source, destination: destination)
                    sourceDestinationPairs.append(newPair)
                    savePairs()
                    source = ""
                    destination = ""
                }
            }
            .padding()
            
            List {
                ForEach(sourceDestinationPairs, id: \.self) { pair in
                    HStack {
                        Text("From: \(pair.source) To: \(pair.destination)")
                    }
                }
                .onDelete { indexSet in
                    sourceDestinationPairs.remove(atOffsets: indexSet)
                    savePairs()
                }
            }
        }
        .navigationTitle("Settings")
    }
    
    private func savePairs() {
        if let encodedData = try? JSONEncoder().encode(sourceDestinationPairs) {
            UserDefaults.standard.set(encodedData, forKey: "sourceDestinationPairs")
        }
    }
}

#Preview {
    SettingsView(sourceDestinationPairs: .constant([
        SourceDestinationPair(source: "BXH", destination: "LBG"),
        SourceDestinationPair(source: "CST", destination: "BXH")
    ]))
}



