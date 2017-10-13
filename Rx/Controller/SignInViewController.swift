//
//  SignInViewController.swift
//  Rx
//
//  Created by Arfaa Nisar Shariff on 13/10/17.
//  Copyright © 2017 Arfaa Nisar Shariff. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController{
    
    let disposeBag = DisposeBag()
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    
    var viewModel = SignInViewModel()
    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        setUpRxViewModel()
    }
    
    func setUpRx(){
        let userNameValid = usernameTextfield.rx.text.map{
            ($0?.characters.count)! >= 5
        }
        
        let passwordValid = passwordTextfield.rx.text.map({
            ($0?.characters.count)! >= 5
        })
        
        let everythingValid = Observable.combineLatest(userNameValid, passwordValid){$0 && $1}
        
        userNameValid.bind(to: passwordTextfield.rx.isEnabled).addDisposableTo(disposeBag)
        
        everythingValid.bind(to: signInButton.rx.isEnabled).addDisposableTo(disposeBag)
        
        
        
        signInButton.rx.tap.subscribe{event in
            switch event{
            case .next(let value):
                print("On next method", value)
            case .error(let error):
                print(error)
                
            case .completed:
                print("completed")
                
            }
            
        }
    }
    
    func setUpRxViewModel(){
        usernameTextfield.rx.text.orEmpty.bind(to:viewModel.usernameText).addDisposableTo(disposeBag)
        passwordTextfield.rx.text.orEmpty.bind(to:viewModel.passwordText).addDisposableTo(disposeBag)
        viewModel.userNameValid.bind(to: passwordTextfield.rx.isEnabled).addDisposableTo(disposeBag)
        viewModel.everythingValid.bind(to: signInButton.rx.isEnabled).addDisposableTo(disposeBag)
    }
}
