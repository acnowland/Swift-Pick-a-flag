//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Adam Nowland on 3/22/21.
//

import SwiftUI


struct flags: View {
    var flag: String
    
    var body: some View{
        Image(flag)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .gray, radius: 35, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
    }
}

struct importantText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.largeTitle)
    }
}

extension View {
    func importantTextStyle() -> some View{
        self.modifier(importantText())
    }
}



struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Poland", "Ireland", "Italy", "Nigeria", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var totalCorrect = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
   
    
    var body: some View {
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack (spacing: 30){
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    Text(countries[correctAnswer])
                        .importantTextStyle()
                        
                        
                        
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }){
                        flags(flag: self.countries[number])

                        
                    }
                }
                VStack{
                    Text("Current score is ..")
                        .foregroundColor(.white)
                    Text("\(totalCorrect)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                Spacer()
            }
        }

        .alert(isPresented: $showingScore) {
            Alert(title: Text("Result: "),message:
                    Text("You are \(scoreTitle), the correct country was \(self.countries[correctAnswer])"),

                  
                  
                dismissButton:
                    .default(Text("Continue")){
                        self.askQuestion()
                    })
        }
        
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            totalCorrect += 1
        }else{
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    func askQuestion(){
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
