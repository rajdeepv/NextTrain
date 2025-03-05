//
//  TrainServiceListViewModel.swift
//  Next train
//
//  Created by Rajdeep Varma on 05/03/2025.
//

import Foundation
import LDBWS

class TrainServiceListViewModel: ObservableObject {
    @Published var trainServices: [TrainServiceViewModel] = []

    func getNextTrain(fromCRS: String, toCRS: String) {
        let depBoardUrl =
            "https://api1.raildata.org.uk/1010-live-departure-board-dep1_2/LDBWS/api/20220120/GetDepartureBoard/\(fromCRS)?numRows=10&filterCrs=\(toCRS)&filterType=to"

        let apiService = APIService.shared

        apiService.getJson(urlString: depBoardUrl, apiKey: API_KEY) { (result: Result<DepartureBoard, APIService.APIError>) in

            switch result {
            case let .success(departureBoard):
                DispatchQueue.main.async {
                    self.trainServices = departureBoard.trainServices.map({ TrainServiceViewModel(trainService: $0) })
                }

                self.trainServices.forEach { trainservice in
                    print(trainservice.destination)
                    print(trainservice.actualTime)
                    print(trainservice.scheduledTime)
                    print(trainservice.platform)
                }
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
