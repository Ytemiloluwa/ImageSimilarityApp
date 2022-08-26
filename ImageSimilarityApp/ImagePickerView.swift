//
//  ImagePickerView.swift
//  ImageSimilarityApp
//
//  Created by Temiloluwa on 26/08/2022.
//

import Foundation
import SwiftUI
import UIKit


struct ImagePickerView: View {
    
    private let completion: (UIImage?) -> ()
    private var camera: Bool
    
    var body: some View {
        
       ImagePickerControllerWrapper(camera: camera, completion: completion)
    }
    
    init(camera: Bool = false, completion: @escaping (UIImage?) -> ()) {
        
        self.camera = camera
        self.completion = completion
    }
}


struct ImagePickerControllerWrapper: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    
    private(set) var selectedImage: UIImage?
    private(set) var cameraSource: Bool
    
    private let completion: (UIImage?) -> ()
    
    init(camera: Bool, completion: @escaping (UIImage?) -> ()) {
        
        self.cameraSource = camera
        self.completion = completion
        
    }
    
    func makeCoordinator() -> ImagePickerControllerWrapper.Coordinator {
        
        let coordinator = Coordinator(self)
        coordinator.completion = self.completion
        
        return coordinator
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let imagepickerController = UIImagePickerController()
        imagepickerController.delegate = context.coordinator
        imagepickerController.sourceType = cameraSource ? .camera : .photoLibrary
        
        return imagepickerController
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePickerControllerWrapper
        var completion : ((UIImage?) -> ())?
        
        init(_ imagePickerControllerWrapper: ImagePickerControllerWrapper) {
            
            self.parent = imagePickerControllerWrapper
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        print("Image Picker Complete")
        
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        picker.dismiss(animated: true)
        
        completion(selectedImage)
        
        
    }
    func imageControllerDidCancel(_ picker: UIImagePickerController) {
        
        print("Imagen Picker Cancel")
        picker.dismiss(animated: true)
        completion(nil)
        
        
    }
}
