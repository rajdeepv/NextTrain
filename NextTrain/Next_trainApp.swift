//
//  Next_trainApp.swift
//  Next train
//
//  Created by Rajdeep Varma on 04/03/2025.
//

import OSLog
import SwiftUI

#if DEBUG
    import SBTUITestTunnelServer
#endif

@main
struct Next_trainApp: App {
    #if DEBUG
        let logger: Logger

        init() {
            logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "app")

            logger.info(">>> Starting SBTUITestTunnelServer\n")
            SBTUITestTunnelServer.takeOff()
            logger.info(">>> Adding custom command 'xoxo'\n")

            SBTUITestTunnelServer.registerCustomCommandNamed("xoxo") { [self] obj in
                logger.info(">>> Got a call to 'xoxo'\n")
                let inputData = obj as! String
                logger.info("Received message: \(inputData)\n")
                return " :) I got:" + inputData  as NSObject
            }

        }
    #endif

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
