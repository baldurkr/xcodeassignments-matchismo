//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Baldur Kristjánsson on 07/04/14.
//  Copyright (c) 2014 Baldur Kristjánsson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck*)deck;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) BOOL threeCardMatch; //YES if in three-card mode
@property (nonatomic, readonly) NSArray *lastMatchAttempt;
@property (nonatomic, readonly) int lastMatchScore;


@end
