//
//  AddStaticTableViewController.h
//  ArztTerminApp
//
//  Created by Simplice Tchoupkoua on 06.02.13.
//  Copyright (c) 2013 Simplice. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Zeitfenster;

@interface AddStaticTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITextField *tag;
@property (strong, nonatomic) IBOutlet UITextField *monat;
@property (strong, nonatomic) IBOutlet UITextField *jahr;

@property (strong, nonatomic) IBOutlet UITextField *vollerNamePatient;
@property (strong, nonatomic) IBOutlet UILabel *arztname;
@property (strong, nonatomic) IBOutlet UILabel *beginTermin;
@property (strong, nonatomic) IBOutlet UILabel *endTermin;

@property (nonatomic, strong) Zeitfenster *selectedZeitfenster;

- (IBAction) startMethodToCheckMaxLength: (id) sender;
- (IBAction) stopMethodToCheckMaxLength: (id) sender;

- (IBAction)removeKeybord:(id)sender ;
- (IBAction)saveTermin:(id)sender ;

@end