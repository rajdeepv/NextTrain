//
//  DepartureBoardViewModel.swift
//  Next train
//
//  Created by Rajdeep Varma on 04/03/2025.
//

import Foundation
struct TrainServiceViewModel{
    let trainService: DepartureBoard.TrainService
    
    var destination: String {
        trainService.destination.first?.locationName ?? ""
    }
    
    var scheduledTime: String {
        trainService.std
    }
    
    var actualTime: String {
        trainService.etd
    }
    
    var platform: String {
        trainService.platform ?? ""
    }
}
