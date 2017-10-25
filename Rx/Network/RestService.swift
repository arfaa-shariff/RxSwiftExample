//
//  RestService.swift
//  Rx
//
//  Created by Arfaa Nisar Shariff on 24/10/17.
//  Copyright © 2017 Arfaa Nisar Shariff. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper
import RxSwift
import Alamofire

enum AuthenticationStatus {
    case Success(ok: Bool)
    case Failure(message: Bool)
}

class RestService:NSObject {
    
    static var moyaRequest = MoyaRequest()
    static var disposeBag = DisposeBag()
    
    static func req(username: String, password: String) -> Observable<Bool> {
        let userData = Creator()
        userData?.username = username
        userData?.password = password
        print("Username password", userData?.username, userData?.password)
        return  Observable.create { observer in moyaRequest.signIn(userData: userData!).subscribe{ event -> Void in
            switch event {
                
            case .next(let response):
                print("Response",response)
                
            case .error(let error):
                let moyaError: MoyaError? = error as? MoyaError
                let response: Response? = moyaError?.response
                let statusCode: Int? = response?.statusCode
                
                print("Sample Response code error" + String(describing: statusCode))
            default:
                break
            }
            }
            return Disposables.create()
        }
        
    }
    
}
