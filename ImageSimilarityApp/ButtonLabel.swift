//
//  ButtonLabel.swift
//  ImageSimilarityApp
//
//  Created by Temiloluwa on 26/08/2022.
//
import Foundation
import SwiftUI
import UIKit


struct ButtonLabel: View {
    
    private let text: String
    private let background: Color
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            Text(text).font(.title).bold().foregroundColor(.white)
                
            
            Spacer()
            
            
        }.padding().background(background).cornerRadius(10)
        .frame(width: 200, height: 100)
    }
    init(text: String, background: Color) {
        
        self.text = text
        self.background = background
    }
    
}
