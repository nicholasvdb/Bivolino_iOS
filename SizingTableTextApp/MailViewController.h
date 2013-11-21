//
//  MailViewController.h
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 14/05/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Measure.h"
#import "BSKeyboardControls.h"

@interface MailViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, BSKeyboardControlsDelegate>
@property (strong, nonatomic) Measure *measure;
@end
