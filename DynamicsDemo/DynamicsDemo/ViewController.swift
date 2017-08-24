//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by Arun Sivakumar on 11/10/16.
//  Copyright © 2016 Arun. All rights reserved.
//

//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by Lakshmi on 11/6/16.
//  Copyright © 2016 Lakshmicom.arunsivakumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    
    var collision: UICollisionBehavior!
    
    var square: UIView!
    var snap: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        square.backgroundColor = UIColor.gray
        view.addSubview(square)
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [square])
        animator.addBehavior(gravity)
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
        barrier.backgroundColor = UIColor.red
        view.addSubview(barrier)
        
        collision = UICollisionBehavior(items: [square])
        //        collision = UICollisionBehavior(items: [square, barrier])
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrier.frame))
        animator.addBehavior(collision)
        
        collision.collisionDelegate = self
        
        
        let itemBehaviour = UIDynamicItemBehavior(items: [square])
        itemBehaviour.elasticity = 0.6
        animator.addBehavior(itemBehaviour)
        
        
        
    }
    
    
    
    //    func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
    //        if (snap != nil) {
    //            animator.removeBehavior(snap)
    //        }
    //
    //        let touch = touches.anyObject() as! UITouch
    //        snap = UISnapBehavior(item: square, snapToPoint: touch.locationInView(view))
    //        animator.addBehavior(snap)
    //    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collisionBehavior(behavior: UICollisionBehavior!, beganContactForItem item: UIDynamicItem!, withBoundaryIdentifier identifier: NSCopying!, atPoint p: CGPoint) {
        print("Boundary contact occurred - \(identifier)")
        let collidingView = item as! UIView
        collidingView.backgroundColor = UIColor.yellow
        UIView.animate(withDuration: 0.3) {
            collidingView.backgroundColor = UIColor.gray
        }
    }
    
    func touchesEnded(touches: NSSet, withEvent event: UIEvent?) {
        if (snap != nil) {
            animator.removeBehavior(snap)
        }
        
        let touch = touches.anyObject() as! UITouch
        snap = UISnapBehavior(item: square, snapTo: touch.location(in: view))
        animator.addBehavior(snap)
    }
    
}


