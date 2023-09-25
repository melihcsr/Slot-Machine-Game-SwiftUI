//
//  InfoView.swift
//  Slot Machine
//
//  Created by Melih Cesur on 24.09.2023.
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center,spacing: 10) {
            LogoView()
            
            
            Spacer()
            
            Form{
                
                Section(header:Text("About The application")){
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRowView(firstItem: "Platforms", secondItem:"iPhone, iPaad, Mac")
                    FormRowView(firstItem: "Developer", secondItem: "Melih Cesur")
                    FormRowView(firstItem: "Version", secondItem:"1.0.0")
                  
                    
                }
            }
            .font(.system(.body,design: .rounded))
        }
        .padding(.top,40)
        .overlay(
            Button(action:{
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark.circle")
                    .font(.title)
            }
                .padding(.top,30)
                .padding(.trailing,20)
                .accentColor(Color.secondary)
            
            ,alignment: .topTrailing
                
        )
    }
}

struct FormRowView: View {
    
    var firstItem: String
    var secondItem: String
    
    var body: some View {
        HStack{
            Text(firstItem)
                .foregroundColor(Color.gray)
            Spacer()
            Text(secondItem)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}


