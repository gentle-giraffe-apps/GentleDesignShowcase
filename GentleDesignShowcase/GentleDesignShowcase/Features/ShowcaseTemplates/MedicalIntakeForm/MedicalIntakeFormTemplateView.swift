//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

struct MedicalIntakeFormTemplateView: View {
    @FocusState private var focusedField: Field?
    @State private var fullName = ""
    @State private var email = ""
    @State private var birthDate = Date()
    @State private var hasAllergies = false
    @State private var additionalInfo = ""
    @State private var showSubmitted = false
    @GentleDesignRuntime private var gentleDesign

    enum Field {
        case fullname
        case email
        case birthdate
        case hasAllergies
        case additionalInfo
    }

    var body: some View {
        ZStack {
            diagonalGradient()

            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    // PATIENT Section
                    sectionHeader("PATIENT")

                    formCard {
//                        // Full name field
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Full name")
//                                .gentleText(.caption_s)
//                                .foregroundStyle(.secondary)
//                            HStack(spacing: 12) {
//                                Image(systemName: "person")
//                                    .fontWeight(.bold)
//                                    .foregroundStyle(.secondary)
//                                TextField("Enter your full name", text: $fullName)
//                                    .gentleText(.body_m)
//                            }
//                        }
//                        .padding(.vertical, 4)
//
//                        Divider()
//
//                        // Email field
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Email")
//                                .gentleText(.caption_s)
//                                .foregroundStyle(.secondary)
//                            HStack(spacing: 12) {
//                                Image(systemName: "envelope")
//                                    .fontWeight(.bold)
//                                    .foregroundStyle(.secondary)
//                                TextField(
//                                    "Enter your email address",
//                                    text: $email //,
//                                    // prompt: Text("Enter your email address"),
////                                    prompt: Text("email@example.com").foregroundStyle(.tertiary)
//                                )
//                                .gentleText(.body_m)
//                                .keyboardType(.emailAddress)
//                                .textContentType(.emailAddress)
//                                .textInputAutocapitalization(.never)
//                                .autocorrectionDisabled(true)
//                                .focused($focusedField, equals: .email)
//                            }
//                        }
//                        .padding(.vertical, 4)
//
//                        Divider()
//
//                        // Birth date field
//                        HStack {
//                            VStack(alignment: .leading, spacing: 4) {
//                                Text("Birth date")
//                                    .gentleText(.caption_s)
//                                    .foregroundStyle(.secondary)
//                                Text("Select date")
//                                    .gentleText(.body_m)
//                                    .foregroundStyle(.tertiary)
//                            }
//                            Spacer()
//                            DatePicker("", selection: $birthDate, displayedComponents: .date)
//                                .labelsHidden()
//                                .datePickerStyle(.compact)
//                        }
//                        .padding(.vertical, 4)
                        // Patient Section
                                            VStack(alignment: .leading, spacing: 16) {
//                                                Text("Patient")
//                                                    .gentleText(.headline_m)

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
                    }

                    // HEALTH Section
                    sectionHeader("HEALTH")
                        .padding(.top, 16)

                    formCard {
                        // Allergies toggle
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Any allergies?")
                                    .gentleText(.body_m)
                                Text("Including medications or food")
                                    .gentleText(.caption_s)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Toggle("", isOn: $hasAllergies)
                                .labelsHidden()
                        }
                        .padding(.vertical, 4)

                        Divider()

                        // Additional health information
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Additional health information")
                                .gentleText(.caption_s)
                                .foregroundStyle(.secondary)
                            TextField(
                                "",
                                text: $additionalInfo,
                                prompt: Text("Provide any relevant medical history..."),
                                    // .foregroundStyle(.tertiary),
                                axis: .vertical
                            )
                            .gentleText(.body_m)
                            .lineLimit(4...8)
                            .focused($focusedField, equals: .additionalInfo)
                        }
                        .padding(.vertical, 4)
                    }

                    Spacer()
                        .frame(height: 8)

                    // Submit Button
                    Button {
                        showSubmitted = true
                    } label: {
                        Text("Submit Intake Form")
                            .padding(.vertical, 4)
                    }
                    .gentleButton(.primary, shape: .pill, expandsHorizontally: true)
                    .frame(maxWidth: .infinity)

                    // Disclaimer text
                    Text("By submitting this form, you acknowledge that the information provided is accurate to the best of your knowledge.")
                        .gentleText(.caption_s)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 8)
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

    // MARK: - Components

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .gentleText(.caption_s)
            .foregroundStyle(gentleDesign.themePrimary)
            .fontWeight(.semibold)
            .tracking(1)
    }

    private func formCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            content()
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.background)
                .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 2)
        )
    }

    private func diagonalGradient() -> some View {
        LinearGradient(
            colors: [gentleDesign.themePrimary.opacity(0.3), Color.clear],
            startPoint: .topLeading,
            endPoint: .center
        )
        .ignoresSafeArea()
    }
}
