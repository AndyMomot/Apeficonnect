//
//  AddGoalView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI

struct AddGoalView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var tabBarVM: TabBar.TabBarViewModel
    @Environment(\.dismiss) private var dismiss
    
    var onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            Asset.homeBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            Color.purpleCustom.opacity(0.2)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 8, height: 14)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            Text("Nowy cel")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 20))
                            Spacer()
                        }
                        
                        BlurredContainerView {
                            VStack(spacing: 20) {
                                InputField(
                                    title: "Opis celu",
                                    placeholder: "Wprowadź opis...",
                                    text: $viewModel.goalName
                                )
                                
                                VStack(spacing: 6) {
                                    HStack {
                                        Text("Zadania:")
                                            .foregroundStyle(Colors.dimGray.swiftUIColor)
                                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                                        Spacer()
                                    }
                                    
                                    ForEach(viewModel.tasks, id: \.self) { task in
                                        AddedTaskCell(name: task) { name in
                                            viewModel.removeTask(name: name)
                                        }
                                    }
                                }
                                
                                InputField(
                                    title: "Opis zadania",
                                    placeholder: "Wprowadź zadanie...",
                                    text: $viewModel.taskName
                                )
                                
                                NextButton(title: "Dodaj nowe zadanie") {
                                    viewModel.addTask()
                                }
                                .frame(height: 40)
                                
                                Spacer()
                                
                                NextButton(title: "Dodaj nowy cel") {
                                    viewModel.addGoal {
                                        onDismiss()
                                        dismiss.callAsFunction()
                                    }
                                }
                                .frame(height: 59)
                                .padding(.vertical, 50)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.never)
            }
        }
        .navigationBarBackButtonHidden()
        .hideKeyboardWhenTappedAround()
        .onAppear {
            withAnimation {
                tabBarVM.showTabBar(false)
            }
        }
        .onDisappear {
            withAnimation {
                tabBarVM.showTabBar(true)
            }
        }
    }
}

#Preview {
    AddGoalView {}
}
