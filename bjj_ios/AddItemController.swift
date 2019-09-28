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

struct Form {
    var   teacher_id: Int
    var type: String
    var technique: String
    var position_id: Int
    var comment : String
    var class_date: String
    init(teacher_id: Int, type: String,
         technique: String,
         position_id: Int,
         comment : String, class_date: String ) {
        self.teacher_id = teacher_id
        self.type = type
        self.technique = technique
        self.position_id = position_id
        self.comment  = comment
        self.class_date = class_date
    }
}


class AddItemController: UIViewController, UITextFieldDelegate {
    
    var form_input = [FormInput]()
    var data = [Data]()
    
    var teacher_id = 1
    var type: Bool = true
    var technique = ""
    var position_id = 1
    var comment  = ""
    var class_date = ""
    
    
    @IBOutlet weak var textPositionId: UITextField!
    @IBOutlet weak var textFieldComment: UITextField!
    @IBOutlet weak var textClassDate: UITextField!
    @IBOutlet weak var textTechnique: UITextField!
    @IBOutlet weak var textTeacherId: UITextField!
    @IBOutlet weak var switchType: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textTeacherId.delegate = self
        textPositionId.delegate = self
        textTechnique.delegate = self
//        textClassDate.delegate = self
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - text delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//        print(textField)
////        self.teacher_id = Int(textTeacherId.text!)!
////        self.type = switchType.isOn
////        self.technique = textTechnique.text!
////        self.position_id = Int(textPositionId.text? "")
////        self.comment = textFieldComment.text!
//        self.view.endEditing(true)
//
//    }
    
    // MARK: - segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Need to pass through navigation controller to pass data
        let navVC = segue.destination as? UINavigationController
        
        let pointController = navVC?.viewControllers.first as! PointTableViewController
    
        
        let data = Form(teacher_id: Int(textTeacherId.text ?? "") ?? 1, type: switchType.isOn ? "Defense" : "Attack", technique: textTechnique.text ?? "", position_id: Int(textPositionId.text ?? "") ?? 1, comment: textFieldComment.text ?? "", class_date: textClassDate.text ?? "")
        print("Form", data)
        pointController.data = data
    }
}

