//
//  Schemas.swift
//  bjj_ios
//
//  Created by Damien Hervieux on 2019/09/16.
//  Copyright © 2019 Damien Hervieux. All rights reserved.
//

import Foundation


struct PostData: Codable {
    
    var title: String
    var teacher: String
    var category: String
    var sub_category: String
    var comment: String
    var items: [TextFieldPoint]
    
    init(   title: String,
            teacher: String,
            category: String,
            sub_category: String,
            comment: String,
            items: [TextFieldPoint]) {
        self.title = title
        self.teacher = teacher
        self.category = category
        self.sub_category = sub_category
        self.comment = comment
        self.items = items
    }
}

struct NoteItem: Decodable {
    var name: String
    init(name: String) {
        self.name = name
    }
    
}

struct GetData: Decodable {
    var id: Int
    var technique: String
    var teacher_name: String
    var position_id: Int
    var type: String
    var comment: String?
    var class_date: String
    var note_items: [NoteItem]
    
    init(
        id: Int,
        technique: String,
        teacher_name: String,
        position_id: Int,
        type: String,
        comment: String,
        class_date: String,
        note_items: [NoteItem]
        ) {
        self.id = id
        self.technique = technique
        self.teacher_name = teacher_name
        self.position_id = position_id
        self.type = type
        self.comment = comment
        self.class_date = class_date
        self.note_items = note_items    }
    
}


