//
//  MailViewController.m
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 14/05/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import "MailViewController.h"
#import "BSKeyboardControls.h"


@interface MailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtFirstname;
@property (weak, nonatomic) IBOutlet UITextField *txtLastname;
@property (weak, nonatomic) IBOutlet UISwitch *switchNews;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;
@end

@implementation MailViewController
- (IBAction)dismissKeyboard:(UITextField *)sender {
    [sender resignFirstResponder];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


/*
- (IBAction)sendMail:(UIButton *)sender {
        NSMutableString *sizesurl;
        if ([self.measure.gender isEqualToString:@"M"]) {
            sizesurl = [[NSMutableString alloc ]initWithString:@"http://bivoapp.eu01.aws.af.cm/male.php?mail="];
            [sizesurl appendString:self.txtEmail.text];
            [sizesurl appendString:@"&firstname="];
            [sizesurl appendString:self.txtFirstname.text];
            [sizesurl appendString:@"&surname="];
            [sizesurl appendString:self.txtLastname.text];
            [sizesurl appendString:@"&collar="];
            NSString *collar = [self.measure.collar stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:collar];
            [sizesurl appendString:@"&chest="];
            NSString *chest = [self.measure.chest stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:chest];
            [sizesurl appendString:@"&sleeve="];
            NSString *sleeve = [self.measure.sleeve stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:sleeve];
            [sizesurl appendString:@"&shoulder="];
            NSString *shoulder = [self.measure.shoulder stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:shoulder];
            [sizesurl appendString:@"&arm="];
            NSString *arm = [self.measure.arm stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:arm];
            [sizesurl appendString:@"&wrist="];
            NSString *wrist = [self.measure.wrist stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:wrist];
            [sizesurl appendString:@"&belly="];
            NSString *belly = [self.measure.belly stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:belly];
            [sizesurl appendString:@"&waist="];
            NSString *waist = [self.measure.waist stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:waist];
            [sizesurl appendString:@"&back="];
            NSString *back = [self.measure.back stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:back];
            [sizesurl appendString:@"&predicted="];
            [sizesurl appendString:self.measure.predictedSize];
        }else if([self.measure.gender isEqualToString:@"F"]){
            sizesurl = [[NSMutableString alloc ]initWithString:@"http://bivoapp.eu01.aws.af.cm/female.php?mail="];
            [sizesurl appendString:self.txtEmail.text];
            [sizesurl appendString:@"&firstname="];
            [sizesurl appendString:self.txtFirstname.text];
            [sizesurl appendString:@"&surname="];
            [sizesurl appendString:self.txtLastname.text];
            [sizesurl appendString:@"&upperbust="];
            NSString *upperbust = [self.measure.upperbust stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:upperbust];
            [sizesurl appendString:@"&underbust="];
            NSString *underbust = [self.measure.underbust stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:underbust];
            [sizesurl appendString:@"&hip="];
            NSString *hips = [self.measure.hips stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:hips];
            [sizesurl appendString:@"&sleeve="];
            NSString *sleeve = [self.measure.sleeve stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:sleeve];
            [sizesurl appendString:@"&shoulder="];
            NSString *shoulder = [self.measure.shoulder stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:shoulder];
            [sizesurl appendString:@"&arm="];
            NSString *arm = [self.measure.arm stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:arm];
            [sizesurl appendString:@"&wrist="];
            NSString *wrist = [self.measure.wrist stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:wrist];
            [sizesurl appendString:@"&waist="];
            NSString *waist = [self.measure.waist stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:waist];
            [sizesurl appendString:@"&back="];
            NSString *back = [self.measure.back stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [sizesurl appendString:back];
            //[sizesurl appendString:@"&predicted="];
            //[sizesurl appendString:self.measure.prediction];
        }
        
        
        NSLog(@"%@", sizesurl);
        
        //ecomm@bivolino.com&firstname=robin&surname=goris&collar=1.2&chest=1&sleeve=2&shoulder=14&arm=323&wrist=2323&belly=1323&waist=676&back=2323&predicted=2323&size=cm"
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                        initWithURL:[NSURL
                                                     URLWithString:sizesurl]];
        
        
        NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
        if (theConnection) {
            NSLog(@"Gelukt");
        }else{
            NSLog(@"Niet Gelukt");
        }
    }
}
*/
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Finished");
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background_app.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    // Do any additional setup after loading the view.
}


@end
