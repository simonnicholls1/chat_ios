//
//  SubjectsModel.swift
//  chat-ios
//
//  Created by Simon on 05/03/2016.
//  Copyright © 2016 Lucky Egg Studios. All rights reserved.
//

import UIKit

class SubjectModel {
    // MARK: Properties
    
    var id: Int
    var name: String
    
    init?(id: Int, name: String) {
        // Initialize stored properties.
        self.id = id
        self.name = name
        
        //Subject must have a name
        if name.isEmpty {
            return nil
        }
    }
}


 