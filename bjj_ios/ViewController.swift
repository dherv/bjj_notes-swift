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



class ViewController: UIViewController, UITextFieldDelegate {
    
    var form_input = [FormInput]()
    var data = [Data]()
    
    
    
//    @IBOutlet weak var textFieldTeacher: UITextField!
//
//    @IBOutlet weak var textFieldCategory: UITextField!
//    @IBOutlet weak var textFieldSub: UITextField!
//    @IBOutlet weak var textFieldTitle: UITextField!
//
//    @IBOutlet weak var textFieldComment: UITextField!
//    @IBOutlet weak var textFieldPoint: UITextField!
    
    var list = [TextFieldPoint]()

    
    @IBOutlet weak var textFieldTeacher: UITextField!
    @IBOutlet weak var textFieldCategory: UITextField!
    
    
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldSub: UITextField!
    
    @IBOutlet weak var textFieldComment: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateFormInput()
        // Do any additional setup after loading the view.
        textFieldTeacher.delegate = self
        textFieldCategory.delegate = self
        textFieldTitle.delegate = self
        textFieldSub.delegate = self
        textFieldComment.delegate = self
//        textFieldPoint.delegate = self
        
        
      
    }
    
    
    
//    @IBAction func submit(_ sender: Any) {
//        self.insertData()
//    }
    
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
}

