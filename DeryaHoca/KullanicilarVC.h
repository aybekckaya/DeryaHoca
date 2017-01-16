//
//  KullanicilarVC.h
//  DeryaHoca
//
//  Created by aybek can kaya on 15/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "BaseVC.h"
#import "KullaniciEkleVC.h"
#import "Story.h"
#import "UserCell.h"
#import "User.h"
#import "NavigationController.h"
#import "MainActionPageVC.h"

typedef enum KullanicilarScreenType
{
    kKullanicilarScreenTypeStudent,
    kKullanicilarScreenTypeTeacher
    
}KullanicilarScreenType;


@interface KullanicilarVC : BaseVC<UITableViewDataSource , UITableViewDelegate , UserCellDelegate, UIAlertViewDelegate>
{
    NSMutableArray *arrUsers;
    
    User *theUserWillDelete;
}

@property(nonatomic) KullanicilarScreenType typeScreenKullanicilar;

@property (weak, nonatomic) IBOutlet UITableView *tableUsers;

- (IBAction)kullaniciEkleOnTap:(id)sender;

- (IBAction)anasayfaOnTap:(id)sender;

-(void)updateTableView;


@end
