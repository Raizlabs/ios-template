//
//  APIConstants.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on {% now 'utc', '%D' %}.
//  Copyright © {% now 'utc', '%Y' %} {{ cookiecutter.company_name }}. All rights reserved.
//

/// APIConstants that are used in multiple places
enum APIConstants {
    // Headers
    static let authorization = "Authorization"
    static let accept = "Accept"
    static let contentType = "Content-Type"

    // Values
    static let applicationJSON = "application/json"
    static let formEncoded = "application/x-www-form-urlencoded"

    // Keys
    static let grantType = "grant_type"
    static let clientID = "client_id"
    static let clientSecret = "client_secret"
    static let token = "token"
}
