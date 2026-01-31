//  Jonathan Ritchey
import GentleDesignSystem
import SwiftUI

struct TransitCardTemplateView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 24) {
                    // Transit Card
                    transitCard

                    // Action Buttons Grid
                    actionButtonsGrid

                    // Recent Rides
                    recentRidesSection
                }
                .padding(.horizontal)
                .padding(.bottom, 100) // Space for bottom buttons
            }

            // Bottom Buttons
            bottomButtons
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Transit Card")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "gearshape.fill")
                        .foregroundStyle(.primary)
                }
            }
        }
    }

    // MARK: - Transit Card

    private var transitCard: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color(red: 0.53, green: 0.73, blue: 0.98),
                    Color(red: 0.40, green: 0.62, blue: 0.95)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // Content
            VStack(alignment: .leading, spacing: 0) {
                // Top row: City Transit + Active badge
                HStack {
                    HStack(spacing: 8) {
                        Image(systemName: "bus.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(.white.opacity(0.9))
                            .frame(width: 28, height: 28)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 6))

                        Text("CITY TRANSIT")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.white)
                            .tracking(0.5)
                    }

                    Spacer()

                    // Active badge
                    HStack(spacing: 6) {
                        Circle()
                            .fill(.green)
                            .frame(width: 8, height: 8)
                        Text("ACTIVE")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.white.opacity(0.2))
                    .clipShape(Capsule())
                }

                Spacer()
                    .frame(height: 16)

                // Balance section with contactless icon
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("BALANCE")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(.white.opacity(0.8))
                            .tracking(0.5)

                        Text("$18.40")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundStyle(.white)
                    }

                    Spacer()

                    // Contactless icon
                    Image(systemName: "wave.3.right")
                        .font(.system(size: 48, weight: .light))
                        .foregroundStyle(.white.opacity(0.3))
                        .rotationEffect(.degrees(-45))
                }

                Spacer()

                // Bottom row: Last activity + Card chip + Auto-reload
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("LAST ACTIVITY")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(.white.opacity(0.7))
                            .tracking(0.5)

                        Text("Jan 24 • 5:12 PM")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.white)
                    }

                    Spacer()

                    // Card chip
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.white.opacity(0.4))
                        .frame(width: 40, height: 30)
                        .overlay(
                            VStack(spacing: 2) {
                                ForEach(0..<4, id: \.self) { _ in
                                    Rectangle()
                                        .fill(.white.opacity(0.3))
                                        .frame(height: 1)
                                }
                            }
                            .padding(4)
                        )

                    Spacer()
                        .frame(width: 16)

                    // Auto-reload badge
                    HStack(spacing: 6) {
                        Text("AUTO-RELOAD")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(.white)

                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.white.opacity(0.25))
                    .clipShape(Capsule())
                }
            }
            .padding(20)
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 6)
    }

    // MARK: - Action Buttons Grid

    private var actionButtonsGrid: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                actionButton(
                    title: "Add Funds",
                    systemImage: "plus",
                    color: .blue
                )
                actionButton(
                    title: "Ride History",
                    systemImage: "clock.arrow.circlepath",
                    color: .orange
                )
            }
            HStack(spacing: 12) {
                actionButton(
                    title: "Auto-Reload",
                    systemImage: "arrow.triangle.2.circlepath",
                    color: .blue
                )
                actionButton(
                    title: "Suspend Card",
                    systemImage: "nosign",
                    color: .red
                )
            }
        }
    }

    private func actionButton(title: String, systemImage: String, color: Color) -> some View {
        Button(action: {}) {
            VStack(alignment: .leading, spacing: 12) {
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(color)
                    .frame(width: 44, height: 44)
                    .background(color.opacity(0.12))
                    .clipShape(Circle())

                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }

    // MARK: - Recent Rides Section

    private var recentRidesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Rides")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.primary)

            VStack(spacing: 0) {
                rideRow(
                    icon: "bus.fill",
                    station: "Downtown Station",
                    dateTime: "Today • 8:10 AM",
                    amount: "-$2.75"
                )

                Divider()
                    .padding(.leading, 60)

                rideRow(
                    icon: "tram.fill",
                    station: "Central Park",
                    dateTime: "Yesterday • 5:30 PM",
                    amount: "-$2.75"
                )

                Divider()
                    .padding(.leading, 60)

                rideRow(
                    icon: "airplane",
                    station: "Airport Terminal",
                    dateTime: "Jan 22 • 9:00 AM",
                    amount: "-$5.00"
                )
            }
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }

    private func rideRow(icon: String, station: String, dateTime: String, amount: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundStyle(.secondary)
                .frame(width: 40, height: 40)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 2) {
                Text(station)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.primary)

                Text(dateTime)
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(amount)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.primary)
        }
        .padding(16)
    }

    // MARK: - Bottom Buttons

    private var bottomButtons: some View {
        HStack(spacing: 12) {
            Button(action: {}) {
                Text("Add $10")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }

            Button(action: {}) {
                Text("Manage")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(.background)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 16)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    NavigationStack {
        TransitCardTemplateView()
    }
}
