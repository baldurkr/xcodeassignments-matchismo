//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Baldur Kristjánsson on 07/04/14.
//  Copyright (c) 2014 Baldur Kristjánsson. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic,readwrite) NSInteger score; //Redefine score as readwrite internally
@property (nonatomic, readwrite) NSArray *lastMatchAttempt;
@property (nonatomic, readwrite) int lastMatchScore;
@property (nonatomic, strong) NSMutableArray *cards; //of Card

@end

@implementation CardMatchingGame

-(void)setThreeCardMatch:(BOOL)threeCardMatch
{
    _threeCardMatch = threeCardMatch;
    NSLog(@"Property threeCardMatch set to %s", threeCardMatch ? "YES" : "NO");
}

-(NSMutableArray *)cards
{
    if(!_cards)
    {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck
{
    self = [super init];
    if(self)
    {
        for(int i=0;i<count;i++)
        {
            Card *card = [deck drawRandomCard];
            if(card)
            {
                [self.cards addObject:card];
            }
            else
            {
                break;
            }
        }
    }
    return self;
}

static const int MISMATCH_PENALTY = 1;
static const int MATCH_BONUS = 4;

-(void)chooseCardAtIndex:(NSUInteger)index;
{
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched)
    {
        if(card.isChosen) //Flip chosen card back over
        {
            card.chosen = NO;
        }
        else
        {
            int matchScore = 0;
            if (self.threeCardMatch)
            {
                //match against two other cards
                matchScore = [self performThreeCardMatchWithCurrentCards:card];
            }
            else
            {
                //match against one other card
                matchScore = [self performTwoCardMatchWithCurrentCards:card];
            }
            self.lastMatchScore = matchScore > 0 ? matchScore * MATCH_BONUS : matchScore;
            self.score += self.lastMatchScore;
            card.chosen = YES;
        }
    }
}

-(int)performThreeCardMatchWithCurrentCards:(Card*)card
{
    int matchScore = 0;
    NSMutableArray *unmatchedChosenCards = [[NSMutableArray alloc] init];
    for(Card *otherCard in self.cards)
    {
        if(otherCard.isChosen && !otherCard.isMatched)
        {
            [unmatchedChosenCards addObject:otherCard];
        }
    }
    if ([unmatchedChosenCards count] == 2)
    {
        self.lastMatchAttempt = @[card,[unmatchedChosenCards firstObject],[unmatchedChosenCards lastObject]];
        matchScore = [card match:unmatchedChosenCards];
        if(matchScore)
        {
            card.matched = YES;
            for(Card* otherCard in unmatchedChosenCards)
            {
                otherCard.matched = YES;
            }
        }
        else
        {
            matchScore = -MISMATCH_PENALTY;
            for(Card* otherCard in unmatchedChosenCards)
            {
                otherCard.chosen = NO;
            }
        }
    }
    return matchScore;
}

-(int)performTwoCardMatchWithCurrentCards:(Card*)card
{
    int matchScore = 0;
    for(Card *otherCard in self.cards)
    {
        if(otherCard.isChosen && !otherCard.isMatched)
        {
            self.lastMatchAttempt = @[card,otherCard];
            matchScore = [card match:@[otherCard]];
            if(matchScore)
            {
                card.matched = YES;
                otherCard.matched = YES;
            }
            else
            {
                matchScore = -MISMATCH_PENALTY;
                otherCard.chosen = NO;
            }
        }
    }
    return matchScore;
}



-(Card *)cardAtIndex:(NSUInteger)index
{
    if(index < self.cards.count)
    {
        return self.cards[index];
    }
    else
    {
        return nil;
    }
    
}


@end
