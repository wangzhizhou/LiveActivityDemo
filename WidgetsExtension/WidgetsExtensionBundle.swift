//
//  WidgetsExtensionBundle.swift
//  WidgetsExtension
//
//  Created by joker on 2023/11/9.
//

import WidgetKit
import SwiftUI

@main
@available(iOSApplicationExtension 16.1, *)
struct WidgetsExtensionBundle: WidgetBundle {
    var body: some Widget {
        WidgetsExtensionLiveActivity()
    }
}
