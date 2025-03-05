import SwiftUI

struct ContentView: View {
    @StateObject private var onwardTrainServiceListVM = TrainServiceListViewModel()
    @StateObject private var returnTrainServiceListVM = TrainServiceListViewModel()

    let onwardFrom = "BXH"
    let onwardTo = "LBG"

    let returnFrom = "CST"
    let returnTo = "BXH"

    fileprivate func departureBoardView(viewModel: TrainServiceListViewModel, fromCRS: String, toCRS: String) -> some View {
        return VStack(alignment: .leading, spacing: 10) {
            Text("From: \(fromCRS) To: \(toCRS)")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .padding(.top, 10)

            List(viewModel.trainServices, id: \.self.scheduledTime) { trainService in
                VStack(alignment: .leading, spacing: 5) {
                    Text(trainService.destination)
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    HStack {
                        Label("STD:", systemImage: "clock")
                        Text(trainService.scheduledTime)
                    }
                    
                    HStack {
                        Label("Actual:", systemImage: "arrow.right.circle")
                        Text(trainService.actualTime)
                    }

                    HStack {
                        Label("Platform:", systemImage: "train.side.front.car")
                        Text(trainService.platform)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .listRowSeparator(Visibility.hidden)
                
                
            }
            .listStyle(.plain) // Plain style to remove row separators
            .refreshable {
                // Trigger refresh when user pulls to refresh
                viewModel.getNextTrain(fromCRS: fromCRS, toCRS: toCRS)
            }
            .onAppear {
                if viewModel.trainServices.isEmpty {
                    viewModel.getNextTrain(fromCRS: fromCRS, toCRS: toCRS)
                }
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                departureBoardView(viewModel: onwardTrainServiceListVM, fromCRS: onwardFrom, toCRS: onwardTo)
                departureBoardView(viewModel: returnTrainServiceListVM, fromCRS: returnFrom, toCRS: returnTo)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Next Trains")
            .font(.title3)
        }
    }
}

#Preview {
    ContentView()
}

