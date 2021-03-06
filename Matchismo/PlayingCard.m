//
//  PlayingCard.m
//  Matchismo
//
//  Created by Baldur Kristjánsson on 05/04/14.
//  Copyright (c) 2014 Baldur Kristjánsson. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

-(int)match:(NSArray*)otherCards
{
    int score = 0;
    
    if([otherCards count] == 1)
    {
        PlayingCard* otherCard = [otherCards firstObject];
        if(self.suit == otherCard.suit)
        {
            score = 1;
        }
        else if(self.rank == otherCard.rank)
        {
            score = 4;
        }
        
    }
    if([otherCards count] == 2)
    {
        PlayingCard* firstCard = [otherCards firstObject];
        PlayingCard* secondCard = [otherCards lastObject];
        if(self.suit == firstCard.suit && self.suit == secondCard.suit)
        {
            score = 2;
        }
        else if(self.rank == firstCard.rank && self.rank == secondCard.rank)
        {
            score = 8;
        }
    }
    
    return score;
}

+(NSArray *)validSuits
{
    return @[@"♠️",@"♥️",@"♦️",@"♣️"];
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank
{
    return [PlayingCard rankStrings].count - 1;
}

-(NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}


@end
