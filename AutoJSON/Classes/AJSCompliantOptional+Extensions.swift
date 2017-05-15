//
//  AJSCompliantOptional+Extensions.swift
//  AutoJSON Swift
//
//  Created by Lasse Hammer Priebe on 13/05/2017.
//  Copyright © 2017 Lasse Hammer Priebe. All rights reserved.
//

import Foundation

extension Optional: AJSCompliant {
    
    static var ajsCompliantPropertyType: AJSCompliantPropertyType {
        
        if let type = Wrapped.self as? AJSCompliant.Type {
            return .optional(ofPropertyType: type.ajsCompliantPropertyType)
        }
        
        return .ignored
    }
}

extension ImplicitlyUnwrappedOptional: AJSCompliant {
    
    static var ajsCompliantPropertyType: AJSCompliantPropertyType {
        
        if let type = Wrapped.self as? AJSCompliant.Type {
            return .optional(ofPropertyType: type.ajsCompliantPropertyType)
        }
        
        return .ignored
    }
}
