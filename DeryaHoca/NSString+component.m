//
//  NSString+component.m
//  DeryaHoca
//
//  Created by aybek can kaya on 03/12/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "NSString+component.h"

@implementation NSString (component)

-(UIColor *)colorValueFromComponent
{
    NSString *trimmed = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSArray *strExploded = [trimmed componentsSeparatedByString:@","];
    
    float red = [strExploded[0] floatValue];
    float green = [strExploded[1] floatValue];
    float blue = [strExploded[2] floatValue];
    
    
    return [UIColor colorWithR:red G:green B:blue A:1];
    
}


+(NSString *)stringComponentFromColor:(UIColor *)color
{
    double r,g,b,a;
    
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    r = r*255;
    g= g*255;
    b=b*255;
    
    NSString *str = [NSString stringWithFormat:@"%f,%f,%f" , r,g,b];
    return str;
}


-(CGRect )frameValueFromComponent
{
    NSString *trimmed = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSArray *strExploded = [trimmed componentsSeparatedByString:@","];
    
    if(strExploded.count < 2)
    {
        //return CGRectZero;
    }
    
    CGRect theRect = CGRectMake([strExploded[0] floatValue], [strExploded[1] floatValue], [strExploded[2] floatValue], [strExploded[3] floatValue]);
    
    return theRect;
}



+(NSString *)stringComponentFromFrame:(CGRect)frame
{
    NSString *theStr = [NSString stringWithFormat:@"%f , %f ,%f ,%f" , frame.origin.x ,frame.origin.y , frame.size.width , frame.size.height];
    
    return theStr;
}


+(NSString *)stringComponentFromCGPoint:(CGPoint)pt
{
    NSString *theStr = [NSString stringWithFormat:@"%f , %f" , pt.x , pt.y ];
    
    return theStr;
}


-(CGPoint) pointValueFromComponent
{
    NSString *trimmed = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSArray *strExploded = [trimmed componentsSeparatedByString:@","];
    
   if(strExploded.count < 2)
   {
      // return CGPointMake(0, 0);
   }
    
    CGPoint thePoint = CGPointMake([strExploded[0] floatValue], [strExploded[1] floatValue]);
    
    return thePoint;
}


@end
