//
//  PlayingCard.h
//  Matchismo
//
//  Created by Baldur Kristjánsson on 05/04/14.
//  Copyright (c) 2014 Baldur Kristjánsson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end
