//
//  WidgetsExtensionAttributes.swift
//  WidgetsExtension
//
//  Created by joker on 2023/11/9.
//

import ActivityKit

struct WidgetsExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }
    
    // Fixed non-changing properties about your activity go here!
    var name: String
}

extension WidgetsExtensionAttributes {
    static var preview: WidgetsExtensionAttributes {
        WidgetsExtensionAttributes(name: "World")
    }
}

extension WidgetsExtensionAttributes.ContentState {
    static var smiley: WidgetsExtensionAttributes.ContentState {
        WidgetsExtensionAttributes.ContentState(emoji: "😀")
    }
    
    static var starEyes: WidgetsExtensionAttributes.ContentState {
        WidgetsExtensionAttributes.ContentState(emoji: "🤩")
    }
}
