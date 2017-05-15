//
//  AJSDeserializer.swift
//  AutoJSON Swift
//
//  Created by Lasse Hammer Priebe on 15/05/2017.
//  Copyright © 2017 Lasse Hammer Priebe. All rights reserved.
//

import Foundation

// MARK: - Public Deserialization Interface

/// Deserializes JSON data into compliant objects or arrays.
class AJSDeserializer {
    
    static let `default` = AJSDeserializer()
    
    var readingOptions: JSONSerialization.ReadingOptions = .allowFragments

    func deserialize<T: AJSCompliantObject>(_ data: Data) -> T? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: readingOptions)
            guard let jsonDictionary = jsonObject as? [String : Any] else {
                return nil
            }
            return makeObject(from: jsonDictionary, ofType: T.self) as? T
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func deserializeFromString<T: AJSCompliantObject>(_ jsonString: String) -> T? {
        if let data = jsonString.data(using: .utf8) {
            return deserialize(data)
        }
        return nil
    }
    
    func deserialize<T: AJSCompliantCollection>(_ data: Data) -> [T]? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: readingOptions)
            guard let jsonArray = jsonObject as? NSArray else {
                return nil
            }
            return makeCollection(from: jsonArray, ofType: T.ajsCompliantPropertyType) as? [T]
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func deserializeFromString<T: AJSCompliantCollection>(_ jsonString: String) -> [T]? {
        if let data = jsonString.data(using: .utf8) {
            return deserialize(data)
        }
        return nil
    }
}

// MARK: - Internal Data Conversion

extension AJSDeserializer {

    internal func makePrimitive(from value: Any, ofType type: AJSCompliantPrimitive.Type) -> Any? {
        
        switch type {
        case is Bool.Type:
            return value as? Bool
        case is Int.Type:
            return value as? Int
        case is Float.Type:
            return value as? Float
        case is Double.Type:
            return value as? Double
        case is String.Type:
            return value as? String
        default:
            return nil
        }
    }
    
    internal func makeObject(from dictionary: [String : Any], ofType type: AJSCompliantObject.Type) -> AJSCompliantObject {
        
        // Create a new instance of the type.
        let context = AJSSerializationContext()
        let compliantObject = type.init(withContext: context)
        
        // Iterate over the ajs properties to move data to the object.
        let properties = compliantObject.ajsCompliantProperties
        for property in properties {
            
            guard let key = property.name else { continue }
            
            // Switch based on the type of the property.
            switch property.type {
                
            case .primitive(let primitiveType):
                
                guard let rawValue = dictionary[key] else { continue }
                guard let primitive = makePrimitive(from: rawValue, ofType: primitiveType) else { continue }
                compliantObject.setValue(primitive, forKey: key)
                
            case .object(let objectType):
                
                guard let rawValue = dictionary[key] as? [String : Any] else { continue }
                compliantObject.setValue(makeObject(from: rawValue, ofType: objectType), forKey: key)
                
            case .collection(let collectionType):
                
                guard let rawValue = dictionary[key] as? NSArray else { continue }
                compliantObject.setValue(makeCollection(from: rawValue, ofType: collectionType), forKey: key)
                
            case .optional(let propertyType):
                
                compliantObject.setValue(makeOptional(from: dictionary[key], ofType: propertyType), forKey: key)
                
            default:
                break
            }
        }
        
        return compliantObject
    }
    
    internal func makeCollection(from array: NSArray, ofType type: AJSCompliantPropertyType) -> [AJSCompliant] {
        
        switch type {
            
        case .primitive(let primitiveType):
            return array.map { makePrimitive(from: $0, ofType: primitiveType) }
            
        case .object(let objectType):
            return array.filter { $0 is [String : Any] }
                        .map { makeObject(from: $0 as! [String : Any], ofType: objectType) }
            
        case .collection(let arrayType):
            return array.filter { $0 is NSArray }
                        .map { makeCollection(from: $0 as! NSArray, ofType: arrayType) }
            
        case .optional(let propertyType):
            return array.map { makeOptional(from: $0, ofType: propertyType) }
            
        default:
            break
        }
        
        return []
    }
    
    internal func makeOptional(from value: Any?, ofType type: AJSCompliantPropertyType) -> Any? {
        
        // Return nil if the object is nil.
        guard let value = value else {
            return nil
        }
        
        // Return the appropriate type mapping.
        switch type {
            
        case .primitive(let primitiveType):
            return makePrimitive(from: value, ofType: primitiveType)
        
        case .object(let objectType):
            guard let dictionary = value as? [String : Any] else { return nil }
            return makeObject(from: dictionary, ofType: objectType)
            
        case .collection(let collectionType):
            guard let array = value as? NSArray else { return nil }
            return makeCollection(from: array, ofType: collectionType)
            
        case .optional(let propertyType):
            return makeOptional(from: value, ofType: propertyType)
        
        default:
             return nil
        }
    }
}
