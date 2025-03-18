//
//  Next_trainUITests.swift
//  Next trainUITests
//
//  Created by Rajdeep Varma on 04/03/2025.
//

import SBTUITestTunnelClient
import XCTest

struct SourceDestinationPair: Codable, Hashable {
    let source: String
    let destination: String
}

class Message: NSCoder {
    var message: String
    init(message: String) {
        self.message = message
    }
}

final class Next_trainUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        app.launchTunnel {
            let stubId = self.app.stubRequests(
                matching: SBTRequestMatch.init(
                    url:
                        "https://api1.raildata.org.uk/1010-live-departure-board-dep1_2/LDBWS/api/20220120/GetDepartureBoard/.*?numRows=10&filterCrs=.*&filterType=to"
                ),
                response: SBTStubResponse(response: [
                    "trainServices": [
                        [
                            "destination": [["locationName": "My Home"]],
                            "std": "15:19",
                            "etd": "15:19",
                            "platform": "1",
                        ]
                    ]
                ]
                ))
        }

        if let data = app.userDefaultsObject(forKey: "sourceDestinationPairs") as? Data,
            let decodedPairs = try? JSONDecoder().decode([SourceDestinationPair].self, from: data)
        {
            print(decodedPairs)
        }

        let result = app.performCustomCommandNamed("xoxo", object: NSString(string: "Hello from test! please echo this back with a smiley"))
        print(result!)

    }

}
