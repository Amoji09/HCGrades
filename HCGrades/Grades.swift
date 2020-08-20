//
//  DispatchTester.swift
//  HCGrades
//
//  Created by Amogh Mantri on 5/25/20.
//  Copyright © 2020 Amogh Mantri. All rights reserved.
//

import Foundation
import SwiftSoup
import SwiftUI

enum HTMLError : Error{
    case badInnerHTML
}
struct GradesResponse {
    let classes : [GradeClass]
    
    init(_ innerHTML: Any?) throws{
        
        print("step1")
        guard let htmlString = innerHTML as? String else{
            throw HTMLError.badInnerHTML
        }
        print("step2")
        let doc = try SwiftSoup.parseBodyFragment(htmlString)
        //        let classNames = try doc.getElementsByClass("sg-header-heading").array()
        //        print("step3")
        //         var tempClasses = [GradeClass]()
        //        for i in stride(from: 0, to: classNames.count, by: 2){
        //
        //            var className = try classNames[i].text()
        //            let range1 = className.index(className.startIndex, offsetBy: 10)..<className.endIndex
        //            className = String(className[range1])
        //
        //            print(className)
        //
        //            var average = try classNames[i+1].text()
        //            let range2 = average.index(average.startIndex, offsetBy: 16)..<average.endIndex
        //            average = String(average[range2])
        //            print(average)
        //
        //        print("step4")
        
        let classesHTML = try doc.getElementsByClass("AssignmentClass").array()
        
        print("step3")
        var tempClasses = [GradeClass]()
        
        for i in 0..<classesHTML.count{
            let header1 = try classesHTML[i].getElementsByClass("sg-header-heading").array()
            var className = try header1[0].text()
            let range1 = className.index(className.startIndex, offsetBy: 10)..<className.endIndex//sg-header-heading sg-right
            className = String(className[range1])
            print(className)
            let header2 = try classesHTML[i].getElementsByClass("sg-header-heading sg-right").array()
            var average = try header2[0].text()
            let range2 = average.index(average.startIndex, offsetBy: 16)..<average.endIndex
            average = String(average[range2])
            print(average)
            print("step4")
            
            let asgnmts = try classesHTML[i].getElementsByClass("sg-asp-table").array()[0].getElementsByClass("sg-asp-table-data-row").array()
            var tempAsgnmts = [Assignment]()
            for j in 0..<asgnmts.count{
                let asN = try asgnmts[j].getElementsByTag("a").text()
                print(asN)
                let scores = try asgnmts[j].getElementsByTag("td").array()
                let tempScores = try [scores[3].text().trimmingCharacters(in: .whitespacesAndNewlines),scores[4].text().trimmingCharacters(in: .whitespacesAndNewlines),scores[5].text().trimmingCharacters(in: .whitespacesAndNewlines),scores[9].text().trimmingCharacters(in: .whitespacesAndNewlines)]
                print(tempScores[0])
                print(tempScores[1])
                tempAsgnmts.append(Assignment(n: asN, sE: tempScores[1], sM: tempScores[2], p: tempScores[3], c:tempScores[0]))
                
                
                //---------------Categories
                
                
            }
            var categoryTemp = [Category]()
            let categoriesHTML = try classesHTML[i].getElementsByClass("sg-asp-table").array()[1]
            let categoryRows = try categoriesHTML.getElementsByClass("sg-asp-table-data-row").array()
            for k in 0..<categoryRows.count{
                print("category \(k)")
                let categoryCols = try categoryRows[k].getElementsByTag("td").array()
                if(categoryCols.count == 4){
                    try categoryTemp.append(Category(n:categoryCols[0].text() , pE: categoryCols[1].text(), pM: categoryCols[2].text(), p: categoryCols[3].text(), w: "None"))
                }
                else{
                    let categoryCols = try categoryRows[k].getElementsByTag("td").array()
                    try categoryTemp.append(Category(n:categoryCols[0].text() , pE: categoryCols[1].text(), pM: categoryCols[2].text(), p: categoryCols[3].text(), w: categoryCols[4].text()))
                }
            }
            let tempClass = GradeClass(name: className, avg: average, asgn: tempAsgnmts,cats: categoryTemp)
            tempClasses.append(tempClass)
            print(tempClass)
        }
        self.classes = tempClasses
    }
    
    init(){
        classes = []
    }
}

struct GradeClass : Identifiable{
    let id = UUID()
    let className : String
    let average : String
    let assignments : [Assignment]
    let categories : [Category]
    init(name: String, avg: String, asgn: [Assignment], cats: [Category]){
        className = name
        average = avg
        assignments = asgn
        categories = cats
    }
    
    
}

struct Assignment : Identifiable{
    let  id = UUID()
    let assignmentName : String
    let scoreEarned : String
    let scoreMax : String
    let percentage : String
    let category : String
    init(n: String, sE: String, sM: String, p: String, c: String){
        assignmentName = n
        scoreEarned = sE
        scoreMax = sM
        percentage = p
        category = c
    }
}

struct GradeRow : View{
    let name : String
    let grade : String
    var body : some View{
        
        HStack{
            Text(name).bold()
            Spacer()
            Text(grade)
            Image(systemName: "chevron.right")
            }.padding().background(Color("Red")).cornerRadius(10).padding(.horizontal,20).shadow(radius: 5)
    }
    init(n: String, g: String){
        name = n
        grade = g
    }
}

struct Category : Identifiable{
    let id = UUID()
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
}

extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

