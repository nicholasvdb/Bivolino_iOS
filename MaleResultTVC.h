//
//  MaleResultTVC.h
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 24/04/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Male.h"
#import "BioAppProxy.h"

@interface MaleResultTVC : UITableViewController  <Wsdl2CodeProxyDelegate>

@property (strong, nonatomic) Male *male;
@end