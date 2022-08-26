//
//  Similarity.swift
//  ImageSimilarityApp
//
//  Created by Temiloluwa on 26/08/2022.
//

import Foundation

import UIKit
import Vision

extension UIImage {
    
    // func to compare similiarity
    
    func similiarity(to image: UIImage) -> Float? {
        
        var similarity: Float = 0
        
        guard let firstImageFPO = self.featurePrintObservation() ,let secondImageFPO = image.featurePrintObservation(),
              let _ = try? secondImageFPO.computeDistance(&similarity, to: firstImageFPO) else {
            
            return nil
        }
        
        return similarity
    }
    
    // derive ImageSimilarity
    
    private func featurePrintObservation() -> VNFeaturePrintObservation? {
        
        guard let cgImage = self.cgImage else { return nil }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: self.imageOrientation, options: [:])
        
        let request = VNGenerateImageFeaturePrintRequest()
        
        if let _  = try? requestHandler.perform([request]),
            
            let result = request.results?.first as? VNFeaturePrintObservation {
            
            return result
        }
        
        return nil
        
    }
}

extension UIImage {
    
    var imageOrientation: CGImagePropertyOrientation {
        
        switch self.imageOrientation {
        
        case.up:
            return.up
        case.down:
            return.down
        case.left:
            return.left
        case.right:
            return.right
        case.upMirrored:
            return.upMirrored
        case.downMirrored:
            return.downMirrored
        case.leftMirrored:
            return.leftMirrored
        case.rightMirrored:
            return.rightMirrored
            
        }
    }
    
}
