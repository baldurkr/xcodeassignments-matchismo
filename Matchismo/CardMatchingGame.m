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
@property (nonatomic, strong) NSMutableArray *cards; //of Card

@end

@implementation CardMatchingGame

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

static const int MISMATCH_PENALTY = 0;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index;
{
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched)
    {
        if(card.isChosen)
        {
            card.chosen = NO;
        }
        else
        {
            //match against another card
            for(Card *otherCard in self.cards)
            {
                if(otherCard.isChosen && !otherCard.isMatched)
                {
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore)
                    {
                        card.matched = YES;
                        otherCard.matched = YES;
                        self.score += matchScore * MATCH_BONUS;
                    }
                    else
                    {
                        otherCard.chosen = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
        
    }
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
