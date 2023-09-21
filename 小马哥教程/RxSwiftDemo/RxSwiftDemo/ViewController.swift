//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by wjx on 2023/9/20.
//

import UIKit

import RxSwift
import RxCocoa



class ViewController: UIViewController {
    
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        var  observable = Observable<Int>.create { observer in
            observer.onNext(11)
            observer.onNext(12)
            observer.onNext(13)
            return Disposables.create()
        }
        
        
       var sub =  observable.subscribe { event in
                
            switch event {
            case .next(let element):
                print("next",element)
            case .error(let error):
                print("error",error)
            case .completed:
                print("completed")
            
            }
        }
        
        observable.subscribe { event in
            print(event)
        } onError: { error in
            print(error)
        } onCompleted: {
            print("Completed")
        }.disposed(by: bag)
        
        // Do any additional setup after loading the view.
    }


}

