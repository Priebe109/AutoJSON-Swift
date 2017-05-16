//
//  AJSSerializer.swift
//  AutoJSON Swift
//
//  Created by Lasse Hammer Priebe on 13/05/2017.
//  Copyright © 2017 Lasse Hammer Priebe. All rights reserved.
//

import Foundation

// MARK: - Public Serialization Interface

/// Serializes compliant objects or arrays into JSON data.
open class AJSSerializer {
    
    // MARK: - Configuration
    
    public var writingOptions: JSONSerialization.WritingOptions = .prettyPrinted

    // MARK: - Serialization
    
    public func serialize<T: AJSCompliantObject>(_ object: T) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: makeJSONCompatibleDictionary(from: object), options: writingOptions)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    public func serializeToString<T: AJSCompliantObject>(_ object: T) -> String? {
        if let data = serialize(object) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    public func serialize<T: AJSCompliantCollection>(_ collection: T) -> Data? {
        do {
            switch T.ajsCompliantPropertyType {
            case .collection(let propertyType):
                return try JSONSerialization.data(withJSONObject: makeJSONCompatibleArray(from: collection as? NSArray, ofType: propertyType), options: writingOptions)
            default:
                return nil
            }
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    public func serializeToString<T: AJSCompliantCollection>(_ collection: T) -> String? {
        if let data = serialize(collection) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

// MARK: - Internal Data Conversion

extension AJSSerializer {
    
    internal func makeJSONCompatiblePrimitive(from object: Any?, ofType type: AJSCompliantPrimitive.Type) -> Any {
        
        // Return NULL if the object is nil.
        guard let object = object else {
            return NSNull()
        }
        
        // Return the JSON compatible value using the appropriate type mapping.
        switch type {
        case is Bool.Type:
            return NSNumber(booleanLiteral: object as! Bool)
        case is Int.Type:
            return NSNumber(integerLiteral: object as! Int)
        case is Float.Type:
            fallthrough
        case is Double.Type:
            return NSNumber(floatLiteral: object as! Double)
        case is String.Type:
            return NSString(string: object as! String)
        default:
            break
        }
        
        return NSNull()
    }

    internal func makeJSONCompatibleDictionary(from object: AJSCompliantObject?) -> NSDictionary {
        
        let compatiableDictionary = NSMutableDictionary()
        
        // Return empty dictionary if the object is nil.
        guard let object = object else {
            return compatiableDictionary
        }
        
        // Iterate over all the properties.
        let properties = object.ajsCompliantProperties
        for property in properties {
            
            guard let key = property.name else { continue }
            
            switch property.type {
                
            case .primitive(let primitiveType):
                compatiableDictionary[key] = makeJSONCompatiblePrimitive(from: object.value(forKey: key), ofType: primitiveType)
                
            case .object(_):
                compatiableDictionary[key] = makeJSONCompatibleDictionary(from: object.value(forKey: key) as? AJSCompliantObject)
                
            case .collection(let collectionType):
                compatiableDictionary[key] = makeJSONCompatibleArray(from: object.value(forKey: key) as? NSArray, ofType: collectionType)
                
            case .optional(let propertyType):
                compatiableDictionary[key] = makeJSONCompatibleOptional(from: object.value(forKey: key), ofType: propertyType)
                
            default:
                break
            }
        }
        
        return compatiableDictionary
    }
    
    internal func makeJSONCompatibleArray(from array: NSArray?, ofType type: AJSCompliantPropertyType) -> NSArray {
        
        // Return empty array if the object is nil.
        guard let array = array else {
            return NSArray()
        }
        
        switch type {
            
        case .primitive(let primitiveType):
            return NSArray(array: array.map { makeJSONCompatiblePrimitive(from: $0, ofType: primitiveType) })
            
        case .object(_):
            return NSArray(array: array.map { makeJSONCompatibleDictionary(from: $0 as? AJSCompliantObject) })
        
        case .collection(let collectionType):
            return NSArray(array: array.map { makeJSONCompatibleArray(from: $0 as? NSArray, ofType: collectionType) })
            
        case .optional(let propertyType):
            return NSArray(array: array.map { makeJSONCompatibleOptional(from: $0, ofType: propertyType) })
            
        default:
            break
        }
        
        return NSArray()
    }
    
    internal func makeJSONCompatibleOptional(from object: Any?, ofType type: AJSCompliantPropertyType) -> Any {
        
        // Return NULL if the object is nil.
        guard let object = object else {
            return NSNull()
        }
        
        // Return the appropriate type mapping.
        switch type {
            
        case .primitive(let primitiveType):
            return makeJSONCompatiblePrimitive(from: object, ofType: primitiveType)
            
        case .object(_):
            return makeJSONCompatibleDictionary(from: object as? AJSCompliantObject)
            
        case .collection(let arrayType):
            return makeJSONCompatibleArray(from: object as? NSArray, ofType: arrayType)
            
        case .optional(let propertyType):
            return makeJSONCompatibleOptional(from: object, ofType: propertyType)
            
        default:
            break
        }
        
        return NSNull()
    }
}
