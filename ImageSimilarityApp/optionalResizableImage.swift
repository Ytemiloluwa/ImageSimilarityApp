//
//  optionalResizableImage.swift
//  ImageSimilarityApp
//
//  Created by Temiloluwa on 26/08/2022.
//

import Foundation

import SwiftUI
import UIKit

struct optionalResizableImage: View {
    
    let image: UIImage?
    let placeholder: UIImage
    
    var body: some View {
        
        if let image = image {
            
            return Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }else {
            
            return Image(uiImage: placeholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

