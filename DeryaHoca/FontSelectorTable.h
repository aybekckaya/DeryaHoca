//
//  FontSelectorTable.h
//  DeryaHoca
//
//  Created by aybek can kaya on 02/12/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+LabelSize.h"
#import "FontPickerCell.h"
#import "Story.h"
#import "UIColor+Convert.h"

@class FontSelectorTable;
@protocol FontSelectorTableDelegate <NSObject>

-(void)fontSelectorTableWillOpen:(FontSelectorTable *)tableFontSelector;

-(void)fontSelectorTableDidClosed:(FontSelectorTable *)tableFontSelector;

@end


@interface FontSelectorTable : UIView<UITableViewDelegate , UITableViewDataSource>
{
    NSArray *allFonts;
    
    CGRect openFrame;
    CGPoint latestOpenedPoint;
    
    NSString *currentSelectedFontName;
    
}

@property(nonatomic ,weak) id<FontSelectorTableDelegate> delegateView;


@property(nonatomic ,readonly) NSString *currentFontName;

@property (weak, nonatomic) IBOutlet UIView *viewImageSample;

@property (weak, nonatomic) IBOutlet UIImageView *imViewImage;
@property (weak, nonatomic) IBOutlet UILabel *lblMainText;

@property (weak, nonatomic) IBOutlet UITableView *tableFonts;

@property (weak, nonatomic) IBOutlet UIButton *btnTamam;


- (IBAction)btnTamamOnTap:(id)sender;



-(void)showFromPoint:(CGPoint )ptFrom;

-(void)hide;

-(void)selectFontName:(NSString *)fontName;

@end
