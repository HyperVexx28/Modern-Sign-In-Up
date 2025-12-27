// User domain model used across authentication and profile flows.
// Lives in the shared model layer for decoding/encoding with Firestore.

import Foundation

/// Represents a user account persisted in Firebase Auth and mirrored in Firestore.
struct User: Identifiable, Codable{
    let id: String
    let fullName: String
    let email: String
    
    /// Abbreviated initials derived from the user's full name for avatar placeholders.
    var initials: String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
    
    }
/// Convenience static for previews and tests.
extension User{
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Kobe Bryant", email: "test@gmail.com")
}
