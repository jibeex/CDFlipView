//
//  FlipMultipleViews.swift
//  The Report
//
//  Created by jibeex on 1/18/16

import UIKit

class CDMultipleLayerView: UIView{
    
    private var candidateViews:[UIView]
    
    var layerCount:Int{
        get{
            return self.candidateViews.count
        }
    }
    
    init(frame: CGRect, layers:[UIView]) {
        self.candidateViews = layers
        super.init(frame: frame)
        
        for (_, oneView) in candidateViews.enumerate(){
            oneView.frame = self.bounds
            self.addSubview(oneView)
        }
        
        self.displayLayerAtIndex(0)
    }
    
    func displayLayerAtIndex(index:Int){
        
        if layerCount == 0{
            return
        }
        
        if index < 0{
            return
        }
        
        let roundedIndex = index % layerCount
        
        for (index, view) in self.candidateViews.enumerate(){
            
            if roundedIndex == index{
                view.hidden = false
            }
            else{
                view.hidden = true
            }
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CDFlipView: UIView {
    
    var multipleLayerView:CDMultipleLayerView?
    var activated = false
    var durationForOneTurnOver:Double = 0.7
    
    func setUp(views:[UIView]){
        
        if multipleLayerView?.superview != nil{
            multipleLayerView?.removeFromSuperview()
        }
        
        self.multipleLayerView = CDMultipleLayerView(frame: self.bounds, layers: views)
        
        self.addSubview(self.multipleLayerView!)
    }
    
    func startAnimation(){
        if !activated{
            activated = true
            rotateToSideAtIndex(CGFloat(M_PI_2), index: 0, duration: durationForOneTurnOver/2, infinitely: true)
        }
    }
    
    func stopAnimation(){
        if activated{
            activated = false
        }
    }
    
    private func rotateToSideAtIndex(radial:CGFloat, index:Int, duration:Double, infinitely:Bool){
        
        self.multipleLayerView?.displayLayerAtIndex(index)
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self.layer.transform = CATransform3DRotate(self.layer.transform, radial, 0, 1, 0)
            }) { (complete) -> Void in
                if infinitely{
                    if self.activated{
                        self.rotateToSideAtIndex(CGFloat(M_PI), index: index + 1, duration: self.durationForOneTurnOver, infinitely: true)
                    }
                    else{
                        self.rotateToSideAtIndex(CGFloat(M_PI_2), index: 0, duration: self.durationForOneTurnOver/2, infinitely: false)

                    }
                }
                
                
        }
        
    }
    
    
}
