//
//  UserDefaults+Extensions.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-21.
//

import Foundation

extension UserDefaults {
    func setValue<T: Codable>(_ value: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Unable to encode value. Error: \(error)")
        }
    }
    
    func getValue<T: Codable>(valueOfType type: T.Type, forKey key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            print("Unable to decode value. Error: \(error)")
            return nil
        }
    }
}
