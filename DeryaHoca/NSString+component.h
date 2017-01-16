//
//  NSString+component.h
//  DeryaHoca
//
//  Created by aybek can kaya on 03/12/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+Convert.h"

@interface NSString (component)


-(UIColor *) colorValueFromComponent;

+(NSString *)stringComponentFromColor:(UIColor *)color;

-(CGRect) frameValueFromComponent;

+(NSString *)stringComponentFromFrame:(CGRect) frame;

+(NSString *)stringComponentFromCGPoint:(CGPoint) pt;

-(CGPoint) pointValueFromComponent;

@end
