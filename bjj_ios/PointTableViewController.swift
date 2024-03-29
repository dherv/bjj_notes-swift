//
//  PointTableViewController.swift
//  bjj_ios
//
//  Created by Damien Hervieux on 2019/09/23.
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


class PointTableViewController: UITableViewController, UITextFieldDelegate  {
    
    var list = [NoteItem]()
    var note_items = [NoteItem]()
    
    var data: Form = Form(teacher_id: 1, type: "", technique: "", position_id: 1, comment: "", class_date: "")
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DATA", data)
        saveButton.isEnabled = false
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        list.append(NoteItem(content: "", order_number: 1))
    }
    
    // MARK: - private functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        
            textField.resignFirstResponder()
               return true
     
    }
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
          saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
            // Disable the Save button while editing.
        
        
        
        // Update current
        self.list = self.list.enumerated().map {
            (index, element) in
            if(element.order_number == textField.tag) {
                var el = element
                el.content = textField.text!
                return el
            }
            return element
        }
        
        // Add one empty field
        // if current field tag is equal to count (tag starts at 1)
        if textField.tag == list.count && textField.text != "" {
          
            list.append(NoteItem(content: "", order_number: list.count + 1))
       
        } else {
            self.list = self.list.enumerated().map {
                (index, element) in
                if(element.order_number == textField.tag) {
                    var el = element
                    el.content = textField.text!
                    return el
                }
                return element
            }
        }
        saveButton.isEnabled = true
         self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pointTableCell", for: indexPath) as! PointTableViewCell
        
        // Configure the cell...
        // Add text field delegate to table cell
        cell.pointTableCell.delegate = self
       
        cell.pointTableNumber.text = String(list[indexPath.row].order_number)
        cell.pointTableCell.text = list[indexPath.row].content
        cell.pointTableCell.tag = indexPath.row + 1
       
        
        return cell
    }
    
    @IBAction func insert(_ sender: Any) {
        self.insertData()
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
      
         
        
        
    }
    
    // call to insert data before doing the exit segue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "exitPointSegue" {
            self.insertData()
            return true
        }
        return false
    }
    private func insertData() {
  
        
        // filter empty content
        let note_items = self.list.filter {return !$0.content.isEmpty}
        // map list to note_items
        
        
        let post_data = PostData(technique: data.technique, teacher_id: data.teacher_id, position_id: data.position_id, comment: data.comment, note_items: note_items, type: data.type, class_date: data.class_date)
        
        print("POST", post_data)
        Api.shared.post(path: "/notes", post_data: post_data) {(res) in
            switch res {
            case.failure(let err):
                print(err)
            case .success(let data):
                print(data)
            }
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }    
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
