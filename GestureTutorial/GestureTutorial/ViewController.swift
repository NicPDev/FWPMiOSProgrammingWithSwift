//
//  ViewController.swift
//  GestureTutorial
//
//  Created by student on 18.01.15.
//  Copyright (c) 2015 student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var panView: UIView!
    @IBOutlet weak var rotateView: UIView!
    @IBOutlet weak var pinchView: UIView!
    
    
    var lastRotation = CGFloat()
    let rotateRec = UIRotationGestureRecognizer()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "tappedView:")
        tapGesture.numberOfTapsRequired = 1
        tapView.addGestureRecognizer(tapGesture)
        
        
        var panGesture = UIPanGestureRecognizer(target: self, action: "panedView:")
        panView.addGestureRecognizer(panGesture)
        
        
        var pinchGesture = UIPinchGestureRecognizer(target: self, action: "pinchedView:")
        pinchView.addGestureRecognizer(pinchGesture)
        
    }
    @IBAction func button(sender: UIButton) {
        println("Button gedrückt")
        showAlert("Button", message: "Button Pressed")
        
    }
    
    
    @IBAction func rotateAction(sender: UIRotationGestureRecognizer) {
        var lastRotation = CGFloat()
        println("rotate")
        self.view.bringSubviewToFront(rotateView)
        if(sender.state == UIGestureRecognizerState.Ended){
            lastRotation = 0.0;
        }
        var rotation = 0.0 - (lastRotation - sender.rotation)
        var point = rotateRec.locationInView(rotateView)
        var currentTrans = sender.view?.transform
        var newTrans = CGAffineTransformRotate(currentTrans!, rotation)
        sender.view?.transform = newTrans
        lastRotation = sender.rotation
    }
    
    
    
    
    @IBAction func longPressAction(sender: AnyObject) {
        println("Long Press Action")
        showAlert("Long press", message: "Long Pressed")
        
    }
    
    @IBAction func swipeAction(sender: AnyObject) {
        println("Swipe Action")
        showAlert("Swipe", message: "View Swiped")
    }
    
    
    
    

    
    // function to show alert
    func showAlert(title: String!, message: String!) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "ok", style: .Destructive, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func tappedView(tapGesture: UITapGestureRecognizer) {
        println("Tap gedrückt")
        showAlert("Tap", message: "View tapped")
    }
    
    func panedView(panGesture: UIPanGestureRecognizer) {
        println("Pan Gesture ausgeführt!")
        showAlert("Pan", message: "View panned")
    }
    
    
    func pinchedView(pinchSender: UIPinchGestureRecognizer) {
        self.view.bringSubviewToFront(pinchView)
        pinchSender.view!.transform = CGAffineTransformScale(pinchSender.view!.transform, pinchSender.scale, pinchSender.scale)
        pinchSender.scale = 1.0
        println("Pinch")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

