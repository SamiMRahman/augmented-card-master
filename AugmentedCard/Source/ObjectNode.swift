//
//  ObjectNode.swift
//  AugmentedCard
//
//  Created by Rahman, Sami M on 7/22/19.
//  Copyright © 2019 Prayash Thapa. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit
import ARKit
import UIKit



open class ObjectNode: NSObject, ARSCNViewDelegate {
    public var objectName: String?
    public var objectSaving: Int!
    public var objectType: String?
//    public let validName: String?
    var detectedObject = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main)

    
    //if the image name of the detected object is equal to a name in the json file
    //we want to add all the info of that object into the xib file

    
    public init?(objectName: String?, objectSaving: Int?, objectType: String?, json:[String: Any]) {
        self.objectName = objectName
        self.objectSaving = objectSaving
        self.objectType = objectType
        self.detectedObject = Set<ARReferenceImage>()
    }
    
    
    
    func getInfo(detectedObject: ARReferenceImage) {
        if let path = Bundle.main.path(forResource: "LivingBuildingData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String: Any]] {
                    for var dict in jsonResult {
                        objectName = (dict["name"]) as? String
                        if detectedObject.name == objectName {
                            objectSaving = (dict["saving"]) as? Int
                            objectType = (dict["type"]) as? String
                        }
                    }
                }
            } catch {
                objc_exception_throw("Data does not exist!")
            }
        }
    }
    
    func createInfoView(width: CGFloat, height: CGFloat) -> SCNPlane? {
        guard let infoView: infoView = Bundle.main.loadNibNamed("infoView", owner: self, options: nil)?.first as? infoView else {return nil}
        
        infoView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        infoView.nameText.text = objectName
        infoView.saveText.text = String(objectSaving)
        infoView.typeText.text = objectType

        
        //infoView. (for now)
        
        UIGraphicsEndImageContext()
        let plane = SCNPlane(width: width / 10.0, height: height / 150.0)
        plane.firstMaterial!.diffuse.contents = UIGraphicsGetImageFromCurrentImageContext()
        plane.firstMaterial!.lightingModel = .constant
        
        return plane
    }
    
    
}
