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
    var id:Int
    var question:String
    var answer:String
    var sentence:String
    var count:Int
    
    init(id:Int, question:String, answer:String, sentence:String, count:Int){
        self.id = id
        self.question = question
        self.answer = answer
        self.sentence = sentence
        self.count = count
    }
    
    func getID() -> Int {
        return self.id
    }
    
    func getQuestion() -> String {
        return self.question
    }
    
    func getAnswer() -> String {
        return self.answer.lowercaseString
    }
    
    func getSentence() -> String {
        return self.sentence
    }
    
    func getCount() -> Int {
        return self.count
    }
    
    func setCount() {
        self.count = count+1
    }
    
}