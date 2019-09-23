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
    
    var list = [TextFieldPoint]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        list.append(TextFieldPoint(number: 1, content: ""))
    }
    
    // MARK: - private functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        // Update current
        self.list = self.list.enumerated().map {
            (index, element) in
            if(element.number == textField.tag) {
                var el = element
                el.content = textField.text!
                return el
            }
            return element
        }
        
        // Add one empty field
        if textField.tag == list.count && textField.text != "" {
          
            list.append(TextFieldPoint(number: list.count + 1, content: ""))
       
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
        
        cell.pointTableCell.delegate = self
       
        cell.pointTableNumber.text = String(list[indexPath.row].number)
        cell.pointTableCell.text = list[indexPath.row].content
        cell.pointTableCell.tag = indexPath.row + 1
       
        
        return cell
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
