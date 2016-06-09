//
//  Pupil.swift
//  LoginTrial
//
//  Created by Fhict on 02-06-16.
//  Copyright © 2016 Fontys. All rights reserved.
//

import Foundation

class Pupil
{
    var id: Int
    var userName: String
    var passWord: String
    var lastLoggedIn: NSDate
    
    init(id: Int, userName: String, passWord: String, lastLoggedIn: NSDate){
        self.id = id
        self.userName = userName
        self.passWord = passWord
        self.lastLoggedIn = lastLoggedIn
    }
}