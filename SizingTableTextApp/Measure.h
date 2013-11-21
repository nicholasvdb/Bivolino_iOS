//
//  Measures.h
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 14/05/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Measure : NSObject

@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *cm;

@property (strong, nonatomic) NSString *collar;
@property (strong, nonatomic) NSString *sleeve;
@property (strong, nonatomic) NSString *shoulder;
@property (strong, nonatomic) NSString *belly;
@property (strong, nonatomic) NSString *waist;
@property (strong, nonatomic) NSString *arm;
@property (strong, nonatomic) NSString *wrist;
@property (strong, nonatomic) NSString *chest;
@property (strong, nonatomic) NSString *back;
@property (strong, nonatomic) NSString *bmi;
@property (strong, nonatomic) NSString *upperbust;
@property (strong, nonatomic) NSString *underbust;
@property (strong, nonatomic) NSString *hips;
@property (strong, nonatomic) NSString *predictedSize;

//CalculateSize:(NSString *)Gender :(NSString *)Cm :(NSString *)Age :(NSString *)Weight :(NSString *)Height :(NSString *)Collarsize :(NSString *)Fit :(NSString *)Email :(NSString *)FCup :(NSString *)FArms :(NSString *)FWaist :(NSString *)FHips

@end
