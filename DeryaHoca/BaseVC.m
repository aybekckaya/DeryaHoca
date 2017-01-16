//
//  BaseVC.m
//  DeryaHoca
//
//  Created by aybek can kaya on 14/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
   // [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
  
}


-(BOOL)prefersStatusBarHidden
{
    return YES;
}



/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
  
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
   
    return UIInterfaceOrientationMaskLandscapeLeft;
}

*/

/*
- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    float rotation;
    
    if (toInterfaceOrientation==UIInterfaceOrientationPortrait)
    {
             rotation = 0;
    }
    else if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft)
    {
            rotation = M_PI/2;
        
    }
    else if (toInterfaceOrientation==UIInterfaceOrientationLandscapeRight)
    {
            rotation = -M_PI/2;
        
    }
    
   
    UIView *mainView = self.navigationController.view;
    //NSLog(@"main View : %@" , mainView);
    
    mainView.t
    
}
 */


 
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
