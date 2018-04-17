//
//  StatusBarConfiguration.swift
//  PRODUCTNAME
//
//  Created by Zev Eisenberg on 4/3/18.
//  Copyright © 2018 ORGANIZATION. All rights reserved.
//

#if DEBUG
    import SimulatorStatusMagic
#endif

struct StatusBarConfiguration: AppLifecycle {

    var isEnabled: Bool {
        return ProcessInfo.isRunningUITests
    }

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        #if DEBUG
            SDStatusBarManager.sharedInstance().enableOverrides()
        #endif
    }

}

