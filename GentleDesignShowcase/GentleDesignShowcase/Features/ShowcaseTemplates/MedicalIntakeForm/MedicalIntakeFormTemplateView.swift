//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

struct MedicalIntakeFormTemplateView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var birthDate = Date()
    @State private var hasAllergies = false
    @State private var notes = ""
    @State private var showSubmitted = false

    var body: some View {
        Form {
            Section("Patient") {
                TextField("Full name", text: $fullName)
                    .gentleTextField(.body_m)
                TextField("Email", text: $email)
                    .gentleTextField(.body_m)
                    .textInputAutocapitalization(.never)
                DatePicker("Birth date", selection: $birthDate, displayedComponents: .date)
            }

            Section("Health") {
                Toggle("Any allergies?", isOn: $hasAllergies)
                TextField("Notes", text: $notes, axis: .vertical)
                    .gentleTextField(.body_m)
                    .lineLimit(3...6)
            }

            Section {
                Button("Submit") { showSubmitted = true }
                    .gentleButton(.primary)
            }
        }
        .navigationTitle("Medical Intake")
        .alert("Submitted", isPresented: $showSubmitted) {
            Button("OK", role: .cancel) {}
                .gentleButton(.secondary)
        }
    }
}
