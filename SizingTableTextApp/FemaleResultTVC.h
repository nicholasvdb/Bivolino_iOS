//
//  FemaleResultTVC.h
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 25/04/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Female.h"
#import "BioAppProxy.h"

@interface FemaleResultTVC : UITableViewController <Wsdl2CodeProxyDelegate>
@property (strong, nonatomic) Female *female;
@end
