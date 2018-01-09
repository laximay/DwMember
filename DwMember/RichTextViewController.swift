//
//  RichTextViewController.swift
//  DwMember
//
//  Created by wenjing on 2018/1/9.
//  Copyright © 2018年 Wen Jing. All rights reserved.
//

import UIKit

class RichTextViewController: UIViewController {

    @IBOutlet weak var richTextLab: UITextView!
    var richText: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          let attribstr = try! NSAttributedString.init(data:(richText.data(using: String.Encoding.unicode))! , options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
        
        self.richTextLab.attributedText = attribstr

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
