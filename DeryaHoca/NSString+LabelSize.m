//
//  NSString+LabelSize.m
//  Ulak
//
//  Created by aybek can kaya on 30/07/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "NSString+LabelSize.h"

@implementation NSString (LabelSize)

-(CGSize)labelSizeForFontName:(NSString *)fontName fontSize:(float)sizeFont
{
    UIFont *font = [UIFont fontWithName:fontName size:sizeFont];
    
    CGSize sizeLabel =  [self sizeWithFont:font];
    
    return sizeLabel;
}



+(void)logAllUsableFonts
{
    NSArray *fontFamilies = [UIFont familyNames];
    
    for (int i = 0; i < [fontFamilies count]; i++)
    {
        NSString *fontFamily = [fontFamilies objectAtIndex:i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
        //NSLog (@"%@: %@", fontFamily, fontNames);
    }
}


+(NSArray *)allFontNames
{
    NSMutableArray *arrFontNames = [[NSMutableArray alloc] init];
    NSArray *fontFamilies = [UIFont familyNames];
    
    for (int i = 0; i < [fontFamilies count]; i++)
    {
        NSString *fontFamily = [fontFamilies objectAtIndex:i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
        // //NSLog (@"%@: %@", fontFamily, fontNames);
        
        for(int y= 0; y<fontNames.count ; y++)
        {
            [arrFontNames addObject:fontNames[y]];
        }
    }
    
    
    return [[NSArray alloc] initWithArray:arrFontNames];
}



@end
