//
//  AssignmentView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-03-23.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI

struct EvaluationView: View {
    
    @EnvironmentObject var userDataVM : UserDataViewModel
    
    var editing : Bool
    var evaluation : Evaluation
    
    @State var edit = false
    
    @State var expanded = false
    @State var animate = false
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            Rectangle()
                .cornerRadius(20)
                .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
            VStack (alignment: .leading, spacing: 25){
                
                if !self.editing {
                    VStack {
                        HStack {
                            
                            Text(self.evaluation.name)
                                .font(.system(size: get(type: "small"), weight: .semibold))
                                .foregroundColor(Color("SecondaryTextColor"))
                            Spacer()
                            Text((self.evaluation.overall != -1) ? String(format: "%.1f%%", self.evaluation.overall) : "Formative")
                                .font(.system(size: get(type: "small"), weight: .medium))
                                .foregroundColor(Color("SecondaryTextColor"))
                                .padding(.top, 2)
                                .padding(.bottom, 2)
                                .padding(.leading, 5)
                                .padding(.trailing, 5)
                                .background(Color("HighlightColor"))
                                .cornerRadius(5)
                                
                                
                                .foregroundColor(Color("PrimaryTextColor"))
                        }
                        ProgressBarView(percentage: self.evaluation.overall)
                            .offset(x: 0, y: 6)
                            .frame(height: 6)
                    }
                }
                else {
                    HStack {
                        Text(self.evaluation.name)
                            .font(.system(size: get(type: "small"), weight: .semibold))
                            
                            .foregroundColor(Color("SecondaryTextColor"))
                            .offset(x: 0, y: 2)
                        Spacer()
                        Button(action: {
                            self.edit = true
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color("IconColor"))
                        }
                        .padding(5)
                        .offset(x: 0, y: 3)
                        Button(action: {
                            self.userDataVM.deleteEvaluation(selectedEvaluation: self.evaluation)
                        }) {
                            Image(systemName: "trash.fill")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(Color.red)
                        }
                        .padding(5)
                        .offset(x: 0, y: 2)
                    }
                }
                if expanded && !editing {
                    
                    VStack {
                        HStack {
                            
                            Text((self.evaluation.knowledge.weight > 0) ? String(format: "K/U (Weight: %.1f)", self.evaluation.knowledge.weight) : "K/U (No Weight)")
                                .font(.system(size: get(type: "small"), weight: .regular))
                                
                                .foregroundColor(Color("SecondaryTextColor"))
                            Spacer()
                            Text(!self.evaluation.knowledge.score.isEmpty ? "(\(self.evaluation.knowledge.score))" : "")
                                .font(.system(size: get(type: "small"), weight: .regular))
                                
                                .foregroundColor(Color("SecondaryTextColor"))
                            Text((self.evaluation.knowledge.percent != -1) ? String(format: "%.1f%%", self.evaluation.knowledge.percent) : "No Mark")
                                .font(.system(size: get(type: "small"), weight: .regular))
                                
                                .foregroundColor(Color("SecondaryTextColor"))
                        }
                        ProgressBarView(percentage: self.evaluation.knowledge.percent)
                            .offset(x: 0, y: 6)
                            .frame(height: 6)
                    }
                    
                    VStack {
                        HStack {
                            
                            Text((self.evaluation.thinking.weight > 0) ? String(format: "T (Weight: %.1f)", self.evaluation.thinking.weight) : "T (No Weight)")
                                .font(.system(size: get(type: "small"), weight: .regular))
                                
                                .foregroundColor(Color("SecondaryTextColor"))
                            Spacer()
                            Text(!self.evaluation.thinking.score.isEmpty ? "(\(self.evaluation.thinking.score))" : "")
                                .font(.system(size: get(type: "small"), weight: .regular))
                                
                                .foregroundColor(Color("SecondaryTextColor"))
                            Text((self.evaluation.thinking.percent != -1) ? String(format: "%.1f%%", self.evaluation.thinking.percent) : "No Mark")
                                .font(.system(size: get(type: "small"), weight: .regular))
                                
                                .foregroundColor(Color("SecondaryTextColor"))
                        }
                        ProgressBarView(percentage: self.evaluation.thinking.percent)
                            .offset(x: 0, y: 6)
                            .frame(height: 6)
                    }
                    
                    VStack {
                        HStack {
                            
                            Text((self.evaluation.communication.weight > 0) ? String(format: "C (Weight: %.1f)", self.evaluation.communication.weight) : "C (No Weight)")
                                .font(.system(size: get(type: "small"), weight: .regular))
                                
                                .foregroundColor(Color("SecondaryTextColor"))
                            Spacer()
                            Text(!self.evaluation.communication.score.isEmpty ? "(\(self.evaluation.communication.score))" : "")
                                .font(.system(size: get(type: "small"), weight: .regular))
                                .foregroundColor(Color("SecondaryTextColor"))
                            Text((self.evaluation.communication.percent != -1) ? String(format: "%.1f%%", self.evaluation.communication.percent) : "No Mark")
                                .font(.system(size: get(type: "small"), weight: .regular))
                                .foregroundColor(Color("SecondaryTextColor"))
                        }
                        ProgressBarView(percentage: self.evaluation.communication.percent)
                            .offset(x: 0, y: 6)
                            .frame(height: 6)
                    }
                    
                    VStack {
                        HStack {
                            
                            Text((self.evaluation.application.weight > 0) ? String(format: "A (Weight: %.1f)", self.evaluation.application.weight) : "A (No Weight)")
                                .font(.system(size: get(type: "small"), weight: .regular))
                                .foregroundColor(Color("SecondaryTextColor"))
                            Spacer()
                            Text(!self.evaluation.application.score.isEmpty ? "(\(self.evaluation.application.score))" : "")
                                .font(.system(size: get(type: "small"), weight: .regular))
                                
                                .foregroundColor(Color("SecondaryTextColor"))
                            Text((self.evaluation.application.percent != -1) ? String(format: "%.1f%%", self.evaluation.application.percent) : "No Mark")
                                .font(.system(size: get(type: "small"), weight: .regular))
                                
                                .foregroundColor(Color("SecondaryTextColor"))
                        }
                        ProgressBarView(percentage: self.evaluation.application.percent)
                            .offset(x: 0, y: 6)
                            .frame(height: 6)
                    }
                    
                    if evaluation.other.percent >= 0 {
                        VStack {
                            HStack {
                                
                                Text((self.evaluation.other.weight > 0) ? String(format: "O/F (Weight: %.1f)", self.evaluation.other.weight) : "O/F (No Weight)")
                                    .font(.system(size: get(type: "small"), weight: .regular))
                                    .foregroundColor(Color("SecondaryTextColor"))
                                Spacer()
                                Text(!self.evaluation.other.score.isEmpty ? "(\(self.evaluation.other.score))" : "")
                                    .font(.system(size: get(type: "small"), weight: .regular))
                                    .foregroundColor(Color("SecondaryTextColor"))
                                Text((self.evaluation.other.percent != -1) ? String(format: "%.1f%%", self.evaluation.other.percent) : "No Mark")
                                    .font(.system(size: get(type: "small"), weight: .regular))
                                    .foregroundColor(Color("SecondaryTextColor"))
                            }
                            ProgressBarView(percentage: self.evaluation.other.percent)
                                .offset(x: 0, y: 6)
                                .frame(height: 6)
                        }
                    }
                    else {
                        VStack {
                            HStack {
                                
                                Text((self.evaluation.finals.weight > 0) ? String(format: "O/F (Weight: %.1f)", self.evaluation.finals.weight) : "O/F (No Weight)")
                                    .font(.system(size: get(type: "small"), weight: .regular))
                                    .foregroundColor(Color("SecondaryTextColor"))
                                Spacer()
                                Text(!self.evaluation.finals.score.isEmpty ? "(\(self.evaluation.finals.score))" : "")
                                    .font(.system(size: get(type: "small"), weight: .regular))
                                    .foregroundColor(Color("SecondaryTextColor"))
                                Text((self.evaluation.finals.percent != -1) ? String(format: "%.1f%%", self.evaluation.finals.percent) : "No Mark")
                                    .font(.system(size: get(type: "small"), weight: .regular))
                                    .foregroundColor(Color("SecondaryTextColor"))
                            }
                            ProgressBarView(percentage: self.evaluation.finals.percent)
                                .offset(x: 0, y: 6)
                                .frame(height: 6)
                        }
                    }
                    
                    if !evaluation.feedback.isEmpty {
                        Text(evaluation.feedback)
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("SecondaryTextColor"))
                            .multilineTextAlignment(.leading)
                    }
                }
                
                
            }
            .fixedSize(horizontal: false, vertical: true)
            .offset(x: 0, y: -4)
            .padding(.leading, 28)
            .padding(.trailing, 28)
            .padding(.top, 38)
            .padding(.bottom, 38)
            
            
        }
        .foregroundColor(Color("CellColor"))
        //.frame(height: (!expanded || editing) ? get(type: "cell") : 380)
        .animation(animate && expanded ? .easeOut(duration: 0.3) : .none)
        .onTapGesture {
            if(!self.editing) {
                self.expanded.toggle()
                self.animate = true
            }
        }
        
        if #available(iOS 14.0, *) {
            VStack {
            }
            .fullScreenCover(isPresented: self.$edit){
                EditEvaluationView(edit: self.$edit, evaluation: self.evaluation).environmentObject(self.userDataVM)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
        } else {
            VStack {
            }
            .sheet(isPresented: self.$edit) {
                EditEvaluationView(edit: self.$edit, evaluation: self.evaluation).environmentObject(self.userDataVM)
            }
        }
    }
}
