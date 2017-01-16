//
//  CategoryScroll.m
//  DeryaHoca
//
//  Created by aybek can kaya on 21/11/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "CategoryScroll.h"
#import "KategoriView.h"

@implementation CategoryScroll

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)awakeFromNib
{
    self.delegate = self;
    self.pagingEnabled = YES;
}


-(void)reloadScroll
{
    [self clearScroll];
    
    if(self.datasourceScroll == nil)
    {
        return;
    }
    
    int numItems = [self.datasourceScroll numberOfItemsInCategoryScroll:self];
    
    int numPages = 1+ numItems/18;
    pageMax = numPages;
    
    if(self.typeScroll == kCategoryScrollTypeDefault)
    {
        
        float currXPos = 20;
        float currYPos = 20;
        
        for(int i = 0; i<numItems ; i++)
        {
            UIView *view = [self.datasourceScroll categoryScroll:self viewAtIndex:i];
            CGSize sizeView = [self.datasourceScroll categoryScroll:self viewSizeAtIndex:i];
            
            // frame not specified
                
                CGRect currFrame = view.frame;
                currFrame.origin.x =currXPos;
                currFrame.origin.y = currYPos;
                
                view.frame = currFrame;
                
                currXPos += 20 +sizeView.width;
            
            int itemNum = i+1;
                if(itemNum % 6 == 0 && i>0)
                {
                    currYPos += 20 + sizeView.height;
                    currXPos = 20;
                }
                
                
                if(itemNum % 18 == 0 && i>0)
                {
                    currYPos = 20;
                    currXPos += self.frame.size.width;
                }

                
            
            [self addSubview:view];
        }
        
        self.contentSize = CGSizeMake(numPages*self.frame.size.width, self.contentSize.height);
        

    }
    else if(self.typeScroll == kCategoryScrollTypeStudentPage)
    {
        float maxXPos = 0;
        
        for(int i = 0; i<numItems ; i++)
        {
            CGPoint center = [self.datasourceScroll categoryScroll:self viewCenterAtIndex:i];
            float scale = [self.datasourceScroll categoryScroll:self viewScaleAtIndex:i];
            UIView *view = [self.datasourceScroll categoryScroll:self viewAtIndex:i];
            
            // 164 baz alınıyor
            //NSLog(@"view frame : %@" , NSStringFromCGRect(view.frame));
            
            if(center.x == 0 && center.y == 0)
            {
                center = CGPointMake(20+view.frame.size.width*scale/2, 20+view.frame.size.height*scale/2);
            }
            
            
            
            
            view.center = center;
           // view.transform = CGAffineTransformScale(view.transform, scale, scale);
            
            view.transform = CGAffineTransformMakeScale(scale, scale);
            
            
            [self addSubview:view];
            
            if(view.center.x + view.frame.size.width > maxXPos)
            {
                maxXPos = view.center.x + view.frame.size.width/2;
            }
            
        }
        
        // calculate content size
        
        
        int numPages = 1 + maxXPos/self.frame.size.width;
        pageMax = numPages;
        
        self.contentSize = CGSizeMake(numPages * self.frame.size.width, self.contentSize.height);
        
    }
    
   
}


-(void)clearScroll
{
    for(id subview in self.subviews)
    {
        UIView *vv = (UIView *)subview;
        
        [vv removeFromSuperview];
    }
}



-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currPage = scrollView.contentOffset.x/scrollView.frame.size.width;
    _currentPage = currPage;
    
    if([self.delegateScroll respondsToSelector:@selector(categoryScroll:currentPageDidChanged:maxPages:)])
    {
        [self.delegateScroll categoryScroll:self currentPageDidChanged:currPage maxPages:self.maxPage];
    }
    
}

#pragma mark SETTERS 

-(void)setCurrentPage:(int)currentPage
{
    _currentPage = currentPage;
    
    float xPos = currentPage * self.frame.size.width;
    
    if(self.contentSize.width < xPos + self.frame.size.width)
    {
        self.contentSize = CGSizeMake(xPos+self.frame.size.width, self.contentSize.height);
        pageMax ++ ;
    }
    
    [self setContentOffset:CGPointMake(xPos, 0) animated:YES];
    
    
    if([self.delegateScroll respondsToSelector:@selector(categoryScroll:currentPageDidChanged:maxPages:)])
    {
        [self.delegateScroll categoryScroll:self currentPageDidChanged:currentPage maxPages:pageMax];
    }
    
}

#pragma mark GETTERS 

-(int) maxPage
{
    return pageMax;
}



-(NSMutableArray *)itemsAtPage:(int)page
{
    NSMutableArray *arrItems = [[NSMutableArray alloc] init];
    
    float xPosMin = page * self.frame.size.width;
    float xPosMax = (page +1 ) * self.frame.size.width;
    
    for(id vv in self.subviews)
    {
        if([vv isKindOfClass:[KategoriView class]])
        {
            KategoriView *view = (KategoriView *)vv;
            CGPoint centerPtView = view.center;
            
            if(centerPtView.x >= xPosMin && centerPtView.x <= xPosMax)
            {
                [arrItems addObject:view];
            }
            
        }
    }
    
    return arrItems;
}


-(void)setPageMax:(int)maxPageNum
{
    pageMax = maxPageNum;
    
     self.contentSize = CGSizeMake(pageMax*self.frame.size.width, self.contentSize.height);
    
    
    if([self.delegateScroll respondsToSelector:@selector(categoryScroll:currentPageDidChanged:maxPages:)])
    {
        [self.delegateScroll categoryScroll:self currentPageDidChanged:self.currentPage maxPages:self.maxPage];
    }
    
}


-(CGPoint)emptyCenterOnPage:(int)page
{
    NSMutableArray *items = [self itemsAtPage:page];
    
    NSMutableArray *arrXPts = [[NSMutableArray alloc] init];
    
    for(KategoriView *vv in items)
    {
        [arrXPts addObject:@(vv.frame.origin.x)];
    }
    
    float xPt = 20+page*self.frame.size.width;
    float yPt = 20;
    
    while([arrXPts containsObject:@(xPt)])
    {
        xPt += 20;
        yPt += 20;
    }
    
    float centerPt_X = xPt + 164/2;
    float centerPt_Y = yPt + 164/2;
    
    return  CGPointMake(centerPt_X, centerPt_Y);

}


@end
