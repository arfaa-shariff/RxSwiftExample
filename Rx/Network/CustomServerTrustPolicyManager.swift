//
//  CustomServerTrustPolicyManager.swift
//  Rx
//
//  Created by Arfaa Nisar Shariff on 16/10/17.
//  Copyright © 2017 Arfaa Nisar Shariff. All rights reserved.
//

import Foundation
import Alamofire

class CustomServerTrustPolicyManager: ServerTrustPolicyManager {
    
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    
    public init() {
        super.init(policies: [:])
    }
}
