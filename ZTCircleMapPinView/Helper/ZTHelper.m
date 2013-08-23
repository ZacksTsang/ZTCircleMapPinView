//
//  ZTHelper.m
//  ZTCircleAnnotationView
//
//  Created by Zacks Tsang  on 13-8-23.
//  Copyright (c) 2013年 www.aiysea.com. All rights reserved.
//

#import "ZTHelper.h"

static ZTHelper *ztHelper=nil;

@implementation ZTHelper

+(ZTHelper *)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ztHelper=[[ZTHelper alloc]init];
    });
    
    return ztHelper;
}

-(float)dealFixAngel:(CGPoint)finalPoint{
    
    float angel=0.0f;
    
    int area=0;
    
    CGSize size=[[UIScreen mainScreen] bounds].size;
    
    float width=size.width/2.0f;
    float height=size.height/2.0f;
    
    CGPoint centerPoint=CGPointMake(width, height);
    
    if (finalPoint.y!=centerPoint.y) {
        angel=atan(fabs(finalPoint.x-centerPoint.x)/fabs(finalPoint.y-centerPoint.y));
    }
    
    
    
    if (finalPoint.x<width&&finalPoint.y<height) {
        
        area=0;
        
        angel=M_PI_2-angel;
        
    }else if (finalPoint.x<width&&finalPoint.y>height) {
        
        area=3;
        
    }else if (finalPoint.x>width&&finalPoint.y<height) {
        
        area=1;
        
    }else if (finalPoint.x>width&&finalPoint.y>height) {
        
        area=2;
        
        angel=M_PI_2-angel;
    }else if(finalPoint.x==width&&finalPoint.y<height){
        
        area=1;
        
        angel=0;
    }else if(finalPoint.x==width&&finalPoint.y>height){
        
        area=3;
        
        angel=0;
    }else if(finalPoint.y==height&&finalPoint.x<width){
        
        area=0;
        
        angel=0;
    }else if(finalPoint.y==height&&finalPoint.x>width){
        
        area=2;
        
        angel=0;
    }
    
    angel=90*area+angel*180/M_PI;
    
    
    return angel;
    
}

@end
