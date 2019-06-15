//
//  Group.swift
//  ShokshMedia
//
//  Created by Mahmoud Elshakoushy on 6/2/19.
//  Copyright © 2019 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation

class Group {
    private var _groupTitle: String
    private var _groupDescription: String
    private var _key: String
    private var _membersCount: Int
    private var _members: [String]
    
    var groupTitle: String {
        return _groupTitle
    }
    var groupDescription: String {
        return _groupDescription
    }
    var key: String {
        return _key
    }
    var membersCount: Int {
        return _membersCount
    }
    var members: [String] {
        return _members
    }
    
    init(title: String, description: String, key: String, membersCount: Int, members: [String]) {
        self._groupTitle = title
        self._groupDescription = description
        self._key = key
        self._membersCount = membersCount
        self._members = members
    }
}
