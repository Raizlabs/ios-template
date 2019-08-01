//
//  AppLifecycleConfigurable.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on {% now 'utc', '%D' %}.
//  Copyright © {% now 'utc', '%Y' %} {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit

/**
 *  Objects conforming to this protocol provide some sort of configurable behavior intended for execution
 *  on app launch.
 */
protocol AppLifecycle {

    /// A check to see if the configuration is enabled.
    var isEnabled: Bool { get }

    /**
     Invoked on UIApplication.applicationDidFinishLaunching to give the conforming instance a chance to execute configuration.

     - parameter application:   The application
     - parameter launchOptions: Optional launch options
     */
    func onDidLaunch(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?)

}

extension AppLifecycle {

    var isEnabled: Bool {
        return true
    }

}
