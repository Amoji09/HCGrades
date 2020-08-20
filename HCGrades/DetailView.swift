//
//  DetailView.swift
//  HCGrades
//
//  Created by Amogh Mantri on 5/26/20.
//  Copyright © 2020 Amogh Mantri. All rights reserved.
//

import SwiftUI



struct DetailView: View {
    var average = ""
    var assignments = [Assignment]()
    var categories = [Category]()
    init(assignments : [Assignment], avg: String, cats: [Category]) {
        UITabBar.appearance().isTranslucent = false
       UITabBar.appearance().barTintColor  = #colorLiteral(red: 0.5803921569, green: 0.066734083, blue: 0, alpha: 1)
        self.assignments = assignments
        self.average = avg
        self.categories = cats
    }
    var body: some View {
        TabView {
            List{
                ForEach(assignments) {assignment in
                    AssignmentRow(n: assignment.assignmentName, sE: assignment.scoreEarned, sM: assignment.scoreMax, p: assignment.percentage, c: assignment.category)
                }
            }
            
            .tabItem {
                Image(systemName: "a.circle")
                Text("Grades")
                }
            
           List{
            ForEach(categories) {category in
                CategoryRow(n:category.name, pE: category.pointsEarned, pM: category.pointsMax, p: category.percentage, w: category.weight)
            }
            }
            .tabItem {
                Image(systemName: "tray.full")
                Text("Categories")
                }
            
            FinalsView(sAvg: self.average)
            .tabItem {
                Image(systemName: "percent")
                Text("Finals")
            }
        }//.accentColor(Color.white)
    }
}


struct AssignmentRow : View{
    let assignmentName : String
    let scoreEarned : String
    let scoreMax : String
    let percentage : String
    let category : String
    var body : some View{
        VStack{
            Text(assignmentName).bold()
            HStack{
                Text("\(scoreEarned) / \(scoreMax) = \(percentage)")
                //Text(category)
            }
        }
    }
    init(n: String, sE: String, sM: String, p: String,c: String) {
        assignmentName = n
        scoreEarned = sE
        scoreMax = sM
        percentage = p
        category = c
    }
}
struct CategoryRow : View{
    let name : String
    let pointsEarned : String
    let pointsMax : String
    let percentage : String
    let weight : String
    init(n:String, pE: String, pM: String, p: String, w: String){
        name = n
        pointsEarned = pE
        pointsMax = pM
        percentage = p
        weight = w
    }
    var body: some View{
        VStack(){
            Text(name).bold()
            HStack{
                Text("\(pointsEarned) / \(pointsMax) = \(percentage)")
                
            }
            if(weight != "None"){
                Text("Weight: \(weight)%").font(.footnote)
            }
            else{
                Text("Weight: \(weight)").font(.footnote)
            }
        }
    }
}

