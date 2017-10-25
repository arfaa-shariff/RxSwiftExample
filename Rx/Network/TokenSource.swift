//
//  TokenSource.swift
//  Rx
//
//  Created by Arfaa Nisar Shariff on 16/10/17.
//  Copyright © 2017 Arfaa Nisar Shariff. All rights reserved.
//

import Foundation
import Moya
import Alamofire

class TokenSource {
    var token = String()
    init() { }
}

protocol AuthorizedTargetType: TargetType {
    var needsAuth: Bool { get }
}

struct AuthPlugin: PluginType {
    let tokenClosure: () -> String?
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard
            let token = tokenClosure(),
            let target = target as? AuthorizedTargetType,
            target.needsAuth
            else {
                return request
        }
        
        var request = request
        request.addValue(token, forHTTPHeaderField: "Authorization")
        return request
    }
    
}
// TODO: Add certificate from a trusted anchor - JUNA-417
// Server Trust Evaluation: https://developer.apple.com/library/content/technotes/tn2232/_index.html
let source = TokenSource()

class RequestManager: Manager {
    static let manager: RequestManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60 // time in seconds
        configuration.timeoutIntervalForResource = 60
        let serverTrustPolicyManager: ServerTrustPolicyManager?
        return RequestManager(configuration: configuration, serverTrustPolicyManager: CustomServerTrustPolicyManager())
    }()
}

let provider = RxMoyaProvider<RestApi>(manager: RequestManager.manager,
                                       plugins: [
                                        AuthPlugin(tokenClosure: {
                                            return source.token })
                                        
    ]
)
