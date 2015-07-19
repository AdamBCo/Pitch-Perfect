//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Adam Cooper on 7/18/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(url: NSURL, title: String){
        self.filePathUrl = url
        self.title = title
    }
}
