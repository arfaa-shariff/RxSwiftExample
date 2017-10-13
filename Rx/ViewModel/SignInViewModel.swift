//
//  SignInViewModel.swift
//  Rx
//
//  Created by Arfaa Nisar Shariff on 13/10/17.
//  Copyright © 2017 Arfaa Nisar Shariff. All rights reserved.
//

import Foundation
import RxSwift

class SignInViewModel{
    let usernameText = Variable<String>("")
    let passwordText = Variable<String>("")
    
    var userNameValid : Observable<Bool> {
        return usernameText.asObservable().map{ input in input.characters.count >= 5
        }
    }
    
    var passwordValid : Observable<Bool> {
        return passwordText.asObservable().map{ input in input.characters.count >= 5
        }
    }
    
    var everythingValid : Observable<Bool>{
        return Observable.combineLatest(userNameValid, passwordValid)
        {$0 && $1}
    }
}
