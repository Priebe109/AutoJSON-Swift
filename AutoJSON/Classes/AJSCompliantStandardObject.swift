//
//  AJSCompliantStandardObject.swift
//  AutoJSON Swift
//
//  Created by Lasse Hammer Priebe on 15/05/2017.
//  Copyright © 2017 Lasse Hammer Priebe. All rights reserved.
//

import Foundation

class AJSCompliantStandardObject: NSObject, AJSCompliantObject {
    
    override init() {
        super.init()
    }
    
    required init(withContext context: AJSSerializationContext) {
        super.init()
    }
}
