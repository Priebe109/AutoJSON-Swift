//
//  AutoJSON.swift
//  AutoJSON Swift
//
//  Created by Lasse Hammer Priebe on 16/05/2017.
//
//

import Foundation

/// Conveniece class for interfacing with AutoJSON.
open class AutoJSON {
    
    public static let `default` = AutoJSON()
    
    // MARK: - Configuration
    
    public var serializer = AJSSerializer()
    
    public var deserializer = AJSDeserializer()
    
    // MARK: - Serialization
    
    public func serialize<T: AJSCompliantObject>(_ object: T) -> Data? {
        return serializer.serialize(object)
    }
    
    public func serializeToString<T: AJSCompliantObject>(_ object: T) -> String? {
        return serializer.serializeToString(object)
    }
    
    public func serialize<T: AJSCompliantCollection>(_ collection: T) -> Data? {
        return serializer.serialize(collection)
    }
    
    public func serializeToString<T: AJSCompliantCollection>(_ collection: T) -> String? {
        return serializer.serializeToString(collection)
    }
    
    // MARK: - Deserialization
    
    public func deserialize<T: AJSCompliantObject>(_ data: Data) -> T? {
        return deserializer.deserialize(data)
    }
    
    public func deserializeFromString<T: AJSCompliantObject>(_ jsonString: String) -> T? {
        return deserializer.deserializeFromString(jsonString)
    }
    
    public func deserialize<T: AJSCompliantCollection>(_ data: Data) -> [T]? {
        return deserializer.deserialize(data)
    }
    
    public func deserializeFromString<T: AJSCompliantCollection>(_ jsonString: String) -> [T]? {
        return deserializer.deserializeFromString(jsonString)
    }
}
