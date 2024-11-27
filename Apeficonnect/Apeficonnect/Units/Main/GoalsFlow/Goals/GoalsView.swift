//
//  GoalsView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI

struct GoalsView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.homeBg.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                
                Color.purpleCustom.opacity(0.2)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    NavigationTitleView()
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Cele i zadania")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                                
                                Spacer()
                                
                                Button {
                                    viewModel.showAddGoal.toggle()
                                } label: {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.white)
                                        .frame(width: 24)
                                }
                            }
                            
                            if viewModel.showGoalDetails {
                                if let goal = viewModel.goalToShow {
                                    GoalDetailsCell(goal: goal) { action in
                                        viewModel.handleGoalDetails(action: action)
                                    }
                                }
                            } else {
                                if viewModel.goals.isEmpty {
                                    Spacer()
                                    NextButton(title: "Dodaj nowy cel") {
                                        viewModel.showAddGoal.toggle()
                                    }
                                    .frame(height: 59)
                                } else {
                                    ForEach(viewModel.goals.indices, id: \.self) { index in
                                        let goal = viewModel.goals[index]
                                        Button {
                                            viewModel.goalToShow = goal
                                            withAnimation {
                                                viewModel.showGoalDetails = true
                                            }
                                        } label: {
                                            GoalCell(
                                                position: index + 1,
                                                goal: goal
                                            )
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                    }
                    .scrollIndicators(.never)
                }
            }
            .onAppear {
                viewModel.getGoals()
            }
            .navigationDestination(isPresented: $viewModel.showAddGoal) {
                AddGoalView {
                    viewModel.getGoals()
                }
            }
        }
    }
}

#Preview {
    GoalsView()
}
