//
//  DetailViewController.swift
//  Aula1CRUD
//
//  Created by ajalmar on 19/03/15.
//  Copyright (c) 2015 br.edu.ifce. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var index:Int!
    var code: String!
    var detail: String!
    var delegate: RootViewController!
    
    @IBOutlet weak var textFieldCode: UITextField!
    @IBOutlet weak var textFieldDetail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldCode.text = code
        textFieldDetail.text = detail
        
        textFieldCode.enabled = index == -1;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickOnSalvar(sender: UIBarButtonItem) {
        
        delegate!.update(index, code: textFieldCode.text, detail: textFieldDetail.text)
        
        navigationController?.popToRootViewControllerAnimated(true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
