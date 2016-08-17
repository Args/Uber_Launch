//
//  UberView.m
//  Uber
//
//  Created by tih on 16/8/16.
//  Copyright © 2016年 TOSHIBA. All rights reserved.
//

#import "UberView.h"
#define THREE 3
@interface UberView()
@property (nonatomic,retain)CAShapeLayer *circleLayer;
@property (nonatomic,retain)CAShapeLayer *lineLayer;
@property (nonatomic,retain)CAShapeLayer *squareLayer;
@property (nonatomic,retain)CAShapeLayer *maskLayer;

@end
@implementation UberView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self addLayers];
    for (int i =0; i<10; i++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6*i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addTranslantion];

        });
    }
}
-(void)addLayers{
    _circleLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_circleLayer];
    CGFloat radius = 40;
    _circleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointZero radius:radius/2 startAngle:-M_PI_2 endAngle:3*M_PI_2 clockwise:YES].CGPath;
    _circleLayer.lineWidth = 40;

    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.strokeColor = [UIColor whiteColor].CGColor;
    
    
    _lineLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_lineLayer];
    _lineLayer.lineWidth = 5;
    _lineLayer.cornerRadius = 2;
    UIBezierPath *somePath = [[UIBezierPath alloc]init];
    [somePath moveToPoint:CGPointZero];
    [somePath addLineToPoint:CGPointMake(0, -40)];
    _lineLayer.path = somePath.CGPath;
    
    _lineLayer.strokeColor = [UIColor blackColor].CGColor;
    
    
    _squareLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_squareLayer];
    CGFloat length = 20;
    _squareLayer.frame = CGRectMake(-length/2, -length/2, length, length);
    _squareLayer.cornerRadius = 2;
    _squareLayer.allowsGroupOpacity = YES;
    _squareLayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:_squareLayer];
    
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.frame = CGRectMake(-radius, -radius, radius*2, radius*2);
    _maskLayer.allowsGroupOpacity = YES;
    _maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.mask = _maskLayer;
}
-(void)addTranslantion{
    CAKeyframeAnimation *stroke = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    stroke.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1.0 :0 :0.35 :1];
    stroke.duration =THREE;
    stroke.repeatCount = 1;
    stroke.values = @[@0.0,@2.0];
    stroke.keyTimes = @[@0.0,@2.0];
    stroke.removedOnCompletion = false;

    CABasicAnimation *degree45 = [CABasicAnimation animationWithKeyPath:@"transform"];
    degree45.timingFunction =[CAMediaTimingFunction functionWithControlPoints:1.0 :0 :0.35 :1];
    degree45.duration = THREE;
    CATransform3D starting = CATransform3DMakeRotation(-M_PI_4, 0, 0, 0.5);
    degree45.repeatCount = 1;
    degree45.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(starting, 0.25, 0.25, 1) ] ;
    degree45.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    degree45.removedOnCompletion = false;
    CAAnimationGroup *circleGroup = [CAAnimationGroup animation];
    circleGroup.animations = @[stroke,degree45];
    circleGroup.duration = 4;
    circleGroup.repeatCount =1;
    circleGroup.removedOnCompletion = false;
    circleGroup.fillMode = kCAFillModeBoth;
    
    [_circleLayer addAnimation:circleGroup forKey:@"circleGroup"];
    
    
    
    
    CAKeyframeAnimation *big = [CAKeyframeAnimation animationWithKeyPath:@"lineWidth"];
    big.values = @[@0,@5,@3];
    big.duration  = THREE;
    big.timingFunctions =@[[CAMediaTimingFunction functionWithControlPoints:1.0 :0 :0.35 :1],[CAMediaTimingFunction functionWithControlPoints: 0.65:0.0: 0.40: 1.0]];
    big.repeatCount = 1;
//    big.keyTimes = @[@0,@0.7,@2];
    big.removedOnCompletion = false;

    
    CAKeyframeAnimation *lineStroke = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    lineStroke.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1.0 :0 :0.35 :1];
    lineStroke.duration =1;
    lineStroke.beginTime = 3;
    lineStroke.repeatCount = 1;
    lineStroke.values = @[@1.0,@0.0];
    lineStroke.keyTimes = @[@0.0,@1.0];
    lineStroke.removedOnCompletion = false;
    
    
    CAKeyframeAnimation *lineDegree45 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    lineDegree45.timingFunction =[CAMediaTimingFunction functionWithControlPoints:1.0 :0 :0.35 :1];
    lineDegree45.values = @[[NSValue valueWithCATransform3D:CATransform3DScale(starting, 0.25, 0.25, 1) ] ,[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    //,[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.15, 0.15, 1)]
    lineDegree45.repeatCount = 1;
    lineDegree45.duration = THREE;
    lineDegree45.removedOnCompletion = false;
    
    CAKeyframeAnimation *opacitys = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacitys.timingFunction =[CAMediaTimingFunction functionWithControlPoints:1.0 :0 :0.35 :1];
    opacitys.duration = THREE;
    opacitys.values = @[@0.5,@1];
    opacitys.repeatCount = 1;
    opacitys.removedOnCompletion = false;

    CAAnimationGroup *lineGroup = [CAAnimationGroup animation];
    lineGroup.animations = @[big,lineStroke,lineDegree45,opacitys];
    lineGroup.duration = 4;
    lineGroup.repeatCount =1;
    lineGroup.removedOnCompletion = false;
    lineGroup.fillMode = kCAFillModeBoth;
    
    [_lineLayer addAnimation:lineGroup forKey:@"lineGroup"];
    
    
    
    
    
    
    
    
    CAKeyframeAnimation *sqBoundsAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
//    sqBoundsAnimation.timingFunction =[CAMediaTimingFunction functionWithControlPoints:1.0 :0 :0.35 :1];
    sqBoundsAnimation.duration =3;
    sqBoundsAnimation.values = @[[NSValue valueWithCGRect:CGRectMake(0, 0, 16, 16)],[NSValue valueWithCGRect:CGRectMake(0, 0, 20, 20)]];
   sqBoundsAnimation.keyTimes = @[@0,@1,@2];
    sqBoundsAnimation.removedOnCompletion = NO;
    sqBoundsAnimation.fillMode = kCAFillModeBoth;

    CAKeyframeAnimation *sqBoundsAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    //    sqBoundsAnimation.timingFunction =[CAMediaTimingFunction functionWithControlPoints:1.0 :0 :0.35 :1];
    sqBoundsAnimation2.duration =1;
    sqBoundsAnimation2.beginTime = 3;
    sqBoundsAnimation2.values = @[[NSValue valueWithCGRect:CGRectMake(0, 0, 20, 20)],[NSValue valueWithCGRect:CGRectMake(0, 0, 1, 1)]];
    sqBoundsAnimation2.removedOnCompletion = NO;
    sqBoundsAnimation2.fillMode = kCAFillModeBoth;
    
    
    CABasicAnimation *sqColor = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    sqColor.fromValue = (__bridge id _Nullable)([UIColor blackColor].CGColor);
    sqColor.toValue = (__bridge id _Nullable)([UIColor colorWithWhite:0.428 alpha:1.000].CGColor);
    sqColor.duration = 2;
    sqColor.beginTime =2;
    sqColor.fillMode = kCAFillModeBoth;

    CAAnimationGroup *sqgroup = [CAAnimationGroup animation];
    sqgroup.animations = @[sqBoundsAnimation,sqBoundsAnimation2,sqColor];
    sqgroup.duration = 4;
    sqgroup.repeatCount =1;
    sqgroup.removedOnCompletion = false;
    sqgroup.fillMode = kCAFillModeBoth;
    
    [_squareLayer addAnimation:sqgroup forKey:@"sqgroup"];
    
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 80, 80)];
    boundsAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 16, 16)];
    boundsAnimation.beginTime = 4-1;
    boundsAnimation.duration =1;
    boundsAnimation.timingFunction =[CAMediaTimingFunction functionWithControlPoints:1.0 :0 :0.35 :1];
    
    CABasicAnimation *corner = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    corner.beginTime = 3;
    corner.duration =1;
    corner.fromValue = @40;
    corner.toValue = @4;
    corner.timingFunction =[CAMediaTimingFunction functionWithControlPoints:1.0 :0 :0.35 :1];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[boundsAnimation,corner];
    group.duration = 4;
    group.repeatCount =1;
    group.removedOnCompletion = false;
    group.fillMode = kCAFillModeBoth;
    [_maskLayer addAnimation:group forKey:@"group"];
}







































@end
