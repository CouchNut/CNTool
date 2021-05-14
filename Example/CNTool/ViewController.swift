//
//  ViewController.swift
//  CNTool
//
//  Created by CouchNut on 05/12/2021.
//  Copyright (c) 2021 CouchNut. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let result = UILabel()
        result.frame = CGRect(origin: CGPoint(x: 20, y: self.view.bounds.midY - 75),
                              size: CGSize(width: self.view.bounds.width - 40, height: 150))
        result.isUserInteractionEnabled = true
        return result
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.label)
        
        var richText = CNRichText(content: "Red Green Blue")
        richText.cn_textColor(.red).cn_text("Green").cn_textColor(.green).cn_text("Blue").cn_textColor(.blue)
        
        
        self.label.attributedText = richText.attributedString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

