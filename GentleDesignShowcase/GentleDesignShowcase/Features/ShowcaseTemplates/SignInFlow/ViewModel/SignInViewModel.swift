//  Jonathan Ritchey
import Observation
import SwiftUI

@Observable
final class SignInViewModel {
    let title = "Login"
    let subtitle = "Don't have an account?   Sign up"
    let forgotPassword = "Forgot Password?"
    let backgroundImageName: String
    var username = ""
    var password = ""
    var service: SignInServiceProtocol
    
    init(
        service: SignInServiceProtocol = MockSignInService(),
        backgroundImageName: String = "",
        username: String = "",
        password: String = ""
    ) {
        self.service = service
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH" // 24 hours
//        if let hour = Int(formatter.string(from: date)) {
//            if hour > 3 && hour < 12 {
//                greeting = "Good Morning"
//                backgroundImageName = "SignInBackgroundMorning"
//            } else if hour >= 12 && hour < 18 {
//                greeting = "Good Afternoon"
//                backgroundImageName = "SignInBackgroundNoon"
//            } else {
//                greeting = "Good Evening"
//                backgroundImageName = "SignInBackgroundEvening"
//            }
//        } else {
//            greeting = "Welcome"
//            backgroundImageName = "SignInBackgroundMorning"
//        }
        self.backgroundImageName = ""
        self.username = username
        self.password = password
    }
    
    func signIn() async throws {
        try await service.signIn(username: username, password: password)
    }
}
