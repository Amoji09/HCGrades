//
//  LoginView.swift
//  HCGrades
//
//  Created by Amogh Mantri on 5/24/20.
//  Copyright © 2020 Amogh Mantri. All rights reserved.
//

import SwiftUI
import WebKit

struct LoginView: View {
    @State private var username = "821430"
    @State private var password = "Akm72003Akm72003"
    @State private var counter = 0
    @State private var webViewR = WebViewNew()
    @State var finished = false
    @State var x = true
    @State var html = """
"""
    @State var rowHeight = 20
    @State var gradeClasses1 = [GradeClass]()
    @State var gradeClasses2 = [GradeClass]()
    @State var hitLogin = false
    @State var semester = true
    
    var body: some View {
        
        
        ZStack{
            Color("Red")
            webViewR
            if(!self.finished){
                VStack{
                    TextField("School ID", text: $username).padding().background(Color.white).cornerRadius(10).accentColor(Color("Red")).foregroundColor(Color.black)
                    
                    SecureField("Password", text: $password).padding().background(Color.white).cornerRadius(10).accentColor(Color("Red")).foregroundColor(Color.black)
                    
                    Button(action: {self.runLogin()}) {
                        Text("Login").bold()
                    }.foregroundColor(Color("Red")).padding(.horizontal, 50).padding(.vertical,5).background(Color.white).cornerRadius(10).disabled(self.hitLogin)
                }.padding(.horizontal)
                if(self.hitLogin){
                    VStack {
                        Text("Loading...")
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                    }
                    .frame(width: 100,
                           height: 100)
                        .background(Color.secondary.colorInvert())
                        .foregroundColor(Color.primary)
                        .cornerRadius(20)
                }
            }
            else{
                NavigationView{
                    
                    VStack(spacing:30){
                        if(self.semester){
                                ForEach(self.gradeClasses1) {gradeClass in
                                    NavigationLink(destination: DetailView(assignments: gradeClass.assignments, avg: gradeClass.average,cats: gradeClass.categories)) {
                                        GradeRow(n: gradeClass.className, g: gradeClass.average)
                                    }
                                }
                        }
                        else{
                            
                                ForEach(self.gradeClasses2) {gradeClass in
                                    NavigationLink(destination: DetailView(assignments: gradeClass.assignments, avg: gradeClass.average,cats: gradeClass.categories)) {
                                        GradeRow(n: gradeClass.className, g: gradeClass.average)
                                    }
                                }
                        }
                        
                        HStack(spacing: 10){
                            Button(action: {
                                self.semester = false
                                print(self.gradeClasses2)
                            }) {
                                Text("Semester 1").bold()
                            }.foregroundColor(Color.white).padding(.vertical,5).padding(.horizontal,5).background(Color("Red")).cornerRadius(10)
                            
                            Button(action: {self.semester = true}) {
                                Text("Semester 2").bold()
                            }.foregroundColor(Color.white).padding(.vertical,5).padding(.horizontal,5).background(Color("Red")).cornerRadius(10)
                            
                        }.padding(.vertical,20).padding(.horizontal,30)
                            
                            .navigationBarTitle("Grades", displayMode: .inline)
                        
                    }
                }.accentColor(Color.white)
            }
            
        }
    }
    func login(){
        //EMAIL ID: LogOnDetails_UserName
        //  PASSWORD ID: LogOnDetails_Password
        
        switch counter{
        case 0:
            webViewR.webViewStore.webView.evaluateJavaScript("document.getElementById('LogOnDetails_UserName').value='\(username)'", completionHandler:nil)
            webViewR.webViewStore.webView.evaluateJavaScript("document.getElementById('LogOnDetails_Password').value='\(password)'", completionHandler:nil)
            webViewR.webViewStore.webView.evaluateJavaScript("document.querySelector('form').submit();", completionHandler: nil)
        case 1:
            let url = URL(string:  "https://portal.hinsdale86.org/HomeAccess/Content/Student/Assignments.aspx")!
            let request = URLRequest(url:url)
            webViewR.webViewStore.webView.load(request)
            
        case 2:
            webViewR.webViewStore.webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler: {(innerHTML, error) in
                do{
                    self.gradeClasses1 = try GradesResponse(innerHTML).classes
                    print("Got response")
                }catch{
                    print("Fatal error")
                }
            })
        case 3:
            self.webViewR.webViewStore.webView.evaluateJavaScript("document.getElementById('plnMain_ddlReportCardRuns').value = '2-2020'", completionHandler:nil)
            print("executed selection")
        case 4:
            self.webViewR.webViewStore.webView.evaluateJavaScript("document.getElementById('plnMain_btnRefreshView').click();",completionHandler: nil)
            print("executed refresh")
        case 5:
            self.webViewR.webViewStore.webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler: {(innerHTML, error) in
                do{
                    print(innerHTML!)
                    self.gradeClasses2 = try GradesResponse(innerHTML).classes
                    print("Got response")
                }catch{
                    print("Fatal error")
                }
            })
            print("executed getHMTML")
            self.finished.toggle()
        default:
            counter = 0
            self.runLogin()
        }
        counter += 1
    }
    
    func runLogin(){
        self.hitLogin.toggle()
        self.login()
        print("executed1")
        let timer1 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { timer in
            self.login()
            print("executed2")
        })
        let timer2 = Timer.scheduledTimer(withTimeInterval: 9.0, repeats: false, block: { timer in
            self.login()
            print("executed3")
        })
        let timer3 = Timer.scheduledTimer(withTimeInterval: 12.0, repeats: false, block: { timer in
            
            print(self.finished)
            
           
            
            print(self.finished)
            print("executed4")
            print(self.gradeClasses1)
            print("finished")
        })
        let timer4 = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false, block: { timer in
            self.login()
        })
        let timer5 = Timer.scheduledTimer(withTimeInterval: 19.0, repeats: false, block: {timer in
            self.login()
        })
        let timer6 = Timer.scheduledTimer(withTimeInterval: 25.0, repeats: false, block: {timer in
           
            self.login()
            //self.finished.toggle()
        })
        
    }
    
}

//struct OverallView : View {
//    @State var grades = [GradeClass]()
//    var body: some View{
//        List{
//            ForEach(self.grades) {grade in
//                GradeRow(n: grade.className, g: grade.average)
//
//            }
//        }
//    }
//
//    init(g: [GradeClass]){
//        self.grades = g
//        print(self.grades)
//    }
//    init(){}
//}



struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

