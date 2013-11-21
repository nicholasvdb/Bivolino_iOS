//
//  TableData.m
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 16/04/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import "TableData.h"

@implementation TableData
@synthesize heightArray;
@synthesize weightArray;
@synthesize ageArray;
@synthesize collarSizeArray;

- (void)initTableData
{
    heightArray = [[NSMutableArray alloc] init];
    for (int i = 150; i <= 215; i++){
        [heightArray addObject:[NSString stringWithFormat:@"%d cm", i]];
    }
    
    ageArray = [[NSMutableArray alloc] init];
    for (int i = 16; i <= 99; i++){
        [ageArray addObject:[NSString stringWithFormat:@"%d year", i]];
    }
    
    weightArray = [[NSMutableArray alloc] init];
    for (int i = 45; i <= 165; i++){
        [weightArray addObject:[NSString stringWithFormat:@"%d kg", i]];
    }
    
    collarSizeArray = [[NSMutableArray alloc] init];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 36, @"XS"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 37, @"S"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 38, @"S"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 39, @"M"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 40, @"M"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 41, @"L"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 42, @"L"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 43, @"XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 44, @"XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 45, @"2XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 46, @"2XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 47, @"3XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 48, @"3XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 49, @"4XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 50, @"4XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 51, @"5XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 52, @"5XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 53, @"6XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 54, @"6XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 55, @"7XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 56, @"7XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 57, @"8XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 58, @"8XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 59, @"9XL"]];
    [collarSizeArray addObject:[NSString stringWithFormat:@"%d/%@", 60, @"9XL"]];
  
}

@end
