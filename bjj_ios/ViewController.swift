//
//  ViewController.swift
//  bjj_ios
//
//  Created by Damien Hervieux on 2019/09/08.
//  Copyright © 2019 Damien Hervieux. All rights reserved.
//

import UIKit

struct FormInput {
    var name: String
    var value: String
    init(name: String, value: String) {
        self.value = value
        self.name = name
    }
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    var list = [String]()
    var form_input = [FormInput]()
    
    
    @IBOutlet weak var textFieldTeacher: UITextField!
   
    @IBOutlet weak var textFieldCategory: UITextField!
    @IBOutlet weak var textFieldSub: UITextField!
    @IBOutlet weak var textFieldTitle: UITextField!
    
    @IBOutlet weak var textFieldComment: UITextField!
    @IBOutlet weak var textFieldPoint: UITextField!
    
    @IBOutlet weak var textarea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateFormInput()
        // Do any additional setup after loading the view.
        textFieldTeacher.delegate = self
        textFieldCategory.delegate = self
        textFieldTitle.delegate = self
        textFieldSub.delegate = self
        textFieldComment.delegate = self
        textFieldPoint.delegate = self
        
    }
    
    @IBAction func submit(_ sender: Any) {
//        Api.post
    }
    
    private func generateFormInput() {
        self.form_input = [
            FormInput(name: "teacher", value: ""),
            FormInput(name: "category", value: ""),
            FormInput(name: "title", value:""),
            FormInput(name: "sub_category", value: ""),
            FormInput(name: "comment", value: "")
        ]
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.tag)
        // tag == 0 is textFieldPoint
        if textField.tag == 0 {
            list.append(textField.text!)
            
            let map_list = list.enumerated().map {
                return "\($0.0 + 1)- \($0.1) \n"
            }
            // create new input OR clear input and add first one as text
            textarea.text = map_list.joined(separator: "\n")
        } else {
            // use the tag to refer to the index in form_input
            // TODO: not scalable, find better solution
            self.form_input[textField.tag - 1].value = textField.text!
            print(self.form_input)
        }
        
        
        
    }
}

