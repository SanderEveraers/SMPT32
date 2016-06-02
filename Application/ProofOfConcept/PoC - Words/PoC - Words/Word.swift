//
//  Word.swift
//  PoC - Words
//
//  Created by Fhict on 27/05/16.
//  Copyright © 2016 Fhict. All rights reserved.
//

import Foundation

class Word
{
    var woord:String
    var antwoord:String
    
    init(woord:String, antwoord:String){
        self.woord = woord
        self.antwoord = antwoord
    }
    
    func getWoord() -> String {
        return self.woord
    }
    
    func getAntwoord() -> String {
        return self.antwoord
    }
    
}