//
//  RegisterTVC.h
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 17/05/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterTVC : UITableViewController <UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate, NSURLConnectionDelegate, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *switcher;

@end
