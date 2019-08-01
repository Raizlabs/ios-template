//
//  HideBackButtonTextBehavior.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 7/7/17.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import Swiftilities

final class HidesBackButtonTextBehavior: ViewControllerLifecycleBehavior {

    static let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    func beforeAppearing(_ viewController: UIViewController, animated: Bool) {
        if viewController.navigationItem.title == nil {
            viewController.navigationItem.backBarButtonItem = HidesBackButtonTextBehavior.backButton
        }
    }
}
