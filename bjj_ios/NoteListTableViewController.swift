//
//  NoteListTableViewController.swift
//  bjj_ios
//
//  Created by Damien Hervieux on 2019/09/10.
//  Copyright © 2019 Damien Hervieux. All rights reserved.
//

import UIKit

class NoteListTableViewController: UITableViewController {
    
    
    //MARK: Interface Builder
    
    //MARK: variables
    var notes = [GetData]()
    var current_note = GetData(id: 1, technique: "", teacher_name: "", position_id: 1, type: "Attack", comment: "", class_date: "", note_items: [])

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotes()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(notes.count)
        return notes.count
    }
    
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NoteListCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NoteListTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let current_note = notes[indexPath.row]
        print("note", current_note)
        cell.noteTeachLabel.text
            = current_note.teacher_name
        cell.noteDateLabel.text = current_note.class_date
        cell.noteTypeLabel.text = current_note.type
        cell.noteTechniqueLabel.text = String(current_note.technique)
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
    
    
    //MARK: private
    
    private func loadNotes() {
        Api.shared.get(path: "/notes") {(res) in
            switch res {
            case .failure(let err):
                print("err", err)
            case .success(let data):
                print("data", data)
                self.notes = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.current_note = self.notes[indexPath.row]
    
//        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
       
        
        if segue.identifier == "showDetails" {
             print(segue.destination)
            let navVc = segue.destination as? UINavigationController
            let detailController = navVc?.viewControllers.first as! DetailViewController
      
            
            detailController.data = self.current_note
            
        }

    }
    
}
