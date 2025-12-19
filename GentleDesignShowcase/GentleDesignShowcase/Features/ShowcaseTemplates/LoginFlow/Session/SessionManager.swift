//  Jonathan Ritchey

import Observation

protocol SessionManagerAuthServiceProtocol {
    func loadAccessToken() async throws -> String?
    func deleteAccessToken() async throws
}

struct SessionManagerMockAuthService: SessionManagerAuthServiceProtocol {
    func loadAccessToken() async throws -> String? {
        return nil
    }
    
    func deleteAccessToken() async throws {
    }
}

@MainActor
@Observable
final class SessionManager {
    enum State {
        case loading
        case signedOut
        case signedIn
    }

    var state: State = .loading
    let service: SessionManagerAuthServiceProtocol

    init(service: SessionManagerAuthServiceProtocol) {
        self.service = service
    }

    func signIn() async {
        do {
            if let _ = try await service.loadAccessToken() {
                state = .signedIn
            } else {
                state = .signedOut
            }
        } catch {
            // error
            state = .signedOut
        }
    }
    
    func signInSucceeded() {
        state = .signedIn
    }

    func signOut() async {
        do {
            try await service.deleteAccessToken()
        } catch {
            print("signOut failed: \(error)")
        }
        state = .signedOut
    }
    
    static var preview: SessionManager {
        SessionManager(service: SessionManagerMockAuthService())
    }
}
