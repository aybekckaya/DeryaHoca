/*
 By: Justin Meiners
 
 Copyright (c) 2015 Justin Meiners
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

#import <UIKit/UIKit.h>

typedef struct
{
    unsigned char r;
    unsigned char g;
    unsigned char b;
} ISColorWheelPixelRGB;

@interface WheelColor :NSObject

@property(nonatomic) float redColor;
@property(nonatomic ) float greenColor;
@property(nonatomic) float blueColor;

@end




@class ISColorWheel;


@protocol ISColorWheelDelegate <NSObject>
@required
- (void)colorWheelDidChangeColor:(ISColorWheel*)colorWheel;
@end


@interface ISColorWheel : UIView
{
    float redColor;
    float blueColor;
    float greenColor;
    
    WheelColor *colorOnWheel;
    
}

@property(nonatomic, weak)id <ISColorWheelDelegate> delegate;
@property(nonatomic, assign)CGSize knobSize;
@property(nonatomic, strong)UIView* knobView;
@property(nonatomic, assign)CGFloat brightness;
@property(nonatomic, assign)BOOL continuous;


@property(nonatomic, strong)UIColor* borderColor;
@property(nonatomic, assign)CGFloat borderWidth;
@property(nonatomic, strong)UIColor* currentColor;

@property(nonatomic , readonly) WheelColor *colorOfWheel;

- (void)updateImage;
- (void)setTouchPoint:(CGPoint)point;



@end
