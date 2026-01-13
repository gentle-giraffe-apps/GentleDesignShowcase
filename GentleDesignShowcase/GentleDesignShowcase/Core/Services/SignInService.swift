//  Jonathan Ritchey
import Foundation

protocol SignInServiceProtocol: Sendable {
    mutating func signIn(username: String, password: String) async throws
}

struct MockSignInService: SignInServiceProtocol {
    mutating func signIn(username: String, password: String) async throws {
    }
}
