//
//  CrowdInKeyManager.swift
//  FOLKFramework
//
//  Created by James Folk on 2/7/22.
//

public class CrowdInKeyManager {
    private var cache = [String: [String]]()
    
    public init(){}
    
    public func add(_ crowdinValue: String, _ crowdinKey: String) {
        let ary = cache[crowdinValue] ?? []
        
        //empty
        if ary == [] {
            cache[crowdinValue] = [crowdinKey]
        } else {
            
//            // duplicate kv
            if let _ = ary.first(where: { $0 == crowdinKey }) {
                // found a duplicate [crowdinValue, crowdinKey]

            //
            } else {
                cache[crowdinValue]!.append(crowdinKey)
            }
        }
    }
    
    public func get(_ crowdinValue: String)->[String] {
        return cache[crowdinValue] ?? []
    }
}
