import SwiftUI

struct HomeView: View {
    @State private var showLogoutAlert = false
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color(red: 0.97, green: 0.97, blue: 0.98)
                    .ignoresSafeArea()

                VStack(spacing: 22) {

                    // Header
                    VStack(alignment: .leading, spacing: 6) {
                        Text(AppStrings.Home.greeting)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(Color.black.opacity(0.85))

                        Text(AppStrings.Home.accountID)
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)

                    // Balance Card
                    VStack(spacing: 6) {
                        Text(AppStrings.Home.balanceAmount)
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.white)

                        Text(AppStrings.Home.balanceTitle)
                            .font(.system(size: 13))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 110)
                    .padding(.vertical, 22)
                    .background(
                        ZStack {
                            LinearGradient(
                                colors: [
                                    Color(red: 0.34, green: 0.47, blue: 0.92),
                                    Color(red: 0.18, green: 0.25, blue: 0.55)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )

                            RadialGradient(
                                colors: [
                                    Color.white.opacity(0.22),
                                    Color.clear
                                ],
                                center: .top,
                                startRadius: 20,
                                endRadius: 160
                            )
                        }
                    )
                    .cornerRadius(18)
                    .shadow(color: Color.black.opacity(0.15),
                            radius: 10, x: 0, y: 6)

                    // Action List
                    VStack(spacing: 12) {

                        //Transaction History Navigation
                        NavigationLink {
                            TransactionHistoryView()
                        } label: {
                            HomeRowExact(
                                icon: "clock",
                                title: AppStrings.Home.transactionHistory,
                                iconColor: .blue
                            )
                        }

                        HomeRowExact(
                            icon: "paperplane.fill",
                            title: AppStrings.Home.sendFunds,
                            iconColor: .green
                        )

                        HomeRowExact(
                            icon: "rectangle.portrait.and.arrow.right",
                            title: AppStrings.Home.logout,
                            iconColor: .red
                        )
                        .onTapGesture {
                            showLogoutAlert = true
                        }
                    }
                    .alert("Are you sure you want to logout?", isPresented: $showLogoutAlert) {
                        Button("Yes", role: .destructive) {
                            appState.isLoggedIn = false
                        }
                        Button("No", role: .cancel) { }
                    }

                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
