//
//  OnboardingCoordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 3/27/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

class OnboardingCoordinator: Coordinator {

    weak var delegate: Delegate?

    static var hasOnboarded: Bool {
        return UserDefaults.hasOnboarded
    }

    func start(with presentation: (UIViewController) -> Void) {
        let vc = OnboardingViewController()
        vc.delegate = self
        attach(to: vc)
        presentation(vc)
    }

}

extension OnboardingCoordinator: Actionable {

    enum Action {
        case skip
        case join
        case signIn
    }

}

extension OnboardingCoordinator: OnboardingViewController.Delegate {

    func onboardingViewController(_ vc: OnboardingViewController, didNotify action: OnboardingViewController.Action) {
        switch action {
        case .skip: notify(.skip)
        case .join: notify(.join)
        case .signIn: notify(.signIn)
        }
    }

}
