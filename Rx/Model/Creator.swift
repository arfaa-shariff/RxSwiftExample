//
//  Creator.swift
//  Rx
//
//  Created by Arfaa Nisar Shariff on 17/10/17.
//  Copyright © 2017 Arfaa Nisar Shariff. All rights reserved.
//

import Foundation
import ObjectMapper

public class Creator: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let username = "username"
        static let password = "password"
        static let provider = "provider"
        static let displayName = "displayName"
        
    }
    
    // MARK: Properties
    public var username: String?
    public var password: String?
    public var provider: String?
    public var displayName: String?
    
    static var creatorDetails = Creator()
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){
        
    }
    
    public required init?(){
        
    }
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    
    public func mapping(map: Map) {
        username <- map[SerializationKeys.username]
        password <- map[SerializationKeys.password]
        provider <- map[SerializationKeys.provider]
        displayName <- map[SerializationKeys.displayName]
        
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = username { dictionary[SerializationKeys.username] = value }
        if let value = password { dictionary[SerializationKeys.password] = value }
        if let value = provider { dictionary[SerializationKeys.provider] = value }
        if let value = displayName { dictionary[SerializationKeys.displayName] = value }
        return dictionary
    }
    
}
