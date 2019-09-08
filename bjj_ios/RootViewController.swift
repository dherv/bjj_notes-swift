//
//  RootViewController.swift
//  bjj_ios
//
//  Created by Damien Hervieux on 2019/09/08.
//  Copyright © 2019 Damien Hervieux. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var notes = [GetData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotes()
        // Do any additional setup after loading the view.
    }
    

    private func loadNotes() {
        Api.shared.get(path: "/notes") {(res) in
            switch res {
            case .failure(let err):
                print(err)
            case .success(let data):
                print(data)
//                self.notes = data
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
