//
//  RequestProtocol.swift
//  Services
//
//  Created by {{ cookiecutter.lead_dev }} on {% now 'utc', '%D' %}.
//  Copyright © {% now 'utc', '%Y' %} {{ cookiecutter.company_name }}. All rights reserved.
//

import Alamofire

public protocol RequestProtocol: class {

    var isFinished: Bool { get }

    func cancel()
    @discardableResult func onCompletion(_ closure: @escaping () -> Void) -> Self

}

extension DataRequest: RequestProtocol {

    public var isFinished: Bool {
        return progress.isFinished
    }

    public func onCompletion(_ closure: @escaping () -> Void) -> Self {
        return response { _ in
            closure()
        }
    }

}

public class RequestBatch {

    private var completions = [() -> Void]()
    private var requests: [RequestProtocol] = []

    public init() {
    }

    @discardableResult public func perform(_ requests: [RequestProtocol]) -> Self {
        self.requests = requests
        let group = DispatchGroup()
        requests.forEach {
            group.enter()
            $0.onCompletion { group.leave() }
        }
        group.notify(queue: .main) {
            self.completions.forEach { $0() }
            self.completions = []
            self.requests = []
        }
        return self
    }

}

extension RequestBatch: RequestProtocol {

    public var isFinished: Bool {
        return requests.allSatisfy { $0.isFinished }
    }

    public func cancel() {
        requests.forEach { $0.cancel() }
    }

    public func onCompletion(_ closure: @escaping () -> Void) -> Self {
        self.completions.append(closure)
        return self
    }

}
