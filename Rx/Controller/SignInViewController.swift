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
    
    private var viewModel : SignInViewModel!
    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        setUpRxViewModel()

    }
    
    func setUpRxViewModel(){
        self.viewModel = SignInViewModel(username: self.usernameTextfield.rx.text.orEmpty.asObservable(),
                                                password: self.passwordTextfield.rx.text.orEmpty.asObservable(),
                                                loginTap: self.signInButton.rx.tap.asObservable())
        
        self.viewModel.loginEnabled.bindNext{ valid  in
            self.signInButton.isEnabled = valid
//            self.signInButton.alpha = valid ? 1 : 0.5
            }.addDisposableTo(disposeBag)
        
        self.viewModel.loginObservable.bindNext{ input in
            // TODO: - add logic for login
            print("Login Clicked")
            }.addDisposableTo(disposeBag)

        
    }
    
    func onClickSignInButton(){
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
}
