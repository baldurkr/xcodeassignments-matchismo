//
//  Card.h
//  Matchismo
//
//  Created by Baldur Kristjánsson on 05/04/14.
//  Copyright (c) 2014 Baldur Kristjánsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

-(int)match:(NSArray*)otherCards;

@end
