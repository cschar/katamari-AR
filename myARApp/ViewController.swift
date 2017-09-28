//
//  ViewController.swift
//  myARApp
//
//  Created by cody scharfe on 2017-09-27.
//  Copyright © 2017 cody scharfe. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    //to reference after init in constructor
    var treeNode: SCNNode?
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//        let scene = SCNScene(named: "art.scnassets/Lowpoly_tree_sample.dae")!
//        let scene = SCNScene(named: "art.scnassets/Lowpoly_tree_sample.scn")!
        let scene = SCNScene(named: "art.scnassets/test_asset_xcode.scn")!
        //scan through and grab mesh
        
        self.treeNode = scene.rootNode.childNode(withName: "Cyclinder_Flower_001", recursively: true)
//        self.treeNode = scene.rootNode.childNode(withName: "Tree_lp_11", recursively: true)
//        treeNode?.scale = SCNVector3Make(0.01, 0.01, 0.01)
        //treeNode?.scale = SCNVector3Make(1 , 1, 1.2)
        
        // point to user
        self.treeNode?.position = SCNVector3Make(0, 0, -2)
        
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            
            return }
        let results = sceneView.hitTest(touch.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
        
        print("GOt results")
        guard let hitFeature = results.last else { return }
        
        print("old position")
        print(self.treeNode?.position)

        let hitTransform = SCNMatrix4(hitFeature.worldTransform)
        let hitPosition = SCNVector3Make(hitTransform.m41,
                                         hitTransform.m42,
                                         hitTransform.m43)
        
        self.treeNode?.position = hitPosition;
        print("new position")
        print(self.treeNode?.position)

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
