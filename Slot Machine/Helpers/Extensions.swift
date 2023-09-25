//
//  Extensions.swift
//  Slot Machine
//
//  Created by Melih Cesur on 24.09.2023.
//

import Foundation
import SwiftUI



extension Text{
    
    func scoreLabelStyle() -> Text{
        self
            .foregroundColor(Color.white)
            .font(.system(size: 10,weight: .bold,design:.rounded))
    }
    
    func scoreNumberStyle() -> Text {
        self
            .foregroundColor(Color.white)
            .font(.system(.title,design: .rounded))
            .fontWeight(.heavy)
    }
}



