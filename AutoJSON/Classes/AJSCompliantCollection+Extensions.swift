//
//  AJSCompliantCollection+Extensions.swift
//  AutoJSON Swift
//
//  Created by Lasse Hammer Priebe on 13/05/2017.
//  Copyright © 2017 Lasse Hammer Priebe. All rights reserved.
//

import Foundation

protocol AJSCompliantCollection: AJSCompliant, Collection { }

extension Array: AJSCompliantCollection { }

extension AJSCompliantCollection {
    
    static var ajsCompliantPropertyType: AJSCompliantPropertyType {
        
        if let type = Iterator.Element.self as? AJSCompliant.Type {
            return .collection(ofPropertyType: type.ajsCompliantPropertyType)
        }
        
        return .ignored
    }
}
