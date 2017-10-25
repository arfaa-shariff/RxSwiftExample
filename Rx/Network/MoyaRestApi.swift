//
//  MoyaRestApi.swift
//  Rx
//
//  Created by Arfaa Nisar Shariff on 16/10/17.
//  Copyright © 2017 Arfaa Nisar Shariff. All rights reserved.
//

import Foundation
import Moya

enum RestApi{
    case login(Creator)
}
extension RestApi: AuthorizedTargetType{
    public var baseURL: URL {
        return URL(string: "https://192.169.1.14:5000")!
        }
    
    var path: String {
        switch self {
        case .login(_):
            return "/authentication/login"
        }
    }
    
    var needsAuth: Bool {
        switch self {
        case .login(_):
            return false
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login(_):
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .login(let userData):
            return userData.toJSON()
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .login(_):
            return JSONEncoding.default
        }
    }
    
    var sampleData: Data {
        switch self {
        case .login(_):
            return "".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        return .request
    }
}
