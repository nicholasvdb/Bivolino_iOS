//
//  LoginTVC.m
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 18/05/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import "LoginTVC.h"
#import "SBJson.h"

@interface LoginTVC ()
{
    UIToolbar *toolbar;
    UISegmentedControl *segmentedControl;
}
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end

@implementation LoginTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    NSString *key = @"username";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:key] != nil){
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIColor * color = [UIColor colorWithRed:0/255.0f green:153/255.0f blue:204/255.0f alpha:1.0f];
    self.navigationController.navigationBar.tintColor = color;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_small2"]];
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_app.jpg"]]];
    if (toolbar == nil)
    {
        toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        toolbar.barStyle = UIBarStyleBlackOpaque;
        
        segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"previous", @"next"]];
        segmentedControl.segmentedControlStyle=UISegmentedControlStyleBar;
        [segmentedControl addTarget:self action:@selector(getField:) forControlEvents:UIControlEventValueChanged];
        UIBarButtonItem *segmentItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
        segmentedControl.momentary = YES;
        
        
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard:)];
        
        [toolbar setItems:@[segmentItem, flexSpace, doneButton]];
    }
    
    
    

    self.txtEmail.inputAccessoryView = toolbar;
    self.txtPassword.inputAccessoryView = toolbar;
    
    self.txtEmail.delegate = self;
    self.txtPassword.delegate = self;
}

-(void)resignKeyboard:(id)sender
{
    if ([self.txtEmail isFirstResponder]){
        [self.txtEmail resignFirstResponder];
    }else if ([self.txtPassword isFirstResponder]){
        [self.txtPassword resignFirstResponder];
    }
}

-(void)getField:(id)sender
{
    switch ([segmentedControl selectedSegmentIndex])
    {
        case 0:
            if ([self.txtPassword isFirstResponder]){
                [self.txtEmail becomeFirstResponder];
                [segmentedControl setEnabled:YES forSegmentAtIndex:1];
            }          break;
        case 1:
            // next
            [segmentedControl setEnabled:YES forSegmentAtIndex:1];
            if ([self.txtEmail isFirstResponder]) {
                [segmentedControl setEnabled:YES forSegmentAtIndex:0];
                [self.txtPassword becomeFirstResponder];
            }
            break;
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.txtEmail]) {
        [segmentedControl setEnabled:NO forSegmentAtIndex:0];
        [segmentedControl setEnabled:YES forSegmentAtIndex:1];
    }else if ([textField isEqual:self.txtPassword]){
        [segmentedControl setEnabled:YES forSegmentAtIndex:0];
        [segmentedControl setEnabled:NO forSegmentAtIndex:1];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self requestServer];
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 2){
        UIView *customTitleView = [ [UIView alloc] initWithFrame:CGRectMake(10, 0, self.tableView.frame.size.width, 44)];
        UILabel *titleLabel;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(55, 0, self.tableView.frame.size.width, 44)];
        }else{
            titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(20, 0, self.tableView.frame.size.width, 44)];
        }
        
        titleLabel.text = @"No account yet?";
        titleLabel.textColor = [UIColor orangeColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        titleLabel.backgroundColor = [UIColor clearColor];
        [customTitleView addSubview:titleLabel];
        return customTitleView;
    }
    return nil;
}

-(void)requestServer
{
    
    if([self.txtEmail.text isEqualToString:@""] || [self.txtPassword.text isEqualToString:@""]){
        [self alertStatus:@"Please enter both email and password" withTitle:@"Login failed"];
    }else{
        NSString *post = [[NSString alloc] initWithFormat:@"email=%@&password=%@", self.txtEmail.text, self.txtPassword.text];
        NSLog(@"PostData: %@", post);
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
        NSString *postLength = [[NSString alloc] initWithFormat:@"%d", [postData length]];
        
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://bivoapp.eu01.aws.af.cm/userlogin.php"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        //NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
            NSString *responseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Response ==> %@", responseData);
            
            SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
            NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
            NSLog(@"%@",jsonData);
            NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
            NSLog(@"%d",success);
            dispatch_async(dispatch_get_main_queue(), ^{
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
                    [self alertStatus:@"Logged in Successfully." withTitle:@"Login Success!"];
                    NSString *key = @"username";
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:self.txtEmail.text forKey:key];
                    [defaults synchronize];
                    
                    [self performSegueWithIdentifier:@"goToMail" sender:self];
                    
                } else {
                    
                    NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                    [self alertStatus:error_msg withTitle:@"Login Failed!"];
                }
            });
        }];
    }
}

-(void)alertStatus:(NSString *)msg withTitle:(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}


@end
