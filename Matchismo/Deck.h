//
//  CardDeck.h
//  Matchismo
//
//  Created by Baldur Kristjánsson on 05/04/14.
//  Copyright (c) 2014 Baldur Kristjánsson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;
@end
