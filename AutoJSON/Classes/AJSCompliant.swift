//
//  AJECompliant.swift
//  AutoJSON Swift
//
//  Created by Lasse Hammer Priebe on 13/05/2017.
//  Copyright © 2017 Lasse Hammer Priebe. All rights reserved.
//

import Foundation

/// The base protocol for compatability with AutoJSON.
public protocol AJSCompliant {
    
    /// Returns the type's property type as specified by AutoJSON.
    static var ajsCompliantPropertyType: AJSCompliantPropertyType { get }
}
