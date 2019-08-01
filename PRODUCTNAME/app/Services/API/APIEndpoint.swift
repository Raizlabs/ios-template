//
//  APIEndpoint.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import Alamofire

public protocol APIEndpoint: NetworkLoggable {
    associatedtype ResponseType

    var path: String { get }
    typealias QueryParam = (String, String)
    var queryParams: [QueryParam]? { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders { get }
}

public extension APIEndpoint {

    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }

    var parameters: Parameters? {
        return nil
    }

    var queryParams: [QueryParam]? {
        return nil
    }

    var headers: HTTPHeaders {
        return [:]
    }

}
