//
//  KategoriSecVC.m
//  DeryaHoca
//
//  Created by aybek can kaya on 27/11/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "KategoriSecVC.h"

@interface KategoriSecVC ()

@end

@implementation KategoriSecVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self updateGUI];
}


-(void)updateGUI
{
    // bottom bar
    
    barBottom = [Story GetViewFromNibByName:@"BottomBar"];
    CGRect currFrame = barBottom.frame ;
    currFrame.origin.y = self.view.frame.size.height - currFrame.size.height;
    barBottom.delegateBarBottom = self;
    barBottom.frame = currFrame;
    
    [self.view addSubview:barBottom];
    
    
    UIImage *theImage = [UIImage imageNamed:@"anasayfaIcon.png"];
    UIImageView *imView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 72, 72)];
    imView.image = theImage;
    
   // [barBottom pushUIImageView:imView];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
