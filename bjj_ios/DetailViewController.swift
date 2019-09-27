//
//  DetailViewController.swift
//  bjj_ios
//
//  Created by Damien Hervieux on 2019/09/23.
//  Copyright © 2019 Damien Hervieux. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    var data = GetData(id: 33, technique: "test", teacher_name: "Masa", position_id: 1, type: "Attack", comment:  "", class_date: "9/25/2019", note_items: [])
    
    
    @IBOutlet weak var labelTeacher: UILabel!
    
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var labelClub: UILabel!
    
    @IBOutlet weak var labelTechnique: UILabel!
    
    @IBOutlet weak var labelPosition: UILabel!
    
    @IBOutlet weak var labelType: UILabel!
    
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBOutlet weak var detailInfoView: UIView!
    @IBOutlet weak var stackContainer: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("DATAAAAAAAA", data)
       
        detailTextView.textContainerInset = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        detailTextView.layer.cornerRadius = 4.0
        detailInfoView.layer.cornerRadius = 4.0
        setupText()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        labelTeacher.text = data.teacher_name
        labelDate.text = data.class_date
        labelTechnique.text = data.technique
        labelPosition.text = String(data.position_id)
        labelType.text = data.type
    }
    
    func setupText() {
        detailTextView.text = data.note_items.sorted(by: {$0.order_number < $1.order_number}).enumerated().map{(index, element) in
            return "\(element.order_number). \(element.content)"
        }.joined(separator: "\n")
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
