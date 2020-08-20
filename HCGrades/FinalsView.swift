//
//  FinalsView.swift
//  HCGrades
//
//  Created by Amogh Mantri on 5/27/20.
//  Copyright © 2020 Amogh Mantri. All rights reserved.
//
//TODO: FIGURE OUT SEMESTER AVERAGE ISSUE, ACTUAL VARIABLE NOT BEING SET TO RIGHT VALUE
import SwiftUI

struct FinalsView: View {
    let semAvg : Double
    @State var step = 0
    @State var aP = 0.0
    @State var bP = 0.0
    @State var cP = 0.0
    @State var dP = 0.0
    @State var finalWeight = 0.0
    @State var showsAlert = false
    @State var selectedColors = [Color("Red"),Color.white]
    @State var selected1 = false
    @State var selected2 = false
    @State var isShowingEditField = true
    @State var text: String = ""
    var body: some View {
        VStack(spacing: 20){
            if(self.step == 0){
                Button(action: {
                    self.aP = 89.5
                }) {
                    Text("89.5").foregroundColor(Color("Red")).padding(.horizontal,100).padding(.vertical,20)
                }.overlay(Capsule().stroke(Color("Red"), lineWidth: 5))
                Button(action: {
                    self.aP = 79.5
                }) {
                    Text("79.5").foregroundColor(Color("Red")).padding(.horizontal,100).padding(.vertical,20)
                }.overlay(Capsule().stroke(Color("Red"), lineWidth: 5))
                Button(action: {
                    self.showsAlert = true
                }) {
                    Text("Custom").foregroundColor(Color("Red")).padding(.horizontal,85).padding(.vertical,20)
                }.overlay(Capsule().stroke(Color("Red"), lineWidth: 5))
            }
        }.alert(isPresented: $showsAlert, TextAlert(title: "Title", action: {
            print("Callback \($0 ?? "<cancel>")")
        }))
        
    }
    init(sAvg : String){
        print("parameter \(sAvg)")
        let endOfSentence = sAvg.firstIndex(of: "%")!
        let firstSentence = sAvg[..<endOfSentence]
        print(String(firstSentence))
        self.semAvg = Double(String(firstSentence))!
        print("semAvg  \(self.semAvg)")
        print("converted \(Double(String(firstSentence))!)")
    }
    //    func calculateGrades() /*-> [String]*/{
    //        let aGrade = (Double(self.aP)! - (self.semAvg * (100-finalWeight)))/finalWeight
    //        let bGrade = (Double(self.aP)! - (self.semAvg * (100-finalWeight)))/finalWeight
    //        let cGrade = (Double(self.aP)! - (self.semAvg * (100-finalWeight)))/finalWeight
    //        let dGrade = (Double(self.aP)! - (self.semAvg * (100-finalWeight)))/finalWeight
    //    }
    func checkValid(test : String) -> Bool{
        if let _ = Double(test){
            return true
        }else{
            return false
        }
    }
}




struct FinalsView_Previews: PreviewProvider {
    static var previews: some View {
        FinalsView(sAvg: "90.00%").environment(\.colorScheme, .light)
    }
}
