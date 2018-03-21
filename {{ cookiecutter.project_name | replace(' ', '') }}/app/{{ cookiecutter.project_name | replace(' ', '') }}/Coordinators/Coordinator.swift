//
//  Coordinator.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 3/24/17.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import ObjectiveC.runtime

class Coordinator: NSObject {}

extension Coordinator {

    private static var key = 0

    func attach(to child: AnyObject) {
        var attached = objc_getAssociatedObject(child, &Coordinator.key) as? NSMutableArray

        if attached == nil {
            attached = NSMutableArray()
            objc_setAssociatedObject(child, &Coordinator.key, attached, .OBJC_ASSOCIATION_RETAIN)
        }

        attached?.add(self)
    }

    func detatch(from child: AnyObject) {
        (objc_getAssociatedObject(child, &Coordinator.key) as? NSMutableArray)?.remove(self)
    }

}
