//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Baldur Kristjánsson on 01/04/14.
//  Copyright (c) 2014 Baldur Kristjánsson. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface CardGameViewController ()
@property (strong, nonatomic) Deck* deck;
@property (strong, nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UISwitch *threeCardSwitch;
@property (strong, nonatomic) IBOutlet UILabel *newsFeedLabel;
@end

@implementation CardGameViewController


- (IBAction)threeCardSwitchValueChanged:(UISwitch *)sender
{
    self.game.threeCardMatch = sender.on;
    NSLog(@"Three card switch set to %s",sender.on ? "on" : "off");
}

-(Deck*) deck
{
    if(!_deck)
    {
        _deck = [[PlayingCardDeck alloc] init];
        return _deck;
    }
    else
    {
        return _deck;
    }
}

-(Deck*)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

-(CardMatchingGame*) startNewGame
{
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]];
    
}

-(CardMatchingGame*) game
{
    if(!_game)
    {
        _game = [self startNewGame];
    }
    return _game;
}

-(UIImage*)backgroundImageForCard:(Card*) card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

-(NSString*)titleForCard:(Card*) card
{
    return card.isChosen ? card.contents : @"";
}

-(void)updateUI
{
    //Update card button presentation
    for(UIButton* cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    //Update score label
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",(long)self.game.score];
    
    
    //Update news feed
    NSMutableString *news = [@"" mutableCopy];
    
    if(self.game.lastMatchAttempt){
        [news appendString:@"Match attempt: "];
        for(Card *card in self.game.lastMatchAttempt){
            [news appendString:card.contents];
            [news appendString:@" "];
        }
    }

    if(self.game.lastMatchScore)
    {
        [news appendString:self.game.lastMatchScore > 0 ? @"Score awarded: " : @"Penalty: "];
        [news appendString:[NSString stringWithFormat:@"%d",self.game.lastMatchScore]];
    }
    self.newsFeedLabel.text = news;
}

- (IBAction)touchNewGameButton:(UIButton *)sender
{
    self.game = [self startNewGame];
    self.game.threeCardMatch = self.threeCardSwitch.on;
    self.threeCardSwitch.enabled = YES;
    self.newsFeedLabel.text = @"Let the games begin!";
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    if (self.threeCardSwitch.enabled)
    {
        self.threeCardSwitch.enabled = NO;
    }
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.game = [self startNewGame];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
