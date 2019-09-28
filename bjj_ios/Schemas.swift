//
//  Schemas.swift
//  bjj_ios
//
//  Created by Damien Hervieux on 2019/09/16.
//  Copyright © 2019 Damien Hervieux. All rights reserved.
//

import Foundation

struct NoteItem: Codable {
    var content: String
    var order_number: Int
    init(content:String, order_number: Int) {
        self.content = content
        self.order_number = order_number
    }
}

struct PostData: Codable {
    
    var technique: String
    var teacher_id: Int
    var position_id: Int
    
    var comment: String
    var note_items: [NoteItem]
    var type: String
    var class_date: String
    
    init(   technique: String,
            teacher_id: Int,
            position_id: Int,
            
            comment: String,
            note_items: [NoteItem], type: String, class_date: String) {
        self.technique = technique
        self.teacher_id = teacher_id
        self.position_id = position_id
        
        self.comment = comment
        self.note_items = note_items
        self.type = type
        self.class_date = class_date
    }
}


struct GetData: Decodable {
    var id: Int
    var technique: String
    var teacher_id: Int?
    var teacher_name: String
    var position_id: Int?
    var position_name: String
    var type: String
    var comment: String?
    var class_date: String
    var note_items: [NoteItem]
    
    init(
        id: Int,
        technique: String,
        teacher_id: Int,
        teacher_name: String,
        position_id: Int,
        position_name: String,
        type: String,
        comment: String,
        class_date: String,
        note_items: [NoteItem]
        ) {
        self.id = id
        self.technique = technique
        self.teacher_id = teacher_id
        self.teacher_name = teacher_name
        self.position_id = position_id
        self.position_name = position_name.capitalized
        self.type = type
        self.comment = comment
        self.class_date = class_date
        self.note_items = note_items    }
    
}


