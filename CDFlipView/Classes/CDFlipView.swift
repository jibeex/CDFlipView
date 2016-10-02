
import UIKit

public class CDMultipleLayerView: UIView{
    
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
            oneView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
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
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class CDFlipView: UIView {
    
    private(set) var activated = false
    private var multipleLayerView:CDMultipleLayerView?
    
    public var durationForOneTurnOver:Double = 0.5
    
    // The amount of time that the current layer stays still after
    // it is full presented, after which it will continune
    // to turn and change to the next layer
    public var stillTime:Double = 0.1
    
    public func setUp(views:[UIView]){
        
        if multipleLayerView?.superview != nil{
            multipleLayerView?.removeFromSuperview()
        }
        
        self.multipleLayerView = CDMultipleLayerView(frame: self.bounds, layers: views)
        self.multipleLayerView?.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        self.addSubview(self.multipleLayerView!)
    }
    
    public func startAnimation(){
        if !activated{
            activated = true
            // Need a small amount of time (0.05s) for loading
            rotateToSideAtIndex(0, duration: durationForOneTurnOver/2, goingIn: false, delay: stillTime + 0.05)
        }
    }
    
    public func stopAnimation(){
        if activated{
            activated = false
        }
    }
    
    private func rotateToSideAtIndex(index:Int, duration:Double, goingIn:Bool, delay:NSTimeInterval){
        
        self.multipleLayerView?.displayLayerAtIndex(index)
        
        if goingIn{
            UIView.animateWithDuration(duration/2, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.multipleLayerView?.alpha = 1
            }) { (complete) -> Void in
            }
        }
        else{
            UIView.animateWithDuration(duration/2, delay: delay + duration/2, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.multipleLayerView?.alpha = 0
            }) { (complete) -> Void in
            }
        }
        
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self.layer.transform = CATransform3DRotate(self.layer.transform, CGFloat(M_PI_2), 0, 1, 0)
            
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
