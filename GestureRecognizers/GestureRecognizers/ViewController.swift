//
//  ViewController.swift
//  GestureRecognizers
//
//  Created by Arun Sivakumar on 11/7/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var doubleTapView: UIView!
    @IBOutlet weak var longPressView: UIView!
    @IBOutlet weak var panView: UIView!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var pinchView: UIView!
    @IBOutlet weak var rotateView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapView.addGestureRecognizer(tapGesture)
        
        // Double Tap
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapView.addGestureRecognizer(doubleTapGesture)
        
        // Long Press
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        longPressView.addGestureRecognizer(longPressGesture)
        
        // Pan
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        panView.addGestureRecognizer(panGesture)
        
        // Swipe (right and left)
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(gesture:)))
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(gesture:)))
        swipeRightGesture.direction = UISwipeGestureRecognizerDirection.right
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.left
        swipeView.addGestureRecognizer(swipeRightGesture)
        swipeView.addGestureRecognizer(swipeLeftGesture)
        
        // Pinch
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(gesture:)))
        pinchView.addGestureRecognizer(pinchGesture)
        
        // Rotate
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(gesture:)))
        rotateView.addGestureRecognizer(rotateGesture)
        
    }
    
    // Tap action
    func handleTap() {
        label.text = "Tap recognized"
        
        // example task: change background color
        if tapView.backgroundColor == UIColor.blue {
            tapView.backgroundColor = UIColor.red
        } else {
            tapView.backgroundColor = UIColor.blue
        }
        
    }
    
    // Double tap action
    func handleDoubleTap() {
        label.text = "Double tap recognized"
        
        // example task: change background color
        if doubleTapView.backgroundColor == UIColor.yellow {
            doubleTapView.backgroundColor = UIColor.green
        } else {
            doubleTapView.backgroundColor = UIColor.yellow
        }
    }
    
    // Long press action
    func handleLongPress(gesture: UILongPressGestureRecognizer) {
        label.text = "Long press recognized"
        
        // example task: show an alert
        if gesture.state == UIGestureRecognizerState.began {
            let alert = UIAlertController(title: "Long Press", message: "Can I help you?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Pan action
    func handlePan(gesture: UIPanGestureRecognizer) {
        label.text = "Pan recognized"
        
        // example task: drag view
        let location = gesture.location(in: view) // root view
        panView.center = location
    }
    
    // Swipe action
    func handleSwipe(gesture: UISwipeGestureRecognizer) {
        label.text = "Swipe recognized"
        
        // example task: animate view off screen
        let originalLocation = swipeView.center
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            UIView.animate(withDuration: 0.5, animations: {
                self.swipeView.center.x += self.view.bounds.width
            }, completion: { (value: Bool) in
                self.swipeView.center = originalLocation
            })
        } else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            UIView.animate(withDuration: 0.5, animations: {
                self.swipeView.center.x -= self.view.bounds.width
            }, completion: { (value: Bool) in
                self.swipeView.center = originalLocation
            })
        }
    }
    
    // Pinch action
    func handlePinch(gesture: UIPinchGestureRecognizer) {
        label.text = "Pinch recognized"
        
        if gesture.state == UIGestureRecognizerState.changed {
            let transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
            pinchView.transform = transform
        }
    }
    
    // Rotate action
    func handleRotate(gesture: UIRotationGestureRecognizer) {
        label.text = "Rotate recognized"
        
        if gesture.state == UIGestureRecognizerState.changed {
            let transform = CGAffineTransform(rotationAngle: gesture.rotation)
            rotateView.transform = transform
        }
    }
}
