//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Baldur Kristjánsson on 01/04/14.
//  Copyright (c) 2014 Baldur Kristjánsson. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flips;

@end

@implementation CardGameViewController

@synthesize flips = _flips;

-(void)setFlips:(int) count
{
    _flips = count;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", count];
    NSLog(@"flipCount changed to %d", count);
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    if([sender.currentTitle length])
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        self.flips++;
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                forState:UIControlStateNormal];
        [sender setTitle:@"A♣️" forState:UIControlStateNormal];
        self.flips++;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
