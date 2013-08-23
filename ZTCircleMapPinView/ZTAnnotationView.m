//
//  ZTAnnotationView.m
//  ZTCircleAnnotationView
//
//  Created by Zacks Tsang  on 13-8-21.
//  Copyright (c) 2013年 www.aiysea.com. All rights reserved.
//

#import "ZTAnnotationView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+ZTHelper.h"

#define ANGLE_TO_PI M_PI/180
#define SPEEDTIME M_1_PI/2

#define RADIUS 30.0f

@implementation ZTAnnotationView
@synthesize contentView;


- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.canShowCallout = NO;
        self.frame = [[UIScreen mainScreen] bounds];
        
        
        _radius=RADIUS;
        
         _center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
    return self;
    
    
}


-(void)addCenterView:(UIView *)centerView andRadius:(float)radius{
    
    if (self.contentView) {
        [self.contentView removeFromSuperview];
        [_line removeFromSuperview];
    }
    
    _radius=radius;
    
    _line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 2*_radius)];
    
    _line.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2+_radius/2-10);
    
    _line.backgroundColor=[UIColor whiteColor];
    
    [self addSubview:_line];
    _line.layer.anchorPoint=CGPointMake(0.0, 0.0);
    
    
    
    
   
    centerView.backgroundColor   = [UIColor clearColor];
    
    centerView.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2-_radius/2-centerView.frame.size.height/2);
    
    [self addSubview:centerView];
    self.contentView = centerView;
    
   
    
    
    _startAngle=270*ANGLE_TO_PI;
    _line.transform = CGAffineTransformMakeRotation(180*ANGLE_TO_PI);
    
}


- (void)drawRect:(CGRect)rect
{

}


- (void)turn:(BOOL)isWise durtime:(CGFloat)time{
    
    [self animationOfRoundView:contentView center:_center radius:self.contentView.frame.size.width/2.0+_radius startAgngle:_startAngle endAgngle:_endAngle clockwise:isWise duration:time];
    
    [self rotateLine:time];
    
}

-(void)turnByAngel:(float)angel{
    
    _endAngle=angel*ANGLE_TO_PI;
    
    BOOL isWise=_startAngle>_endAngle?YES:NO;
    
    if (fabs(_startAngle-_endAngle)>M_PI) {
        if (_startAngle-_endAngle>0) {
            isWise=NO;
        }else{
            isWise=YES;
        }
    }
    
    [self turn:isWise durtime:SPEEDTIME];
    
    
    if (fabs(_startAngle-_endAngle)>M_PI_2) {
        double delayInSeconds = SPEEDTIME+0.02;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            _endAngle=(5*(!isWise?-1:1)+angel)*ANGLE_TO_PI;
            
            
            [self turn:!isWise durtime:0.1];
            
            double delayInSeconds = .1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                _endAngle=(5*(isWise?-1:1)+angel)*ANGLE_TO_PI;
                
                
                [self turn:isWise durtime:0.1];
                
                
                
                
            });
            
        });
        
    }
    
    
}

- (void)hiddenView {
    _line.alpha=0;
    contentView.alpha=0;
}

-(void)showByAngle:(float)angel{
    
    self.isDismiss=NO;
    
    [self turnByAngel:angel];
    
    double delayInSeconds = SPEEDTIME+0.02;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        CGPoint centerPoint=self.contentView.center;
        
        self.contentView.center=_center;
        
        
        [self.contentView fix2ScaleView:0.1];
        
        self.contentView.alpha=1;
        
        [UIView animateWithDuration:SPEEDTIME animations:^{
            
            _line.alpha=1;
            
            [self.contentView fix2ScaleView:10];
            
            self.contentView.center=centerPoint;
            
        } completion:^(BOOL finished) {
            
        }];
        
    });
    
}


-(void)dismissView:(void (^)(void))finish{
    
    if (self.isDismiss) {
        return;
    }
    
    CGPoint centerPoint=_center;
    
    CGPoint contentViewPoint=CGPointMake(self.contentView.center.x, self.contentView.center.y) ;
    
    self.isDismiss=YES;
    
    double delayInSeconds = SPEEDTIME-0.02;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [self hiddenView];
        
    });
    
    [UIView animateWithDuration:SPEEDTIME animations:^{
        
        _line.alpha=0.0;
        
        self.contentView.center=centerPoint;
        
        [self.contentView fix2ScaleView:0.1];
        
    } completion:^(BOOL finished) {
        
        
        [self.contentView fix2ScaleView:10];
        
        self.contentView.center=contentViewPoint;
        if (finish) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finish();
            });
        }
        
    }];
}

-(void)animationOfRoundView:(UIView *)aView
                     center:(CGPoint)aCenter                                     radius:(CGFloat)aRadius                                startAgngle:(CGFloat)aStartAngle                              endAgngle:(CGFloat)aEndAngle                                clockwise:(BOOL)aClockwise      
                   duration:(CGFloat)aDur {
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = aDur;
    
    CGMutablePathRef ovalfromarc = CGPathCreateMutable();
    CGAffineTransform t2 = CGAffineTransformConcat(CGAffineTransformMakeTranslation(-aCenter.x, -aCenter.y), CGAffineTransformMakeTranslation(aCenter.x, aCenter.y));

    CGPathAddArc(ovalfromarc, &t2, aCenter.x, aCenter.y, aRadius,aStartAngle, aEndAngle, aClockwise);
    
    pathAnimation.path = ovalfromarc;
    CGPathRelease(ovalfromarc);
    
    [pathAnimation setDelegate:self];
    [pathAnimation setValue:aView forKey:@"DetailAni"];
    
    [aView.layer addAnimation:pathAnimation forKey:@"curve"];
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    UIView *btnView = [anim valueForKey:@"DetailAni"];
    
    _startAngle=_endAngle;
    
    if (flag && btnView) {
        CGPoint currentRect = [[btnView.layer presentationLayer]position];
        btnView.layer.position = currentRect;
        
        [[btnView superview] bringSubviewToFront:btnView];
        
        return;
    }
}

-(void) rotateLine:(double)time
{
    [UIView animateWithDuration:time animations:^{
        _line.transform = CGAffineTransformMakeRotation(_endAngle-90*ANGLE_TO_PI);
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}


@end
