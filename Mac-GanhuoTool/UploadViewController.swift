//
//  UploadViewController.swift
//  Mac-GanhuoTool
//
//  Created by why on 5/17/15.
//  Copyright (c) 2015 why. All rights reserved.
//

import Cocoa

class UploadViewController: NSViewController {

    @IBOutlet weak var urlTextField: NSTextField!
    @IBOutlet weak var typeTextField: NSTextField!
    @IBOutlet weak var descriptionTextField: NSTextField!
    @IBOutlet weak var senderTextField: NSTextField!
    @IBOutlet weak var statusLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendButtonPressed(sender: AnyObject) {
        let query = AVQuery(className: "ganhuo")
        query.whereKey("url", equalTo: urlTextField.stringValue)
        query.findObjectsInBackgroundWithBlock { (objs, error) -> Void in
            if objs.count > 0 {
                self.statusLabel.stringValue = "干货已存在"
            } else {
                self.statusLabel.stringValue = "干货不存在"
                self.addGanhuo()
            }
        }
    }
    
    func addGanhuo() {
        let ganhuo = AVObject(className: "ganhuo")
        ganhuo.setObject(urlTextField.stringValue, forKey: "url")
        ganhuo.setObject(typeTextField.stringValue, forKey: "type")
        ganhuo.setObject(descriptionTextField.stringValue, forKey: "desc")
        ganhuo.setObject(senderTextField.stringValue, forKey: "who")
        ganhuo.saveInBackgroundWithBlock { (result, error) -> Void in
            if result {
                self.statusLabel.stringValue = "上传成功"
                self.urlTextField.stringValue = ""
                self.descriptionTextField.stringValue = ""
            } else {
                self.statusLabel.stringValue = "上传失败\(error)"
            }
        }
    }
}


extension UploadViewController: NSTextFieldDelegate {
    override func controlTextDidChange(obj: NSNotification) {
        let query = AVQuery(className: "ganhuo")
        query.whereKey("url", equalTo: descriptionTextField.stringValue)
        query.findObjectsInBackgroundWithBlock { (objs, error) -> Void in
            if objs.count > 0 {
                self.statusLabel.stringValue = "干货已存在"
            } else {
                self.statusLabel.stringValue = "干货不存在"
            }
        }
    }

}