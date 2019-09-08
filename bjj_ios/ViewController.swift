//
//  ViewController.swift
//  bjj_ios
//
//  Created by Damien Hervieux on 2019/09/08.
//  Copyright © 2019 Damien Hervieux. All rights reserved.
//

import UIKit

struct FormInput: Codable {
    var name: String
    var value: String
    init(name: String, value: String) {
        self.value = value
        self.name = name
    }
}

struct TextFieldPoint: Codable {
    var number: Int
    var content: String
    init(number: Int, content: String) {
        self.content = content
        self.number = number
    }
}

struct PostData: Codable {
    
    var title: String
    var teacher: String
    var category: String
    var sub_category: String
    var comment: String
    var items: [TextFieldPoint]
    
    init(   title: String,
            teacher: String,
            category: String,
            sub_category: String,
            comment: String,
            items: [TextFieldPoint]) {
        self.title = title
        self.teacher = teacher
        self.category = category
        self.sub_category = sub_category
        self.comment = comment
        self.items = items
    }
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    var list = [TextFieldPoint]()
    var form_input = [FormInput]()
    var data = [Data]()
    
    
    
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
        self.insertData()
    }
    
//    private func getData() {
//        Api.shared.get(path: "/notes") {(res) in
//            switch res {
//            case.failure(let err):
//                print(err)
//            case .success(let data):
//                self.data = [data]
//            }
//        }
//    }
    
    private func insertData() {
        
        let title = form_input.first(where: { $0.name  == "title" })!.value
        let teacher = form_input.first(where: { $0.name  == "teacher" })!.value
        let category = form_input.first(where: { $0.name  == "category" })!.value
        let sub_category = form_input.first(where: { $0.name  == "sub_category" })!.value
        let comment = form_input.first(where: { $0.name  == "comment" })!.value
        
        let post_data = PostData(title: title, teacher: teacher, category: category, sub_category: sub_category, comment: comment, items: list)
        
        Api.shared.post(path: "/notes", post_data: post_data) {(res) in
            switch res {
            case.failure(let err):
                print(err)
            case .success(let data):
                print(data)
            }
            
        }
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
            list.append(TextFieldPoint(number: list.count, content: textField.text!))
            
            let map_list = list.enumerated().map {
                return "\($0.0 + 1)- \($0.1.content) \n"
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

