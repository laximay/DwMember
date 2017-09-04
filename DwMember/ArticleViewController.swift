//
//  ArticleViewController.swift
//  DwMember
//
//  Created by wenjing on 2017/9/4.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Just
class ArticleViewController: UIViewController {
    
    var type: articleType =  .ABOUTUS

    @IBOutlet weak var context: UILabel!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var dateLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getarticle(type: type)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //文章接口
     func getarticle(type: articleType)   {
        Just.post(ApiUtil.articleApi ,  data: ["company": ApiUtil.companyCode, "type" : type]) { (result) in
            if result.ok {
                guard let json = result.json as? NSDictionary else{
                    return
                }
                let datas = DwArticleRootClass(fromDictionary: json).data!
                 let attribstr = try! NSAttributedString.init(data:(datas.content.data(using: String.Encoding.unicode))! , options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
                
                OperationQueue.main.addOperation {
                    
                    self.context.attributedText = attribstr
                    self.titleLab.text = datas.title
                    self.dateLab.text = datas.date
                    
                }

                
            }
            
        }
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
