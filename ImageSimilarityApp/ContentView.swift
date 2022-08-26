//
//  ContentView.swift
//  ImageSimilarityApp
//
//  Created by Temiloluwa on 26/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var imagePickerOpen: Bool = false
    @State private var cameraOpen: Bool = false
    @State private var firstImage: UIImage? = nil
    @State private var secondImage: UIImage? = nil
    @State private var similarity: Int = -1
    
    private let placeholderImage = UIImage(named: "London")!
    private var cameraEnabled: Bool {
        
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    private var selectedEnabled: Bool {
        
        secondImage == nil
    }
    
    private var comparisonEnabled: Bool {
        
        secondImage != nil && similarity < 0
    }
    var body: some View {
        
        if imagePickerOpen {
            
            return AnyView(ImagePickerView { result in
                
                self.controlReturned(image: result)
                self.imagePickerOpen = false
                
            })
        }else if cameraOpen {
            
            return AnyView(ImagePickerView(camera: true) { result in
                
                self.controlReturned(image: result)
                self.cameraOpen = false
            })
            
        } else {
            
            return AnyView(NavigationView {
                
                VStack {
                    
                    HStack {
                        
                        optionalResizableImage(image: firstImage, placeholder: placeholderImage)
                        
                        optionalResizableImage(image: secondImage, placeholder: placeholderImage)
                        
                    }
                    
                    Button(action: clearImages) {
                        
                        Text("Clear images")
                            .font(.title)
                            .foregroundColorgradient(color: [Color.blue, Color.green])
                    }
                    
                    Spacer()
                    
                    Text("Similarity: " + "\(similarity > 0 ? String(similarity): "...")%").font(.title).bold()
                        .foregroundColorgradient(color: [Color.blue, Color.green])
                    
                    Spacer()
                    
                    if comparisonEnabled {
                        
                        Button(action: getSimilarity) {
                            
                            ButtonLabel(text: "Compare", background: .blue)
                            
                        }//.disabled(comparisonEnabled)
                    }else {
                        
                        Button(action: getSimilarity) {
                            
                            ButtonLabel(text: "Compare", background: .gray)
                            
                        }//.disabled(comparisonEnabled)
                    }
                }
                .padding()
                .navigationBarTitle(Text("ISDEMO"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: summonImagePicker) {
                    
                    Text("Select")
                    
                }.disabled(!selectedEnabled), trailing: Button(action: summonCamera) {
                    
                    Image(systemName: "camera")
                }.disabled(!cameraEnabled))
                
            })
        }
    }
    
    private func clearImages() {
        
        firstImage = nil
        
        secondImage = nil
        
        similarity = -1
        
    }
    
    private func getSimilarity() {
        
        print("Getting Similarity...")
        
        if let firstImage = firstImage, let secondImage = secondImage,
           
           let similarityMeasure = firstImage.similiarity(to: secondImage) {
            
            
            similarity = Int(similarityMeasure)
        }else {
            
            similarity = 0
        }
        print("Similarity: \(similarity)")
    }
    
    private func controlReturned(image: UIImage?) {
        
        print("Image return \(image == nil ? "failure" : "success")...")
        
        if firstImage == nil {
            
            firstImage = image?.fixorientation()
        }else {
            
            secondImage = image?.fixorientation()
        }
    }
    
    private func summonImagePicker() {
        
        print("summoning ImagePicker...")
        imagePickerOpen = true
    }
    
    private func summonCamera() {
        
        print("Summoning Camera")
        
        cameraOpen = true
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View {

    public func foregroundColorgradient(color: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: color), startPoint: .topTrailing, endPoint: .bottomLeading))
            .mask(self)
    }
}
