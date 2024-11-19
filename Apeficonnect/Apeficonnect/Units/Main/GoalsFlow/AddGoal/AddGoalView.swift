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
            Colors.paleAsh.swiftUIColor
                .ignoresSafeArea()
            
            VStack {
                Asset.addGoalBg.swiftUIImage
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
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
                            Text("New Goal")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 20))
                            Spacer()
                        }
                        
                        BlurredContainerView {
                            VStack(spacing: 20) {
                                InputField(
                                    title: "Description of the Goal",
                                    placeholder: "Enter a description...",
                                    text: $viewModel.goalName
                                )
                                
                                VStack(spacing: 6) {
                                    HStack {
                                        Text("Tasks:")
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
                                    title: "Description of the Task",
                                    placeholder: "Enter a task...",
                                    text: $viewModel.taskName
                                )
                                
                                NextButton(title: "Add a New task") {
                                    viewModel.addTask()
                                }
                                .frame(height: 40)
                                
                                Spacer()
                                
                                NextButton(title: "Add a New Goal") {
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
