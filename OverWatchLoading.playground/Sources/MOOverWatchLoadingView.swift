import UIKit

public class MOOverWatchLoadingView: UIView {
    private var outerCircleShape: CAShapeLayer!
    private var circleMask: CAShapeLayer!

    @IBInspectable var circleColor: UIColor! = UIColor(red: 255/255, green: 172/255, blue: 51/255, alpha: 1.0) {
        didSet {
            outerCircleShape.fillColor = circleColor.CGColor
        }
    }

    private var hexagonShapes: [CAShapeLayer]!
    private var curveShapes: [CAShapeLayer]!
    private var innerCircleShape: CAShapeLayer!

    private var hexagonTransforms: [CAKeyframeAnimation]!
    private let curveRotationTransform = CABasicAnimation(keyPath: "transform.rotation")
    private let circleTransform = CAKeyframeAnimation(keyPath: "transform")
    private let innerCircleLineStrokeStart = CAKeyframeAnimation(keyPath: "strokeStart")
    private let innerCircleLineStrokeEnd = CAKeyframeAnimation(keyPath: "strokeEnd")

    @IBInspectable var duration: Double = 2.0 {
        didSet {
            circleTransform.duration = 0.5 * duration // 0.0333 * 10
        }
    }

    public convenience init() {
        self.init(frame: CGRect.zero)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        createLayers()
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createLayers()
    }

    private func createLayers() {
        self.backgroundColor = UIColor(red:0.62, green:0.77, blue:0.97, alpha:1.00)
        let circleLineWidth: CGFloat = frame.width/50
        let curveLineWidth: CGFloat = circleLineWidth/2

        let lineMargin = circleLineWidth + curveLineWidth*3

        let _frame = CGRect(x: 0, y: 0, width: bounds.width/5 - lineMargin, height: bounds.width/5 - lineMargin)
        let x = _frame.width / 2 / 2 * sqrt(3.0)

        //===============
        // hexagon layer
        //===============
        let hexagonPath = UIBezierPath()
        hexagonPath.moveToPoint(CGPoint(x: x, y: 0))
        hexagonPath.addLineToPoint(CGPoint(x: 0, y: _frame.size.height/4))
        hexagonPath.addLineToPoint(CGPoint(x: 0, y: _frame.size.height/4*3))
        hexagonPath.addLineToPoint(CGPoint(x: x, y: _frame.size.height))
        hexagonPath.addLineToPoint(CGPoint(x: x*2, y: _frame.size.height/4*3))
        hexagonPath.addLineToPoint(CGPoint(x: x*2, y: _frame.size.height/4))
        hexagonPath.addLineToPoint(CGPoint(x: x, y: 0))
        hexagonPath.closePath()

        hexagonShapes = (0 ..< 7).map { _ in
            let hexagonShape = CAShapeLayer()
            hexagonShape.frame = CGRect(x: 0, y: 0, width: x * 2, height: _frame.size.height)
            hexagonShape.fillColor = UIColor.whiteColor().CGColor
            hexagonShape.masksToBounds = true
            hexagonShape.path = hexagonPath.CGPath
            hexagonShape.strokeColor = UIColor.whiteColor().CGColor
            return hexagonShape
        }

        hexagonShapes.forEach {
            self.layer.addSublayer($0)
        }

        let margin = 4
        let _center = CGPoint(x: self.center.x, y: self.center.x)
        hexagonShapes[0].frame.origin = CGPoint(x: _center.x + CGFloat(margin/2),
                                                y: _center.y - _frame.height/2 - CGFloat(margin) - (_frame.height/4*3))
        hexagonShapes[1].frame.origin = CGPoint(x: _center.x + CGFloat(margin) + x,
                                                y: _center.y - _frame.height/2)
        hexagonShapes[2].frame.origin = CGPoint(x: _center.x + CGFloat(margin/2),
                                                y: _center.y + _frame.height/4 + CGFloat(margin))
        hexagonShapes[3].frame.origin = CGPoint(x: _center.x - x * 2 - CGFloat(margin/2),
                                                y: _center.y + _frame.height/4 + CGFloat(margin))
        hexagonShapes[4].frame.origin = CGPoint(x: _center.x - (x * 3) - CGFloat(margin),
                                                y: _center.y - _frame.height/2)
        hexagonShapes[5].frame.origin = CGPoint(x: _center.x - x * 2 - CGFloat(margin/2),
                                                y: _center.y - _frame.height/2 - CGFloat(margin) - (_frame.height/4*3))
        hexagonShapes[6].frame.origin = CGPoint(x: _center.x - x,
                                                y: _center.y - _frame.height/2)


        let hexagonAnimationDuration = duration * 1.5
        hexagonTransforms = hexagonShapes.map { _ in
            let ani = CAKeyframeAnimation(keyPath: "transform")
            ani.duration = hexagonAnimationDuration
            ani.repeatCount = .infinity
            ani.values = [
                NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)),
                NSValue(CATransform3D: CATransform3DMakeScale(0.0, 0.0, 1.0)),
                NSValue(CATransform3D: CATransform3DMakeScale(0.0, 0.0, 1.0)),
                NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)),
                NSValue(CATransform3D: CATransform3DIdentity)
            ]
            return ani
        }

        hexagonTransforms[0].keyTimes = [
            0.0,    //  0/15
            0.066,  //  1/15
            0.466,  //  7/15
            0.533,  //  8/15
            0.600   //  9/15
        ]

        hexagonTransforms[1].keyTimes = [
            0.066,  //  1/15
            0.133,  //  2/15
            0.533,  //  8/15
            0.600,  //  9/15
            0.667   //  10/15
        ]

        hexagonTransforms[2].keyTimes = [
            0.133,  //  2/15
            0.200,  //  3/15
            0.600,  //  9/15
            0.667,  //  10/15
            0.733   //  11/15
        ]

        hexagonTransforms[3].keyTimes = [
            0.200,  //  3/15
            0.266,  //  4/15
            0.667,  //  10/15
            0.733,  //  11/15
            0.800   //  12/15
        ]

        hexagonTransforms[4].keyTimes = [
            0.266,  //  4/15
            0.333,  //  5/15
            0.733,  //  11/15
            0.800,  //  12/15
            0.866   //  13/15
        ]

        hexagonTransforms[5].keyTimes = [
            0.333,  //  5/15
            0.400,  //  6/15
            0.800,  //  12/15
            0.866,  //  13/15
            0.933   //  14/15
        ]

        hexagonTransforms[6].keyTimes = [
            0.400,  //  6/15
            0.466,  //  7/15
            0.866,  //  13/15
            0.933,  //  14/15
            1.000   //  15/15
        ]

        CATransaction.begin()

        CATransaction.commit()


        //===============
        // outer circle layer
        //===============
        let rectForRing = bounds.insetBy(dx: circleLineWidth, dy: circleLineWidth)
        outerCircleShape = CAShapeLayer()
        outerCircleShape.frame = bounds
        outerCircleShape.masksToBounds = true
        outerCircleShape.strokeColor = UIColor(red:0.71, green:0.85, blue:1.00, alpha:1.00).CGColor
        outerCircleShape.path = CGPathCreateWithEllipseInRect(rectForRing, nil)
        outerCircleShape.fillColor = UIColor.clearColor().CGColor
        outerCircleShape.lineWidth = circleLineWidth
        self.layer.addSublayer(outerCircleShape)


        //===============
        // curve layer
        //===============
        let curveAngle = M_PI_2/3   // 30 degree
        let arcPath1 = UIBezierPath()
        arcPath1.addArcWithCenter(_center,
                                  radius: _center.x-circleLineWidth - curveLineWidth * 3,
                                  startAngle: CGFloat(M_PI * 3 / 2 - curveAngle),
                                  endAngle: CGFloat(M_PI * 3 / 2 + curveAngle),
                                  clockwise: true)

        let arcPath2 = UIBezierPath()
        arcPath2.addArcWithCenter(_center,
                                  radius: _center.x-circleLineWidth - curveLineWidth * 3,
                                  startAngle: 0,
                                  endAngle: CGFloat(curveAngle * 2),
                                  clockwise: true)

        let arcPath3 = UIBezierPath()
        arcPath3.addArcWithCenter(_center,
                                  radius: _center.x-circleLineWidth - curveLineWidth * 3,
                                  startAngle: CGFloat(M_PI - curveAngle * 2),
                                  endAngle: CGFloat(M_PI),
                                  clockwise: true)


        curveShapes = [arcPath1, arcPath2, arcPath3].map { path in
            let curveShape = CAShapeLayer()
            curveShape.frame = bounds
            curveShape.masksToBounds = true
            curveShape.strokeColor = UIColor(red:0.71, green:0.85, blue:1.00, alpha:1.00).CGColor
            curveShape.path = path.CGPath
            curveShape.fillColor = UIColor.clearColor().CGColor
            curveShape.lineWidth = curveLineWidth
            return curveShape
        }

        curveShapes.forEach {
            layer.addSublayer($0)
        }

        curveRotationTransform.fromValue = 0.0
        curveRotationTransform.toValue = CGFloat(M_PI * 2.0)
        curveRotationTransform.duration = duration
        curveRotationTransform.repeatCount = .infinity


        //===============
        // inner circle layer
        //===============
        let innerCirclePath = UIBezierPath()
        innerCirclePath.addArcWithCenter(_center,
                                         radius: _center.x - _frame.height,
                                         startAngle: CGFloat(M_PI * 3 / 2),
                                         endAngle: CGFloat(M_PI * 3 / 2 + M_PI * 2),
                                         clockwise: true)

        innerCircleShape = CAShapeLayer()
        innerCircleShape.frame = bounds
        innerCircleShape.masksToBounds = true
        innerCircleShape.path = innerCirclePath.CGPath
        innerCircleShape.strokeColor = UIColor(red:0.71, green:0.85, blue:1.00, alpha:1.00).CGColor
        innerCircleShape.fillColor = UIColor.clearColor().CGColor
        innerCircleShape.lineWidth = curveLineWidth * 1.5
        innerCircleShape.strokeStart = 0
        innerCircleShape.strokeEnd = 1
        self.layer.addSublayer(innerCircleShape)

        [innerCircleLineStrokeStart, innerCircleLineStrokeEnd].forEach {
            $0.repeatCount = .infinity
            $0.duration = duration
        }
        innerCircleLineStrokeStart.values = [
            0.0,
            0.0,
            0.1,
            0.2,
            0.3,
            0.4,
            0.5,
            0.6,
            0.7,
            0.8,
            0.9,
            1.0
        ]

        innerCircleLineStrokeStart.keyTimes = [
            0.0,
            0.5,
            0.55,
            0.6,
            0.65,
            0.7,
            0.75,
            0.8,
            0.85,
            0.9,
            0.95,
            1.0
        ]

        innerCircleLineStrokeEnd.values = [
            0.0,
            0.1,
            0.2,
            0.3,
            0.4,
            0.5,
            0.6,
            0.7,
            0.8,
            0.9,
            1.0
        ]

        innerCircleLineStrokeEnd.keyTimes = [
            0.0,
            0.05,
            0.1,
            0.15,
            0.2,
            0.25,
            0.3,
            0.35,
            0.4,
            0.45,
            0.5,
            1.0
        ]

        startAnimation()
    }

    func startAnimation() {
        CATransaction.begin()
        innerCircleShape.addAnimation(innerCircleLineStrokeStart, forKey: "strokeStart")
        innerCircleShape.addAnimation(innerCircleLineStrokeEnd, forKey: "strokeEnd")
        curveShapes.forEach {
            $0.addAnimation(curveRotationTransform, forKey: nil)
        }
        hexagonShapes.enumerate().forEach { (idx, shape) in
            shape.addAnimation(hexagonTransforms[idx], forKey: "transform")
        }
        CATransaction.commit()
    }
    
    func stopAnimation() {
        innerCircleShape.removeAllAnimations()
        curveShapes.forEach {
            $0.removeAllAnimations()
        }
        hexagonShapes.forEach {
            $0.removeAllAnimations()
        }
    }
}
