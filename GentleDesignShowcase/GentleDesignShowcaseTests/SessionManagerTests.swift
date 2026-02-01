import Foundation
import Testing
@testable import GentleDesignShowcase

// Mock service that returns a token (simulates signed in state)
struct MockSignedInAuthService: SessionManagerAuthServiceProtocol {
    func loadAccessToken() async throws -> String? {
        return "mock-token-123"
    }
    func deleteAccessToken() async throws {}
}

// Mock service that returns nil (simulates signed out state)
struct MockSignedOutAuthService: SessionManagerAuthServiceProtocol {
    func loadAccessToken() async throws -> String? {
        return nil
    }
    func deleteAccessToken() async throws {}
}

// Mock service that throws an error
struct MockErrorAuthService: SessionManagerAuthServiceProtocol {
    func loadAccessToken() async throws -> String? {
        throw NSError(domain: "test", code: 1)
    }
    func deleteAccessToken() async throws {
        throw NSError(domain: "test", code: 2)
    }
}

@Suite("SessionManager Tests")
struct SessionManagerTests {

    @MainActor
    @Test("Initial state is loading")
    func initialStateIsLoading() {
        let manager = SessionManager(service: SessionManagerMockAuthService())
        #expect(manager.state == .loading)
    }

    @MainActor
    @Test("signIn transitions to signedIn when token exists")
    func signInWithTokenBecomesSignedIn() async {
        let manager = SessionManager(service: MockSignedInAuthService())
        await manager.signIn()
        #expect(manager.state == .signedIn)
    }

    @MainActor
    @Test("signIn transitions to signedOut when no token")
    func signInWithoutTokenBecomesSignedOut() async {
        let manager = SessionManager(service: MockSignedOutAuthService())
        await manager.signIn()
        #expect(manager.state == .signedOut)
    }

    @MainActor
    @Test("signIn transitions to signedOut on error")
    func signInWithErrorBecomesSignedOut() async {
        let manager = SessionManager(service: MockErrorAuthService())
        await manager.signIn()
        #expect(manager.state == .signedOut)
    }

    @MainActor
    @Test("signInSucceeded sets state to signedIn")
    func signInSucceededSetsSignedIn() {
        let manager = SessionManager(service: SessionManagerMockAuthService())
        manager.signInSucceeded()
        #expect(manager.state == .signedIn)
    }

    @MainActor
    @Test("signOut transitions to signedOut")
    func signOutBecomesSignedOut() async {
        let manager = SessionManager(service: MockSignedInAuthService())
        await manager.signIn()
        #expect(manager.state == .signedIn)
        await manager.signOut()
        #expect(manager.state == .signedOut)
    }

    @MainActor
    @Test("signOut handles service error gracefully")
    func signOutHandlesError() async {
        let manager = SessionManager(service: MockErrorAuthService())
        manager.signInSucceeded()
        await manager.signOut()
        #expect(manager.state == .signedOut)
    }

    @MainActor
    @Test("preview factory creates valid manager")
    func previewFactoryWorks() {
        let manager = SessionManager.preview
        #expect(manager.state == .loading)
    }

    @MainActor
    @Test("State enum cases are distinct")
    func stateEnumCases() {
        let loading = SessionManager.State.loading
        let signedIn = SessionManager.State.signedIn
        let signedOut = SessionManager.State.signedOut
        #expect(loading != signedIn)
        #expect(loading != signedOut)
        #expect(signedIn != signedOut)
    }
}
