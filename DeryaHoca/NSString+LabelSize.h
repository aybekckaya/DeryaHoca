//
//  NSString+LabelSize.h
//  Ulak
//
//  Created by aybek can kaya on 30/07/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (LabelSize)
{
    
}


-(CGSize) labelSizeForFontName:(NSString *)fontName fontSize:(float) sizeFont;


+(void)logAllUsableFonts;


+(NSArray *)allFontNames;

@end
