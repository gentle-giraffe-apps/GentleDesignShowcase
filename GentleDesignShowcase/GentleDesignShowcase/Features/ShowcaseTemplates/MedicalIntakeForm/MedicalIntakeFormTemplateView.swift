//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

struct MedicalIntakeFormTemplateView: View {
    @FocusState private var focusedField: Field?
    @State private var fullName = ""
    @State private var email = ""
    @State private var birthDate = Date()
    @State private var hasAllergies = false
    @State private var notes = ""
    @State private var showSubmitted = false
    @GentleDesignRuntime private var gentleDesign

    enum Field {
        case fullname
        case email
        case birthdate
        case hasAllergies
        case notes
    }

    var body: some View {
        ZStack {
            // Decorative background gradient
            diagonalGradient()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Patient Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Patient")
                            .gentleText(.headline_m)

                        HStack(spacing: 12) {
                            Image(systemName: "person")
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                            TextField("Full name", text: $fullName)
                        }
                        .gentleTextField(.body_m, chrome: .standalone(shape: .pill))
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .focused($focusedField, equals: .fullname)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .email }
                        
                        HStack(spacing: 12) {
                            Image(systemName: "envelope")
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                            TextField("Email", text: $email)
                        }
                            .gentleTextField(.body_m, chrome: .standalone(shape: .pill))
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .focused($focusedField, equals: .email)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .birthdate }

                        DatePicker("Birth date", selection: $birthDate, displayedComponents: .date)
                            .focused($focusedField, equals: .birthdate)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .hasAllergies }

                    }

                    Divider()
                        .opacity(0.25)

                    // Health Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Health")
                            .gentleText(.headline_m)

                        Toggle("Any allergies?", isOn: $hasAllergies)

                        TextField("Notes", text: $notes, prompt: Text("Additional health information"), axis: .vertical)
                            .gentleTextField(.body_m, chrome: .standalone(shape: .rounded))
                            .lineLimit(3...6)
                    }

                    Divider()
                        .opacity(0.25)

                    // Submit Button
                    Button("Submit") { showSubmitted = true }
                        .gentleButton(.primary, shape: .pill)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .gentleInset(.screen)
            }
        }
        .gentleSurface(.appBackground)
        .navigationTitle("Medical Intake")
        .alert("Submitted", isPresented: $showSubmitted) {
            Button("OK", role: .cancel) {}
        }
    }

    private func diagonalGradient() -> some View {
        LinearGradient(
            colors: [gentleDesign.themePrimary.opacity(0.1), Color.clear],
            startPoint: .topLeading,
            endPoint: .center
        )
        .ignoresSafeArea()
    }
}
