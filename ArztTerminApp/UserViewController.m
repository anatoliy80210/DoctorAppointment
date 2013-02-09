//
//  UserViewController.m
//  ArztTerminApp
//
//  Created by Simplice Tchoupkoua on 05.02.13.
//  Copyright (c) 2013 Simplice. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

@synthesize infoTextLabel = _infoTextLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ajouter une image au backgroungColor
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"320-fond.jpg"]];

    self.infoTextLabel.attributedText = [self makeAttributedStringFromString:self.infoTextLabel.text];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableAttributedString*) makeAttributedStringFromString: (NSString*) textString {
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:textString];
    NSInteger stringLength=[textString length];
    UIColor *schwarz=[UIColor blackColor];
    UIColor *_blueL=[UIColor colorWithRed:0 green:0 blue:0.5 alpha:0.5];
    UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:24.0f];
    
    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, stringLength)];
    [attString addAttribute:NSStrokeColorAttributeName value:schwarz range:NSMakeRange(0, stringLength)];
    [attString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:3.0] range:NSMakeRange(0, stringLength)];
    [attString addAttribute:NSBackgroundColorAttributeName value:_blueL range:NSMakeRange(28, 10)];
    //[attString addAttribute:NSForegroundColorAttributeName value:blaufarbe range:NSMakeRange(0, stringLength)];

    return attString;
}

@end
