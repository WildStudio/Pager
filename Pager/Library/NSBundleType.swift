//
//  NSBundleType.swift
//  Pager
//
//  Created by Christian Aranda on 05/02/2019.
//  Copyright © 2019 We Are Mobile First. All rights reserved.
//

import Foundation

protocol NSBundleType {
    var bundleIdentifier: String? { get }
    var infoDictionary: [String: Any]? { get }
}

extension NSBundleType {
    var identifier: String {
        return infoDictionary?["CFBundleIdentifier"] as? String ?? "Unknown"
    }

    var shortVersionString: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }

    var version: String {
        return infoDictionary?["CFBundleVersion"] as? String ?? "0"
    }

    var executable: String? {
        return Bundle.main.infoDictionary?["CFBundleExecutable"] as? String
    }

    var app: String {
        return executable ?? bundleIdentifier ?? ""
    }
}

extension Bundle: NSBundleType {}

