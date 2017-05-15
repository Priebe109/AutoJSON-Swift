//
//  AJSCompliantPrimitive+Extensions.swift
//  AutoJSON Swift
//
//  Created by Lasse Hammer Priebe on 13/05/2017.
//  Copyright © 2017 Lasse Hammer Priebe. All rights reserved.
//

import Foundation

protocol AJSCompliantPrimitive: AJSCompliant { }

extension Bool: AJSCompliantPrimitive { }
extension Int: AJSCompliantPrimitive { }
extension Float: AJSCompliantPrimitive { }
extension Double: AJSCompliantPrimitive { }
extension String: AJSCompliantPrimitive { }

extension AJSCompliantPrimitive {
    
    static var ajsCompliantPropertyType: AJSCompliantPropertyType {
        
        return .primitive(ofType: self)
    }
}
