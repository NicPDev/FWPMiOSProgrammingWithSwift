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
        showAlert("Button", message: "Button pressed")
        
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
        showAlert("Long press", message: "Longpressed")

    }
    
    @IBAction func swipeAction(sender: AnyObject) {
        println("Swipe Action")
        showAlert("Swipe", message: "Swiped")
    }
    

  
    
    func tappedView(tapSender: UITapGestureRecognizer) {
        println("Tap gedrückt")
       showAlert("Tap", message: "Tapped")
    }
    
    func panedView(panSender: UIPanGestureRecognizer) {
        println("Pan Gesture ausgeführt!")
         showAlert("Pan", message: "Panned")
    }
    
    
    func pinchedView(pinchSender: UIPinchGestureRecognizer) {
        self.view.bringSubviewToFront(pinchView)
        pinchSender.view!.transform = CGAffineTransformScale(pinchSender.view!.transform, pinchSender.scale, pinchSender.scale)
        pinchSender.scale = 1.0
        println("Pinch")
        
    }
    func showAlert(title: String!, message: String!) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "ok", style: .Destructive, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

