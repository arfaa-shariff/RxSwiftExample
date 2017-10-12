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
import RxGesture

class ViewController: UIViewController {
    
    let bag = DisposeBag()
    
    @IBOutlet var formFields: [UITextField]!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTextfieldValueInLabel()
        buttonAction()
        tapGestureForLabel()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    func displayTextfieldValueInLabel(){
        //multiple textfields
        let valid = formFields.map{ input in
            input.rx.text.map{
                "Hello \($0!)"
                }.bind(to: label.rx.text)
            
        }
        //one textfield
        //        textfield.rx.text.map{
        //            "Hello \($0!)"
        //            }.bind(to: label.rx.text)
        //
    }
    func buttonAction(){
        button.rx.tap.subscribe{ event in
            switch event{
            case .next(let value):
                print("Button Value", value)
                
            case .error(let error):
                print(error)
                
            case .completed:
                print("completed")
            }
            
            }.addDisposableTo(bag)
    }
    
    func tapGestureForLabel(){
        label.rx.tapGesture().subscribe{event in
            switch event{
            case .next(let value):
                print("Label tap Value", value)
                
            case .error(let error):
                print(error)
                
            case .completed:
                print("completed")
            }
        }
        
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

