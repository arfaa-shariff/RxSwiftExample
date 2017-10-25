//
//  MoyaRequest.swift
//  Rx
//
//  Created by Arfaa Nisar Shariff on 16/10/17.
//  Copyright © 2017 Arfaa Nisar Shariff. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper
import RxSwift

class MoyaRequest{
    
    func signIn(userData: Creator) -> Observable<AuthenticationStatus> {
        return provider.request(.login(userData)).map{input in
            return decideSuccessOrError(statusCode: input.statusCode)
        }
    }
}

func decideSuccessOrError(statusCode: Int) -> AuthenticationStatus{
    if statusCode == 400 {
        return .Failure(message: false)
    } else if statusCode == 200 {
        return .Success(ok: true)
    }
    
    return .Failure(message: false)
}
