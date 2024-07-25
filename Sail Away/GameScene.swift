//
//  GameScene.swift
//  Sail Away
//
//  Created by Patrick Wheeler on 7/24/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Variables for wind and ship properties
    var windSpeed: CGFloat = 5.0 // Example value
    var windDirection: CGFloat = 0.0 // Angle in radians
    var shipSpeed: CGFloat = 0.0
    var shipDirection: CGFloat = 0.0 // Angle in radians
    
    // Ship node
    let shipNode = SKShapeNode()
    
    override func didMove(to view: SKView) {
        
        // Set up the background color
        self.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 0.6, alpha: 1.0) // Blueish-teal color
        
        // Set up the ship node
        let shipPath = CGMutablePath()
        shipPath.move(to: CGPoint(x: 0, y: 25)) // Pointed front
        shipPath.addCurve(to: CGPoint(x: -5, y: -25), control1: CGPoint(x: -12, y: 10), control2: CGPoint(x: -12, y: -10))
        shipPath.addLine(to: CGPoint(x: 5, y: -25))
        shipPath.addCurve(to: CGPoint(x: 0, y: 25), control1: CGPoint(x: 12, y: -10), control2: CGPoint(x: 12, y: 10))
        
        shipPath.closeSubpath()
        
        shipNode.path = shipPath
        shipNode.fillColor = UIColor(hue: 0.125, saturation: 0.48, brightness: 0.78, alpha: 1.0) // Fill color #c6af67
            //    https://www.ralfebert.com/ios/swift-uikit-uicolor-picker/
        shipNode.strokeColor = .white // Edge (stroke) color
        shipNode.lineWidth = 2 // Width of the stroke
        shipNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(shipNode)
        
        // Add touch gesture recognizers
        let leftTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleLeftTap(_:)))
        leftTapRecognizer.numberOfTouchesRequired = 1
        leftTapRecognizer.allowedTouchTypes = [NSNumber(value: UITouch.TouchType.direct.rawValue)]
        view.addGestureRecognizer(leftTapRecognizer)
        
        let rightTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleRightTap(_:)))
        rightTapRecognizer.numberOfTouchesRequired = 1
        rightTapRecognizer.allowedTouchTypes = [NSNumber(value: UITouch.TouchType.direct.rawValue)]
        view.addGestureRecognizer(rightTapRecognizer)
    }
    
    @objc func handleLeftTap(_ sender: UITapGestureRecognizer) {
        // Rotate ship to the left
        shipDirection -= CGFloat.pi / 16
        updateShipRotation()
    }
    
    @objc func handleRightTap(_ sender: UITapGestureRecognizer) {
        // Rotate ship to the right
        shipDirection += CGFloat.pi / 16
        updateShipRotation()
    }
    
    func updateShipRotation() {
        shipNode.zRotation = shipDirection
    }

    
    /*
     
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
     
    */
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Calculate new ship position based on its speed and direction
        let dx = shipSpeed * cos(shipDirection)
        let dy = shipSpeed * sin(shipDirection)
        
        shipNode.position = CGPoint(x: shipNode.position.x + dx, y: shipNode.position.y + dy)
            
    }
}
