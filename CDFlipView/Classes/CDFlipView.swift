
import UIKit

open class CDMultipleLayerView: UIView{
    
    fileprivate var candidateViews:[UIView]
    
    var layerCount:Int{
        get{
            return self.candidateViews.count
        }
    }
    
    init(frame: CGRect, layers:[UIView]) {
        self.candidateViews = layers
        super.init(frame: frame)
        
        for (_, oneView) in candidateViews.enumerated(){
            oneView.frame = self.bounds
            self.addSubview(oneView)
            oneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        self.displayLayerAtIndex(0)
    }
    
    func displayLayerAtIndex(_ index:Int){
        
        if layerCount == 0{
            return
        }
        
        if index < 0{
            return
        }
        
        let roundedIndex = index % layerCount
        
        for (index, view) in self.candidateViews.enumerated(){
            
            if roundedIndex == index{
                view.isHidden = false
            }
            else{
                view.isHidden = true
            }
        }
        
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class CDFlipView: UIView {
    
    fileprivate(set) var activated = false
    fileprivate var multipleLayerView:CDMultipleLayerView?
    
    open var durationForOneTurnOver:Double = 0.5
    
    // The amount of time that the current layer stays still after
    // it is full presented, after which it will continune
    // to turn and change to the next layer
    open var stillTime:Double = 0.1
    
    open func setUp(_ views:[UIView]){
        
        if multipleLayerView?.superview != nil{
            multipleLayerView?.removeFromSuperview()
        }
        
        self.multipleLayerView = CDMultipleLayerView(frame: self.bounds, layers: views)
        self.multipleLayerView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(self.multipleLayerView!)
    }
    
    open func startAnimation(){
        if !activated{
            activated = true
            // Need a small amount of time (0.05s) for loading
            rotateToSideAtIndex(0, duration: durationForOneTurnOver/2, goingIn: false, delay: stillTime + 0.05)
        }
    }
    
    open func stopAnimation(){
        if activated{
            activated = false
        }
    }
    
    fileprivate func rotateToSideAtIndex(_ index:Int, duration:Double, goingIn:Bool, delay:TimeInterval){
        
        self.multipleLayerView?.displayLayerAtIndex(index)
        
        if goingIn{
            UIView.animate(withDuration: duration/2, delay: delay, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                self.multipleLayerView?.alpha = 1
            }) { (complete) -> Void in
            }
        }
        else{
            UIView.animate(withDuration: duration/2, delay: delay + duration/2, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                self.multipleLayerView?.alpha = 0
            }) { (complete) -> Void in
            }
        }
        
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.layer.transform = CATransform3DRotate(self.layer.transform, CGFloat.pi / 2, 0, 1, 0)
            
        }) { [weak self](complete) -> Void in
            
            guard let _self = self else{
                return
            }
            
            if goingIn{
                if _self.activated{
                    _self.rotateToSideAtIndex(index, duration:duration, goingIn: !goingIn, delay: _self.stillTime)
                }
                else{
                    _self.multipleLayerView?.displayLayerAtIndex(0)
                }
            }
            else{
                _self.rotateToSideAtIndex(index + 1, duration:duration, goingIn: true, delay: 0)
                
            }
        }
        
    }
    
    
}
