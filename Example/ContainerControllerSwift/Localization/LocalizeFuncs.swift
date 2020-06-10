//
//  LocalizeFuncs.swift
//  KeyGroupFramework
//
//  Created by Nikita Bondar on 22/11/2018.
//  Copyright © 2018 KeyGroup. All rights reserved.
//

public func _L(_ key: String) -> String {
    return LocalizationManager.localizedString(key)
}

public func _LF(_ key: String, _ values: String...) -> String {
    return LocalizationManager.format(key: key, values: values)
}

public func _LC(_ key: String, _ count: Int) -> String {
    return _LC(key, Float(count))
}

public func _LC(_ key: String, _ count: Float) -> String {
    return LocalizationManager.localizedString(forCount: count, key: key)
}
