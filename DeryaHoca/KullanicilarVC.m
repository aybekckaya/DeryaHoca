//
//  KullanicilarVC.m
//  DeryaHoca
//
//  Created by aybek can kaya on 15/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "KullanicilarVC.h"

@interface KullanicilarVC ()

@end

@implementation KullanicilarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableUsers.delegate = self;
    self.tableUsers.dataSource = self;
    
   // [self updateTableView];
}


-(void)viewDidAppear:(BOOL)animated
{
    [self updateTableView];
}


/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}
 
 
-(BOOL)shouldAutorotate
{
    return NO;
}
- (NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskPortrait;
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



-(void)updateTableView
{
    arrUsers = [[NSMutableArray alloc]init];
    
    NSMutableArray *arrUsersTemp = [User allUsers];
    
    for(NSDictionary *dct in arrUsersTemp)
    {
        User *theUser = [[User alloc]init];
        [theUser setDictionary:dct];
        
        [arrUsers addObject:theUser];
        
        //NSLog(@"dct : %@" , dct);
        
        
    }
    
    [self.tableUsers reloadData];
}


#pragma mark TableView 

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrUsers.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cellUser";
    
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if(cell == nil)
    {
        cell = [Story GetViewFromNibByName:@"UserCell"];
        cell.delegateCell = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    User *theUser = arrUsers[indexPath.row];
    UIImage *prImage = [theUser getProfileImage];
    
    ////NSLog(@"%@" , theUser.name);
    
    
    if(theUser.name != nil)
    {
        cell.lblUserName.text =theUser.name;
    }
    
    
    if(prImage != nil)
    {
        cell.imViewProfile.image = prImage;
    }
    
    
    cell.userID = theUser.ID;
 
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 174;
}



#pragma mark Cell delegate 

-(void)userCellProfileImageDidTapped:(UserCell *)cell
{
    int theID = cell.userID;
     //User * = [[User alloc] initWithID:theID];
    
    KullaniciEkleVC *vc = [Story viewController:@"kullaniciEkleVC"];
    vc.typePage = kKullaniciEklePageTypeEdit;
    vc.userID = theID;
    
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
}

-(void)userCellDidTappedDelete:(UserCell *)cell
{
    int theID = cell.userID;
    theUserWillDelete = [[User alloc] initWithID:theID];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:@"Kullanıcı silinecektir. Emin misiniz ? " delegate:self cancelButtonTitle:@"Hayır" otherButtonTitles:@"Evet", nil];
    
    alert.tag = 1000;
    [alert show];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if(alertView.tag == 1000)
    {
        if(buttonIndex == 1)
        {
            NSArray *ktArr = [KategoriStudent getAllItems];
            
            for(NSDictionary *dct in ktArr)
            {
                if([dct[@"studentID"] intValue] == theUserWillDelete.ID)
                {
                    KategoriStudent *st = [[KategoriStudent alloc] init];
                    [st setDictionary:dct];
                    
                    [st removeModel];
                }
            }
            
            [theUserWillDelete removeProfileImage];
            [theUserWillDelete removeModel];
            
            [self updateTableView];
        }
        
    }
    
}



-(void)userCellDidTappedChoose:(UserCell *)cell
{
    // set user as current User
    
    User *theUser = [[User alloc] initWithID:cell.userID];
    [theUser setAsCurrentUser];
    
    User *shared = [User currentUser];
    //NSLog(@"dct Current User : %@" , [shared getDictionary]);
    
    // go to next page
    
    MainActionPageVC *vc = [Story viewController:@"mainActionPageVC"];
    
    if(self.typeScreenKullanicilar == kKullanicilarScreenTypeTeacher)
    {
        vc.typePage = kMainActionPageTypeTeacher;
    }
    else if(self.typeScreenKullanicilar == kKullanicilarScreenTypeStudent)
    {
        vc.typePage = kMainActionPageTypeStudent;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
}




- (IBAction)kullaniciEkleOnTap:(id)sender {
    
    KullaniciEkleVC *vc = [Story viewController:@"kullaniciEkleVC"];
    
  NavigationController *navCon = [[NavigationController alloc] initWithRootViewController:vc];
    navCon.navigationBarHidden = YES;
    
    [self presentViewController:navCon animated:YES completion:^{
        
    }];
}

- (IBAction)anasayfaOnTap:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
