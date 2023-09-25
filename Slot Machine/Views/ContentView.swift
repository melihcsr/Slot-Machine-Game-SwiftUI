//
//  ContentView.swift
//  Slot Machine
//
//  Created by Melih Cesur on 24.09.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingInfoView: Bool = false
    
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    
    @State public var slot1 = 0
    @State public var slot2 = 1
    @State public var slot3 = 2
    @State private var betAmount: Int = 10
    @State private var coins: Int = 100
    @State private var highScore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var showingModal: Bool = false
    @State private var animatingSymbol: Bool = false
    
    
    
    
    func checkWinning(){
        if slot1 == slot2 && slot2 == slot3 && slot1 == slot3 {
            
            playerWins()
            
            if coins>highScore{
                newHighScore()
            }
            
        }else{
            playerLoses()
        }
    }
    
    func playerWins(){
        coins += betAmount * 10
    }
    
    func newHighScore(){
        highScore = coins
        UserDefaults.standard.set(highScore, forKey: "HighScore")
    }
    
    func playerLoses(){
        coins -= betAmount
    }
    
    func activateBet20(){
        betAmount = 20
    }
    
    func activateBet10(){
        betAmount = 10
    }
    
    func isGameOver(){
        if coins <= 0 {
            showingModal = true
        }
    }
    
    func resetGame(){
        UserDefaults.standard.set(0, forKey: "HighScore")
        highScore = 0
        coins = 100
        activateBet10()
    }
    
    var body: some View {
     
        
        ZStack {
            
            //MARK: -BACKGROUND
            LinearGradient(colors: [Color("ColorPink"),Color("ColorPurple")], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            //MARK: -INTERFACE
            
            
            VStack(alignment: .center, spacing: 5) {
                LogoView()
                
                Spacer()
                
            //MARK: - SCORE
                
                HStack {
                    HStack{
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        Text(String(coins))
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack{
                        
                        Text(String(highScore))
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                    }
                    .modifier(ScoreContainerModifier())
                    
                    
                }
                .padding(.horizontal)
                
                
                
            //MARK: - SLOT MACHİNE
                
                VStack(alignment: .center, spacing: 0){
                    
                    
                    ZStack {
                        ReelView()
                        Image(symbols[slot1])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -50)
                            .animation(.easeOut(duration: Double.random(in: 0.5...0.7)))
                            .onAppear(perform: {
                                self.animatingSymbol.toggle()
                            })
                    }
                    
                    
                    HStack(alignment: .center,spacing: 0){
                        
                        ZStack {
                            ReelView()
                            Image(symbols[slot2])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)))
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                })
                        }
                        
                        
                        Spacer()
                        
                        ZStack {
                            ReelView()
                            Image(symbols[slot3])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)))
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                })
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    
                    Button(action: {
                        
                       
                        
                        slot1 = Int.random(in: 0...5)
                        slot2 = Int.random(in: 0...5)
                        slot3 = Int.random(in: 0...5)
                        
                        
                        self.checkWinning()
                        self.isGameOver()
                    })
                    {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    
                    
                    
                    
                }
                .layoutPriority(2)
                
                
            //MARK: - FOOTER
                Spacer()
                
                
                HStack{
                    
                    HStack(alignment: .center,spacing: 10 ) {
                        Button(action:{
                            activateBet20()
                        }){
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                       
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(betAmount == 20 ? 1 : 0)
                            .scaledToFit()
                            .frame(height: 64)
                            .animation(.default)
                            .modifier(ShadowModifier())
                           

                    }
                    
                    
                    HStack(alignment: .center,spacing: 10 ) {
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(betAmount == 10 ? 1 :0)
                            .scaledToFit()
                            .frame(height: 64)
                            .animation(.default)
                            .modifier(ShadowModifier())
                        
                        Button(action:{
                            self.activateBet10()
                        }){
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                       
                        
                       
                           

                    }
                }
                
            }
            .overlay(
             //RESET BUTTON
                Button(action:{
                    
                    self.resetGame()
                }){
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                .modifier(ButtonModifier()),
                alignment: .topLeading
                    
            )
            .overlay(
             //INFO BUTTON
                Button(action:{
                    self.showingInfoView = true
                   
                }){
                    Image(systemName: "info.circle")
                }
                .modifier(ButtonModifier()),
                alignment: .topTrailing
                    
            )
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
            
            
            
            //MARK: - POPUP
            
            if $showingModal.wrappedValue {
                
                ZStack{
                    Color("ColorTransparentBlack")
                        .ignoresSafeArea()
                    
                    
                    VStack{
                        
                        Text("Game Over")
                            .font(.system(.title,design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0,maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                        VStack(alignment: .center,spacing: 16){
                            Spacer()
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            
                            Text("Bad luck! You lost all of the coins. \nLet's play again!")
                                .font(.system(.body,design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)
                            
                            
                            Button(action:{
                                self.showingModal = false
                                self.coins = 100
                            }){
                                Text("New Game".uppercased())
                                    .font(.system(.body,design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal,12)
                                    .padding(.vertical,8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                    )
                                    
                            }
                            Spacer()
                        }
                        
                        
                    }
                    .frame(minWidth: 280,idealWidth: 280,maxWidth: 320,minHeight: 260,idealHeight: 280,maxHeight: 320,alignment: .center)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6, x:0,y:8 )
                }
                
            }
            
        }
        .sheet(isPresented: $showingInfoView){
            InfoView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
