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
    
    @IBOutlet weak var stackPoint: UIStackView!
    
    @IBOutlet weak var pointNumber: UILabel!
    
    
    
    
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
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
        
        
        // IF textfield on enter is last one and has value then add one, otherwise update its text only

        
        if textField.tag == list.count && textField.text != "" {
            
            
            list.append(TextFieldPoint(number: list.count, content: textField.text!))
            
            let current_number = list.count
            
            // create stack view
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill // .Leading .FirstBaseline .Center .Trailing .LastBaseline
            stackView.distribution = .fill // .FillEqually .FillProportionally .EqualSpacing .EqualCentering
            
            
            // create number
            let number_frame = CGRect(x: 0, y: 0, width: 100, height: 30)
            let number_label = UILabel(frame: number_frame)
            number_label.text = "\(String(current_number + 1))."
            number_label.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
            
            // for horizontal stack view, you might want to add width constraint to label or whatever vie
            
            
            
            // create input
            
            let textField = UITextField()
            textField.tag = current_number
            textField.font = UIFont.systemFont(ofSize: 14)
            textField.borderStyle = UITextField.BorderStyle.roundedRect
            textField.delegate = self
            textField.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            
            
            // add number and input to stack with width
            
            stackView.addArrangedSubview(number_label)
            stackView.addArrangedSubview(textField)
            
            // add stack view to Stack point
            
            stackPoint.addArrangedSubview(stackView)

        } else {
            self.list = self.list.enumerated().map {
                (index, element) in
                if(element.number == textField.tag) {
                    var el = element
                    el.content = textField.text!
                    return el
                }
                return element
            }
        }
    }
}

