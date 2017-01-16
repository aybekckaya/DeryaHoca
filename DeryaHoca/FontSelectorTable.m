//
//  FontSelectorTable.m
//  DeryaHoca
//
//  Created by aybek can kaya on 02/12/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "FontSelectorTable.h"

@implementation FontSelectorTable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(void)awakeFromNib
{
    self.tableFonts.delegate = self;
    self.tableFonts.dataSource = self;
    
    allFonts = [NSString allFontNames];
    
    [self.tableFonts reloadData];
    
    
    [self.tableFonts selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:nil];
    
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    openFrame = CGRectMake((bounds.size.width - self.frame.size.width)/2, (bounds.size.height-self.frame.size.height)/2, self.frame.size.width, self.frame.size.height);
    
    self.frame = CGRectMake(0, 0, 1, 1);
    
    self.alpha = 0;
    
    
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = NO;
    
    self.layer.shadowOffset = CGSizeMake(-1, 10);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;

    
    
    self.viewImageSample.layer.cornerRadius = 10;
    self.viewImageSample.layer.masksToBounds = NO;
    self.viewImageSample.layer.shadowOffset = CGSizeMake(-1, 10);
    //self.viewImageSample.layer.shadowRadius = 5;
    //self.viewImageSample.layer.shadowOpacity = 0.5;
    self.viewImageSample.backgroundColor = [UIColor clearColor];
    
    self.viewImageSample.layer.borderColor = [[UIColor colorWithR:55 G:55 B:55 A:0.5] CGColor];
    self.viewImageSample.layer.borderWidth = 1;
    
    
    
    
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allFonts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cellFont";
    
    FontPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if(cell == nil)
    {
        cell = [Story GetViewFromNibByName:@"FontPickerCell"];
    }
    
    NSString *fontName = allFonts[indexPath.row];
    
    UIFont *theFont = [UIFont fontWithName:fontName size:17];
    
    cell.lblTexxt.font = theFont;
    cell.lblTexxt.text = fontName;
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *fontName = allFonts[indexPath.row];
     UIFont *theFont = [UIFont fontWithName:fontName size:17];
    self.lblMainText.font = theFont;
    
    currentSelectedFontName = fontName;
}


- (IBAction)btnTamamOnTap:(id)sender {
    
    [self hide];
}

-(void) showFromPoint:(CGPoint )ptFrom
{
    
    if([self.delegateView respondsToSelector:@selector(fontSelectorTableWillOpen:)])
    {
        [self.delegateView fontSelectorTableWillOpen:self];
    }
    
    self.center = ptFrom;
    //CGRect bounds = [[UIScreen mainScreen] bounds];
    
    latestOpenedPoint = ptFrom;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:0 animations:^{
        
        self.frame = openFrame;
        self.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];

}


-(void)hide
{
    CGPoint ptClose = latestOpenedPoint;
    CGRect newFrame = CGRectMake(ptClose.x, ptClose.y, 1, 1);
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
        
        
        self.alpha = 0;
        self.frame = newFrame;
        
    } completion:^(BOOL finished) {
        
        if([self.delegateView respondsToSelector:@selector(fontSelectorTableDidClosed:)])
        {
            [self.delegateView fontSelectorTableDidClosed:self];
        }
        
        
        
    }];

}

-(NSString *)currentFontName
{
    return currentSelectedFontName;
}


-(void)selectFontName:(NSString *)fontName
{
    currentSelectedFontName = fontName;
    
    /*
    if([self.delegateView respondsToSelector:@selector(fontSelectorTableDidClosed:)])
    {
        [self.delegateView fontSelectorTableDidClosed:self];
    }
     */
}



@end
