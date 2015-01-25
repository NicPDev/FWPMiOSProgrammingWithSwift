//
//  ViewController.swift
//  GesturesTutorial
//
//  Created by student on 17.01.15.
//  Copyright (c) 2015 NicolasPfeuffer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tapView: UIView!
    
    @IBOutlet weak var pinchView: UIView!
    
    @IBOutlet weak var rotateView: UIView!
    
    @IBOutlet weak var panView: UIView!
    
    @IBOutlet weak var longPressView: UIView!
    
    @IBOutlet weak var swipeView: UIView!
    
    var lastRotation = CGFloat()
    let rotateRec = UIRotationGestureRecognizer()
    
    
    @IBAction func helloAction(sender: UIButton) {
        
        println("Hallo ich bin ein Button")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "tapView:")
        tapGesture.numberOfTapsRequired = 1
        tapView.addGestureRecognizer(tapGesture)
        
        
        var panGesture = UIPanGestureRecognizer(target: self, action: "panView:")
        panView.addGestureRecognizer(panGesture)
        
        
        var pinchGesture = UIPinchGestureRecognizer(target: self, action: "pinchView:")
        pinchView.addGestureRecognizer(pinchGesture)
        
      
    }
    
    
    @IBAction func pinchGestureAction(pinchSender: UIPinchGestureRecognizer) {
        
        self.view.bringSubviewToFront(pinchView)
        pinchSender.view!.transform = CGAffineTransformScale(pinchSender.view!.transform, pinchSender.scale, pinchSender.scale)
        pinchSender.scale = 1.0
        println("Pinch")
    }
    
    func tappedView(tapGestureRecognizer:UITapGestureRecognizer) {
        
        println("tap")
    
    }
    @IBAction func swipeGestureAction(sender: UISwipeGestureRecognizer) {
        println("swipe")
    }
    
    @IBAction func rotationGestureAction(sender: UIRotationGestureRecognizer) {
        println("rotate")
        
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
    @IBAction func panGestureAction(sender: UIPanGestureRecognizer) {
        
        println("pan")
    }
    
    @IBAction func longPressAction(sender: UILongPressGestureRecognizer) {
        
        println("longpress")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

