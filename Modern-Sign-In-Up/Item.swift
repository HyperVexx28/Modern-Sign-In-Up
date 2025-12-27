// Sample SwiftData model used by the Xcode template; not currently tied into auth flows.
// Lives in the persistence/model layer and can be removed once no longer needed.

import Foundation
import SwiftData

/// Template data model storing a timestamp; retained from project scaffolding.
@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
