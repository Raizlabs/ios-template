//
//  CrashlyticsConfiguration.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on TODAYSDATE.
//  Copyright © THISYEAR {{ cookiecutter.company_name }}. All rights reserved.
//

import Fabric
import Crashlytics
import UIKit
import Services

struct CrashReportingConfiguration: AppLifecycle {

    var isEnabled: Bool {
        return BuildType.active != .debug
    }

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        Fabric.with([Crashlytics.self])
    }

}
