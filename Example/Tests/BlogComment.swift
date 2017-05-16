//
//  BlogComment.swift
//  AutoJSON Swift
//
//  Created by Lasse Hammer Priebe on 16/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import AutoJSON

class BlogComment: AJSCompliantStandardObject {
    
    var author: BlogUser!
    var content: String = ""
}
