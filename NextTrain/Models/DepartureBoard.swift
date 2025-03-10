//
//  DepartureBoard.swift
//  Next train
//
//  Created by Rajdeep Varma on 04/03/2025.
//

import Foundation

struct DepartureBoard: Codable{
    struct TrainService: Codable{
        struct Destination: Codable{
            let locationName: String
            let crs: String
        }
        let destination: [Destination]
        let std: String
        let etd: String
        let platform: String?
    }
    let trainServices: [TrainService]
}
