//
//  Recording.swift
//  AudioComments
//
//  Created by Christy Hicks on 5/11/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import Foundation

class Recording {
    var title: String = "New Recording"
    var duration: Double = 0.0
    var url: URL?
    
    init(title: String, duration: Double, url: URL?) {
        self.title = title
        self.duration = duration
        self.url = url
    }
    
        init(title: String, duration: Double) {
        self.title = title
        self.duration = duration
    }
    
}


