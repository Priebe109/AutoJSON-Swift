//
//  AJSCompliantObject+Extensions.swift
//  AutoJSON Swift
//
//  Created by Lasse Hammer Priebe on 13/05/2017.
//  Copyright © 2017 Lasse Hammer Priebe. All rights reserved.
//

import Foundation

/// Subset of the informal NSKeyValueCoding protocol required by AutoJSON.
public protocol NSKeyValueCodingRequirementCompatible {

    func value(forKey key: String) -> Any?
    func value(forUndefinedKey key: String) -> Any?
    func setNilValueForKey(_ key: String)
    func setValue(_ value: Any?, forKey key: String)
}

/// Protocol implemented by objects to allow automatic serialization and deserialization by AutoJSON.
public protocol AJSCompliantObject: AJSCompliant, NSKeyValueCodingRequirementCompatible {
    
    /// Empty initializer required by AutoJSON to instantiate the object, before building.
    init()
    
    /// Returns a list of tuples containing names and the corresponding ajs types of the object's properties.
    var ajsCompliantProperties: [(name: String?, type: AJSCompliantPropertyType)] { get }
}

extension AJSCompliantObject {
    
    public static var ajsCompliantPropertyType: AJSCompliantPropertyType {
        return .object(ofType: self)
    }
    
    public var ajsCompliantProperties: [(name: String?, type: AJSCompliantPropertyType)] {
        
        var mirror: Mirror? = Mirror(reflecting: self)
        var children: [Mirror.Child] = []
        
        // Get the mirrored children of all superclasses that are compliant.
        while mirror != nil && mirror!.subjectType is AJSCompliant.Type {
            children.append(contentsOf: mirror!.children)
            mirror = mirror?.superclassMirror
        }
        
        // Filter to obtain only the compliant properties.
        let ajsCompliantChildren = children.filter { $0.value is AJSCompliant }
        
        // Map the names and types to an array of tuples.
        return ajsCompliantChildren.flatMap {
            ($0.label, type(of: ($0.value as! AJSCompliant)).ajsCompliantPropertyType)
        }
    }
}
