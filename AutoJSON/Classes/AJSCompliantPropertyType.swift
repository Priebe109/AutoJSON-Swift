//
//  AJSCompliantPropertyType.swift
//  AutoJSON Swift
//
//  Created by Lasse Hammer Priebe on 13/05/2017.
//  Copyright © 2017 Lasse Hammer Priebe. All rights reserved.
//

import Foundation

public indirect enum AJSCompliantPropertyType {
    
    /// Indicates the property is a compliant primitive, e.g. String or Int.
    case primitive(ofType: AJSCompliantPrimitive.Type)
    
    /// Indicates the property is a compliant object, that is, a class conforming to AJSCompliantObject.
    case object(ofType: AJSCompliantObject.Type)
    
    /// Indicates the property is a compliant collection, that is, a class conforming to AJSCompliantCollection.
    case collection(ofPropertyType: AJSCompliantPropertyType)
    
    /// Indicates the property is an optional. The wrapped type must contorm to AJSCompliant or will be ignored.
    case optional(ofPropertyType: AJSCompliantPropertyType)
    
    /// Indicates the property is ignored by AutoJSON.
    case ignored
}
