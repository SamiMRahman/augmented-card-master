//
//  ViewController+ARSCNViewDelegate.swift
//  AugmentedCard
//
//  Created by Prayash Thapa on 11/12/18.
//  Copyright © 2018 Prayash Thapa. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

extension ViewController: ARSCNViewDelegate {
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }

        updateQueue.async {
            let physicalWidth = imageAnchor.referenceImage.physicalSize.width
            let physicalHeight = imageAnchor.referenceImage.physicalSize.height

            // Create a plane geometry to visualize the initial position of the detected image
            let mainPlane = SCNPlane(width: physicalWidth, height: physicalHeight)
            mainPlane.firstMaterial?.colorBufferWriteMask = .alpha

            // Create a SceneKit root node with the plane geometry to attach to the scene graph
            // This node will hold the virtual UI in place
            let mainNode = SCNNode(geometry: mainPlane)
            mainNode.eulerAngles.x = -.pi / 2
            mainNode.renderingOrder = -1
            mainNode.opacity = 1

            // Add the plane visualization to the scene
            node.addChildNode(mainNode)
        
//        /*
//         Check To See Whether AN ARObject Anhcor Has Been Detected
//         Get The The Associated ARReferenceObject
//         Get The Name Of The ARReferenceObject
//         */
//        guard let objectAnchor = anchor as? ARObjectAnchor else { return }
//
//        let detectedObject = objectAnchor.referenceObject
//        guard let detectedObjectName = detectedObject.name else { return }
//
//        //Get The Extent & Center Of The ARReferenceObject
//        let detectedObjectExtent = detectedObject.extent
//        let detectedObjecCenter = detectedObject.center
//
//        //Log The Data
//        print("""
//            An ARReferenceObject Named \(detectedObjectName) Has Been Detected
//            The Extent Of The Object Is \(detectedObjectExtent)
//            The Center Of The Object Is \(detectedObjecCenter)
//            """)
//
//        //Create A Different Scene For Each Detected Object
//        node.addChildNode(createSKSceneForReferenceObject(detectedObject: detectedObject))
//
//        // Animate the WebView to the right
        
            // Perform a quick animation to visualize the plane on which the image was detected.
            // We want to let our users know that the app is responding to the tracked image.
        self.highlightDetection(on: mainNode, width: physicalWidth, height: physicalHeight, completionHandler: {
                
                // Introduce virtual content
//                self.displayDetailView(on: mainNode, xOffset: physicalWidth)
//
//                // Animate the WebView to the right
//                self.displayWebView(on: mainNode, xOffset: physicalWidth)
        
        })
    }
}

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    // MARK: - SceneKit Helpers
    
//    func displayDetailView(on rootNode: SCNNode, xOffset: CGFloat) {
//        let detailPlane = SCNPlane(width: xOffset, height: xOffset * 1.4)
//        detailPlane.cornerRadius = 0.25
//
//        let detailNode = SCNNode(geometry: detailPlane)
//        detailNode.geometry?.firstMaterial?.diffuse.contents = SKScene(fileNamed: "DetailScene")
//
//        // Due to the origin of the iOS coordinate system, SCNMaterial's content appears upside down, so flip the y-axis.
//        detailNode.geometry?.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)
//        detailNode.position.z -= 0.5
//        detailNode.opacity = 0
//
//        rootNode.addChildNode(detailNode)
//        detailNode.runAction(.sequence([
//            .wait(duration: 1.0),
//            .fadeOpacity(to: 1.0, duration: 1.5),
//            .moveBy(x: xOffset * -1.1, y: 0, z: -0.05, duration: 1.5),
//            .moveBy(x: 0, y: 0, z: -0.05, duration: 0.2)
//            ])
//        )
//
//        //Create A Different Scene For Each Detected Object
////        rootNode.addChildNode(createSKSceneForReferenceObject(detectedObject: detectedObject))
//    }
    
    func createSKSceneForReferenceObject(detectedObject: ARReferenceObject) -> SCNNode{
        
        let plane = SCNPlane(width: CGFloat(detectedObject.extent.x * 1.0),
                             height: CGFloat(detectedObject.extent.y * 0.7))
        
        plane.cornerRadius = plane.width / 8
        
        guard let validName = detectedObject.name else { return SCNNode() }
        
        let spriteKitScene = SKScene(fileNamed: validName)
        
        plane.firstMaterial?.diffuse.contents = spriteKitScene
        plane.firstMaterial?.isDoubleSided = true
        plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3Make(detectedObject.center.x, detectedObject.center.y, detectedObject.center.z) // was detectedObject.center.y + 0.5
        //HOW TO HAVE LABEL NODE CONNECTED TO A WEBSITE API
        //LIKE: "This water system (decreased/increased) water usage by (insert daily website data)!
        
//        self.displayWebView(on: planeNode, xOffset: 3) // offset was 7
        
        return planeNode
    }
    
//    func displayWebView(on rootNode: SCNNode, xOffset: CGFloat) {
//        // Xcode yells at us about the deprecation of UIWebView in iOS 12.0, but there is currently
//        // a bug that does now allow us to use a WKWebView as a texture for our webViewNode
//        // Note that UIWebViews should only be instantiated on the main thread!
//        DispatchQueue.main.async {
//            let request = URLRequest(url: URL(string: "https://kendedafund.org/grantee/embracing-the-living-building-challenge/")!)
//            let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 400, height: 672))
//            webView.loadRequest(request)
//
//            let webViewPlane = SCNPlane(width: xOffset, height: xOffset * 1.4)
//            webViewPlane.cornerRadius = 0.25
//
//            let webViewNode = SCNNode(geometry: webViewPlane)
//            webViewNode.geometry?.firstMaterial?.diffuse.contents = webView
//            webViewNode.position.z -= 0.5
//            webViewNode.opacity = 0
//
//            rootNode.addChildNode(webViewNode)
//            webViewNode.runAction(.sequence([
//                .wait(duration: 3.0),
//                .fadeOpacity(to: 1.0, duration: 1.5),
//                .moveBy(x: xOffset * 1.1, y: 0, z: -0.05, duration: 1.5),
//                .moveBy(x: 0, y: 0, z: -0.05, duration: 0.2)
//                ])
//            )
//        }
//    }
    
    func highlightDetection(on rootNode: SCNNode, width: CGFloat, height: CGFloat, completionHandler block: @escaping (() -> Void)) {
        let planeNode = SCNNode(geometry: SCNPlane(width: width, height: height))
        planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        planeNode.position.z += 0.1
        planeNode.opacity = 0

        rootNode.addChildNode(planeNode)
        planeNode.runAction(self.imageHighlightAction) {
            block()
        }
        setupNavBarButton()
        infoLauncher()
        
    }

    var imageHighlightAction: SCNAction {
        setupNavBarButton()
        return .sequence([
            .wait(duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOpacity(to: 0.15, duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOut(duration: 0.5),
            .removeFromParentNode()
            ])
    }
    
    func setupNavBarButton() {
        let infoButton = UIBarButtonItem(image: UIImage(named:
            "infoButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
    }
    
    class infoLauncher {
        let infoLauncher = InfoLauncher()
    }
    
    @objc func handleMore() {
        infoLauncher().infoLauncher.showInfo()
        
    }
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        if let infoView2 = Bundle.main.loadNibNamed("infoView", owner: self, options: nil)?.first as? infoView {
            self.view.addSubview(infoView2)
        }
    }



}
