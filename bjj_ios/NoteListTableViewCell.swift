//
//  NoteListTableViewCell.swift
//  bjj_ios
//
//  Created by Damien Hervieux on 2019/09/10.
//  Copyright © 2019 Damien Hervieux. All rights reserved.
//

import UIKit

class NoteListTableViewCell: UITableViewCell {

    //MARK: Interface Builder
    
    @IBOutlet weak var noteTeachLabel: UILabel!
    @IBOutlet weak var noteDateLabel: UILabel!
    @IBOutlet weak var noteTechniqueLabel: UILabel!
    @IBOutlet weak var noteTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
