
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
    var durationForOneTurnOver:Double = 0.5
    
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
            rotateToSideAtIndex(0, duration: durationForOneTurnOver/2, goingIn: false, delay: 0.1)
        }
    }
    
    func stopAnimation(){
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
            
        }) { (complete) -> Void in
            
            if goingIn{
                if self.activated{
                    self.rotateToSideAtIndex(index, duration:duration, goingIn: !goingIn, delay: 0.05)
                }
                else{
                    self.multipleLayerView?.displayLayerAtIndex(0)
                }
            }
            else{
                self.rotateToSideAtIndex(index + 1, duration:duration, goingIn: true, delay: 0)
                
            }
        }
        
    }
    
    
}
