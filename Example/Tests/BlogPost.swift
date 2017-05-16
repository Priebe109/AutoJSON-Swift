//
//  BlogPost.swift
//  AutoJSON Swift
//
//  Created by Lasse Hammer Priebe on 16/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import AutoJSON

class BlogPost: AJSCompliantStandardObject {
    
    var author: BlogUser!
    var title: String?
    var content: String = ""
    var tags: [String] = []
    var comments: [BlogComment] = []
}
