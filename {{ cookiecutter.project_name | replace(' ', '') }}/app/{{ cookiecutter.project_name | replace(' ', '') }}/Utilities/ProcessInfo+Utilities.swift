//
//  ProcessInfo+Utilities.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by Zev Eisenberg on 4/3/18.
//  Copyright © 2018 {{ cookiecutter.company_name }}. All rights reserved.
//

import Foundation

extension ProcessInfo {

    static let uiTestsKey = "com.raizlabs.uiTests"

    static var isRunningUITests: Bool {
        // If you want to run the app in Debug mode, but have it pretend that it
        // is running UI tests, for purposes of testing with fake data or the like,
        // return true here.
        #if DEBUG
            return ProcessInfo.processInfo.environment[ProcessInfo.uiTestsKey] == "true"
        #else
            return false
        #endif
    }

}
