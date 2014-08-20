//
//  WelcomeViewController.swift
//  disc
//
//  Created by 孟 智 on 14/7/14.
//  Copyright (c) 2014年 Dreambuffer. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var whatsDISCTextView: UITextView
    @IBOutlet var beginButton: UIButton
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        self.title = "首页"
        let backgroundImage = UIImage(named:"discbg.png")
        let imageView = UIImageView(image:backgroundImage)
        self.view.addSubview(imageView)
        
        let viewBound = self.view.bounds
        
        whatsDISCTextView.backgroundColor = UIColor.clearColor()
        whatsDISCTextView.editable = false
        whatsDISCTextView.font = UIFont.systemFontOfSize(14)
        whatsDISCTextView.textColor = UIColor.whiteColor()
        var text = "\r\n    DISC个性测试是国外企业广泛应用的一种人格测验，用于测查、评估和帮助人们改善其行为方式、人际关系、工作绩效、团队合作、领导风格等。\r\n     DISC个性测验由24组描述个性特质的形容词构成，每组包含四个形容词，这些形容词是根据支配性(D)、影响性(I)、稳定性(S)和服从性(C)四个测量维度以及一些干扰维度来选择的，要求被试者从中选择一个最适合和最不适合自己的形容词。\r\n\r\n     测验大约需要十分钟。"
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 25
        paragraphStyle.maximumLineHeight = 25
        paragraphStyle.minimumLineHeight = 25
        let attributeColor = UIColor(red:0.8,green:0.8,blue:0.8,alpha:1.0)
        var textAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(14),NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:attributeColor]
        whatsDISCTextView.attributedText = NSAttributedString(string:text,attributes:textAttributes)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        beginButton.addTarget(self,action:"tappedButtonAction",forControlEvents:UIControlEvents.TouchUpInside)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tappedButtonAction() {
        var mainViewController = MainViewController(nibName:"MainViewController", bundle:nil)
        self.presentViewController(mainViewController,animated:true,completion:nil)
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
