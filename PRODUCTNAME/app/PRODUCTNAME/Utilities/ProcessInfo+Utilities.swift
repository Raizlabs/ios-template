//
//  ProcessInfo+Utilities.swift
//  PRODUCTNAME
//
//  Created by Zev Eisenberg on 4/3/18.
//  Copyright © 2018 ORGANIZATION. All rights reserved.
//

extension ProcessInfo {

    static var isRunningUITests: Bool {
        // If you want to run the app in Debug mode, but have it pretend that it
        // is running UI tests, for purposes of testing with fake data or the like,
        // return true here.
        #if DEBUG
            return ProcessInfo.processInfo.environment["uiTests"] == "true"
        #else
            return false
        #endif
    }

}
