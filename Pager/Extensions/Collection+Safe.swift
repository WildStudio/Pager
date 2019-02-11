//  Copyright © 2019 We Are Mobile First. All rights reserved.

import Foundation

extension Collection {

    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
