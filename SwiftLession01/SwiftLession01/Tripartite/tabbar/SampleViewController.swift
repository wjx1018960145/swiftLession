//
//  SampleViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/9.
//

import UIKit

class SampleViewController: UIViewController {
    var lblTitle: UILabel = {
        var label = UILabel()
        label.textColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 55.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        lblTitle.text = tabBarItem.title
        view.addSubview(lblTitle)

        lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.setNeedsLayout()
        // Do any additional setup after loading the view.
    }
    
    func inverseColor() {
        view.backgroundColor = lblTitle.textColor
        lblTitle.textColor = UIColor.white
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return view.backgroundColor == UIColor.white ? .default : .lightContent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
