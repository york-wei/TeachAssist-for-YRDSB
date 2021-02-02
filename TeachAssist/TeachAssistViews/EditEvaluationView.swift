//
//  EditEvaluationView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-03-31.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI

struct EditEvaluationView: View {
    
    @Binding var edit : Bool
    
    @State var evaluation : Evaluation
    
    @EnvironmentObject var userDataVM : UserDataViewModel
    
    @State var hasKnowledge = false
    @State var hasThinking = false
    @State var hasCommunication = false
    @State var hasApplication = false
    @State var hasOther = false
    @State var hasFinals = false
    
    @State var kPercent = 0.0
    @State var tPercent = 0.0
    @State var cPercent = 0.0
    @State var aPercent = 0.0
    @State var oPercent = 0.0
    @State var fPercent = 0.0
    
    @State var kWeight = 0.0
    @State var tWeight = 0.0
    @State var cWeight = 0.0
    @State var aWeight = 0.0
    @State var oWeight = 0.0
    @State var fWeight = 0.0
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading) {
                
                HStack {
                    Text(self.evaluation.name)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color("PrimaryTextColor"))
                    Spacer()
                    Button(action: {
                        
                        var markSum = 0.0
                        var weightSum = 0.0
                        
                        var overall = -1.0
                        
                        var k = -1.0
                        var kW = -1.0
                        var t = -1.0
                        var tW = -1.0
                        var c = -1.0
                        var cW = -1.0
                        var a = -1.0
                        var aW = -1.0
                        var o = -1.0
                        var oW = -1.0
                        var f = -1.0
                        var fW = -1.0
                        
                        if(self.hasKnowledge) {
                            k = self.kPercent
                            kW = self.kWeight
                            
                            markSum += k * kW
                            weightSum += kW
                        }
                        if(self.hasThinking) {
                            t = self.tPercent
                            tW = self.tWeight
                            
                            markSum += t * tW
                            weightSum += tW
                        }
                        if(self.hasCommunication) {
                            c = self.cPercent
                            cW = self.cWeight
                            
                            markSum += c * cW
                            weightSum += cW
                            
                        }
                        if(self.hasApplication) {
                            a = self.aPercent
                            aW = self.aWeight
                            
                            markSum += a * aW
                            weightSum += aW
                            
                        }
                        if(self.hasOther) {
                            o = self.oPercent
                            oW = self.oWeight
                            
                            markSum += o * oW
                            weightSum += oW
                            
                        }
                        if(self.hasFinals) {
                            f = self.fPercent
                            fW = self.fWeight
                            
                            markSum += f * fW
                            weightSum += fW
                        }
                        
                        if weightSum > 0 {
                            overall = markSum / weightSum
                        }
                        
                        let evaluation = Evaluation(name: self.evaluation.name, knowledge: Section(percent: k, weight: kW, score: ""), thinking: Section(percent: t, weight: tW, score: ""), communication: Section(percent: c, weight: cW, score: ""), application: Section(percent: a, weight: aW, score: ""), other: Section(percent: o, weight: oW, score: ""), finals: Section(percent: f, weight: fW, score: ""), overall: overall)
                        
                        evaluation.id = self.evaluation.id
                        
                        self.userDataVM.editEvaluation(selectedEvaluation: evaluation)
                        
                        
                        withAnimation {
                            self.edit = false
                        }
                    }) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color("IconColor"))
                            .offset(x: 0, y: 0)
                    }
                    .frame(width: 40, height: 40)
                    .background(Color("CellColor"))
                    .clipShape(Circle())
                    .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                }
                .padding(.bottom, 10)
                            
                VStack (spacing: 5) {
                    
                    HStack {
                        Text("Knowledge/Understanding")
                            .font(.system(size: get(type: "small"), weight: .semibold))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(self.hasKnowledge ? 1 : 0.6)
                        Spacer()
                        Toggle("", isOn: self.$hasKnowledge).labelsHidden().onTapGesture {
                            self.kPercent = 0.0
                            self.kWeight = 0.0
                        }
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text(hasKnowledge ? String(format: "Mark Percentage: %.1f%%", Double(self.kPercent)) : "Mark Percentage")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(self.hasKnowledge ? 1 : 0.6)
                        Spacer()
                    }
                    Slider(value: $kPercent, in: 0...100, step: 0.1)
                    .accentColor(Color("IconColor"))
                    .disabled(!hasKnowledge)
                    HStack {
                        Text(hasKnowledge ? String(format: "Weight: %.1f", Double(self.kWeight)) : "Weight")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(self.hasKnowledge ? 1 : 0.6)
                        Spacer()
                    }
                    Slider(value: $kWeight, in: 0...100, step: 0.1)
                    .accentColor(Color("IconColor"))
                    .disabled(!hasKnowledge)
                }
                .padding(.bottom, 10)
                            
                VStack (spacing: 5) {
                    
                    HStack {
                        Text("Thinking")
                            .font(.system(size: get(type: "small"), weight: .semibold))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasThinking ? 1 : 0.6)
                        Spacer()
                        Toggle("", isOn: self.$hasThinking).labelsHidden().onTapGesture {
                            self.tPercent = 0.0
                            self.tWeight = 0.0
                        }
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text(hasThinking ? String(format: "Mark Percentage: %.1f%%", Double(self.tPercent)) : "Mark Percentage")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasThinking ? 1 : 0.6)
                        Spacer()
                    }
                    Slider(value: $tPercent, in: 0...100, step: 0.1)
                    .accentColor(Color("IconColor"))
                    .disabled(!hasThinking)
                    HStack {
                        Text(hasThinking ? String(format: "Weight: %.1f", Double(self.tWeight)) : "Weight")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasThinking ? 1 : 0.6)
                        Spacer()
                    }
                    Slider(value: $tWeight, in: 0...100, step: 0.1)
                    .accentColor(Color("IconColor"))
                    .disabled(!hasThinking)
                }
                .padding(.bottom, 10)
                            
                VStack (spacing: 5) {
                    
                    HStack {
                        Text("Communication")
                            .font(.system(size: get(type: "small"), weight: .semibold))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasCommunication ? 1 : 0.6)
                        Spacer()
                        Toggle("", isOn: self.$hasCommunication).labelsHidden().onTapGesture {
                            self.cPercent = 0.0
                            self.cWeight = 0.0
                        }
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text(hasCommunication ? String(format: "Mark Percentage: %.1f%%", Double(self.cPercent)) : "Mark Percentage")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasCommunication ? 1 : 0.6)
                        Spacer()
                    }
                    Slider(value: $cPercent, in: 0...100, step: 0.1)
                    .accentColor(Color("IconColor"))
                    .disabled(!hasCommunication)
                    HStack {
                        Text(hasCommunication ? String(format: "Weight: %.1f", Double(self.cWeight)) : "Weight")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasCommunication ? 1 : 0.6)
                        Spacer()
                    }
                    Slider(value: $cWeight, in: 0...100, step: 0.1)
                    .accentColor(Color("IconColor"))
                    .disabled(!hasCommunication)
                }
                .padding(.bottom, 10)
                
                VStack (spacing: 5) {
                    
                    HStack {
                        Text("Application")
                            .font(.system(size: get(type: "small"), weight: .semibold))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasApplication ? 1 : 0.6)
                        Spacer()
                        Toggle("", isOn: self.$hasApplication).labelsHidden().onTapGesture {
                            self.aPercent = 0.0
                            self.aWeight = 0.0
                        }
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text(hasApplication ? String(format: "Mark Percentage: %.1f%%", Double(self.aPercent)) : "Mark Percentage")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasApplication ? 1 : 0.6)
                        Spacer()
                    }
                    Slider(value: $aPercent, in: 0...100, step: 0.1)
                    .accentColor(Color("IconColor"))
                    .disabled(!hasApplication)
                    HStack {
                        Text(hasApplication ? String(format: "Weight: %.1f", Double(self.aWeight)) : "Weight")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasApplication ? 1 : 0.6)
                        Spacer()
                    }
                    Slider(value: $aWeight, in: 0...100, step: 0.1)
                    .accentColor(Color("IconColor"))
                    .disabled(!hasApplication)
                }
                .padding(.bottom, 10)
                
                VStack (spacing: 5) {
                    
                    HStack {
                        Text("Other")
                            .font(.system(size: get(type: "small"), weight: .semibold))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasOther ? 1 : 0.6)
                        Spacer()
                        Toggle("", isOn: self.$hasOther).labelsHidden().onTapGesture {
                            self.oPercent = 0.0
                            self.oWeight = 0.0
                        }
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text(hasOther ? String(format: "Mark Percentage: %.1f%%", Double(self.oPercent)) : "Mark Percentage")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasOther ? 1 : 0.6)
                        Spacer()
                    }
                    Slider(value: $oPercent, in: 0...100, step: 0.1)
                    .accentColor(Color("IconColor"))
                    .disabled(!hasOther)
                    HStack {
                        Text(hasOther ? String(format: "Weight: %.1f", Double(self.oWeight)) : "Weight")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasOther ? 1 : 0.6)
                        Spacer()
                    }
                    Slider(value: $oWeight, in: 0...100, step: 0.1)
                    .accentColor(Color("IconColor"))
                    .disabled(!hasOther)
                }
                .padding(.bottom, 10)
                
                VStack (spacing: 5) {
                    
                    HStack {
                        Text("Final")
                            .font(.system(size: get(type: "small"), weight: .semibold))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasFinals ? 1 : 0.6)
                        Spacer()
                        Toggle("", isOn: self.$hasFinals).labelsHidden().onTapGesture {
                            self.fPercent = 0.0
                            self.fWeight = 0.0
                        }
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text(hasFinals ? String(format: "Mark Percentage: %.1f%%", Double(self.fPercent)) : "Mark Percentage")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasFinals ? 1 : 0.6)
                        Spacer()
                    }
                    Slider(value: $fPercent, in: 0...100, step: 0.1)
                    .accentColor(Color("IconColor"))
                    .disabled(!hasFinals)
                    HStack {
                        Text(hasFinals ? String(format: "Weight: %.1f", Double(self.fWeight)) : "Weight")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .opacity(hasFinals ? 1 : 0.6)
                        Spacer()
                    }
                    Slider(value: $fWeight, in: 0...100, step: 0.1)
                    .accentColor(Color("IconColor"))
                    .disabled(!hasFinals)
                }
                .padding(.bottom, 10)
                
            }
            .padding(.top, get(type: "top"))
            .padding(.leading, get(type: "side"))
            .padding(.trailing, get(type: "side"))
            .padding(.bottom, 40)
            
        }
        .background(Color("BackgroundColor"))
        .onAppear(perform: {
            if self.evaluation.knowledge.weight > 0 {
                self.hasKnowledge = true
                self.kPercent = self.evaluation.knowledge.percent
                self.kWeight = self.evaluation.knowledge.weight
            }
            if self.evaluation.thinking.weight > 0 {
                self.hasThinking = true
                self.tPercent = self.evaluation.thinking.percent
                self.tWeight = self.evaluation.thinking.weight
            }
            if self.evaluation.communication.weight > 0 {
                self.hasCommunication = true
                self.cPercent = self.evaluation.communication.percent
                self.cWeight = self.evaluation.communication.weight
            }
            if self.evaluation.application.weight > 0 {
                self.hasApplication = true
                self.aPercent = self.evaluation.application.percent
                self.aWeight = self.evaluation.application.weight
            }
            if self.evaluation.other.weight > 0 {
                self.hasOther = true
                self.oPercent = self.evaluation.other.percent
                self.oWeight = self.evaluation.other.weight
            }
            if self.evaluation.finals.weight > 0 {
                self.hasFinals = true
                self.fPercent = self.evaluation.finals.percent
                self.fWeight = self.evaluation.finals.weight
            }
        })
    }
}

//struct AddEvaluationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddEvaluationView()
//    }
//}
