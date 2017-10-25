//
//  SignInViewModel.swift
//  Rx
//
//  Created by Arfaa Nisar Shariff on 13/10/17.
//  Copyright © 2017 Arfaa Nisar Shariff. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import Moya_ObjectMapper
import Alamofire


class SignInViewModel {
    
    let validatedEmail: Observable<Bool>
    let validatedPassword: Observable<Bool>
    let loginEnabled: Observable<Bool>
    let loginObservable: Observable<Bool>
    
    init(username: Observable<String>,
         password: Observable<String>,
         loginTap: Observable<Void>) {
        
        self.validatedEmail = username
            .map { $0.characters.count >= 5 }
            .shareReplay(1)
        
        self.validatedPassword = password
            .map { $0.characters.count >= 2 }
            .shareReplay(1)
        
        self.loginEnabled = Observable.combineLatest(validatedEmail, validatedPassword ) { $0 && $1 }
        let userAndPassword = Observable.combineLatest(username, password) {($0,$1)}
        
        self.loginObservable = loginTap.withLatestFrom(userAndPassword).flatMapLatest{ (username, password) in
            return SignInViewModel.login(username: username, password: password).observeOn(MainScheduler.instance)
        }
    }
    
    private class func login(username: String?, password: String?) -> Observable<Bool> {
        return RestService.req(username: username!, password: password!)
        
    }
}
