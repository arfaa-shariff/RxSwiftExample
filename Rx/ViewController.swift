//
//  ViewController.swift
//  Rx
//
//  Created by Arfaa Nisar Shariff on 10/10/17.
//  Copyright © 2017 Arfaa Nisar Shariff. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let bag = DisposeBag()
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTextfieldValueInLabel()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    func displayTextfieldValueInLabel(){
        firstTextField.rx.text.map{
            "Hello \($0!)"
            }.bind(to: label.rx.text)
        
    }
    func sequence(){
        let helloSequence = Observable.just(["H","e","l","l","o"])
        let subscriber = helloSequence.subscribe{event in
            switch event{
            case .next(let value):
                print(value)
                
            case .error(let error):
                print(error)
                
            case .completed:
                print("completed")
            }
        }
        
        subscriber.addDisposableTo(bag)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
}

