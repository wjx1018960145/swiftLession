//
//  MarkDownViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2021/12/13.
//

import UIKit
import Foundation
import MarkdownView
class MarkDownViewController: UIViewController {

    var titleStr:String?
    var url:NSString?
    
    init() {
      super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
        self.title = titleStr
      view.backgroundColor = .systemBackground
      
//      let plugins = [
//        URL(string: "https://cdnjs.cloudflare.com/ajax/libs/markdown-it-footnote/3.0.3/markdown-it-footnote.js")!,
//        URL(string: "https://cdn.jsdelivr.net/npm/markdown-it-sub@1.0.0/index.min.js")!,
//        URL(string: "https://cdn.jsdelivr.net/npm/markdown-it-sup@1.0.0/index.min.js")!,
//      ].map {
//        try! String(contentsOf: $0, encoding: .utf8)
//      }

      let md = MarkdownView()
      view.addSubview(md)
      md.translatesAutoresizingMaskIntoConstraints = false
        md.frame = UIScreen.main.bounds
        NSLayoutConstraint.activate([
          md.topAnchor.constraint(equalTo: view.topAnchor),
          md.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          md.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          md.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if let path = Bundle.main.url(forResource: url! as String, withExtension: "md") {
            
            if let fileContents = try? String(contentsOf: path)  {
                // we loaded the file into a string!
                md.load(markdown: fileContents , enableImage: false)
                print(fileContents)
            }
        }
      
        
    
      
        
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
