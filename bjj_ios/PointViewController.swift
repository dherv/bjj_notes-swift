//
//  PointViewController.swift
//  bjj_ios
//
//  Created by Damien Hervieux on 2019/09/22.
//  Copyright © 2019 Damien Hervieux. All rights reserved.
//

import UIKit

struct TextFieldPoint: Codable {
    var number: Int
    var content: String
    init(number: Int, content: String) {
        self.content = content
        self.number = number
    }
}


class PointViewController: UIViewController, UITextFieldDelegate {

   
    
  
    @IBOutlet weak var stackPoint: UIStackView!
    @IBOutlet weak var pointNumber: UILabel!
    @IBOutlet weak var textFieldPoint: UITextField!
    var list = [TextFieldPoint]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        textFieldPoint.delegate = self
        
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
