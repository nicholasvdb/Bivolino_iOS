//
//  RegisterTVC.m
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 17/05/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import "RegisterTVC.h"
#import "SBJson.h"


@interface RegisterTVC ()
{
    UIToolbar *toolbar;
    UISegmentedControl *segmentedControl;
    UIPickerView *picker;
    NSArray *languages;
    NSURLConnection *con;
    UIActivityIndicatorView *loader;
}

@property (weak, nonatomic) IBOutlet UITextField *txtFirstname;
@property (weak, nonatomic) IBOutlet UITextField *txtLastname;
@property (weak, nonatomic) IBOutlet UITextField *txtLanguage;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
//@property (weak, nonatomic) UIToolbar *toolbar;




@end

@implementation RegisterTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    self.txtFirstname.inputAccessoryView = toolbar;
    self.txtLastname.inputAccessoryView = toolbar;
    //self.txtLanguage.inputAccessoryView = toolbar;
    self.txtEmail.inputAccessoryView = toolbar;
    self.txtPassword.inputAccessoryView = toolbar;
    
    self.txtFirstname.delegate = self;
    self.txtLastname.delegate = self;
    self.txtLanguage.delegate = self;
    self.txtEmail.delegate = self;
    self.txtPassword.delegate = self;
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    picker.delegate = self;
    picker.dataSource = self;
    [picker setShowsSelectionIndicator:YES];
    
    languages = [[NSArray alloc] initWithObjects:@"English", @"French", @"German", @"Dutch", nil];
    
    self.txtLanguage.inputView = picker;
    self.txtLanguage.inputAccessoryView = toolbar;
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    }
    return 1;
}

-(void)resignKeyboard:(id)sender
{
    if ([self.txtFirstname isFirstResponder]){
        [self.txtFirstname resignFirstResponder];
    }else if ([self.txtLastname isFirstResponder]){
        [self.txtLastname resignFirstResponder];
    }else if ([self.txtLanguage isFirstResponder]){
        [self.txtLanguage resignFirstResponder];
    }else if ([self.txtEmail isFirstResponder]){
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
            }else if ([self.txtEmail isFirstResponder]){
                [self.txtLanguage becomeFirstResponder];
            }else if ([self.txtLanguage isFirstResponder]){
                [self.txtLastname becomeFirstResponder];
            }else if ([self.txtLastname isFirstResponder]){
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                [segmentedControl setEnabled:NO forSegmentAtIndex:0];
                [segmentedControl setEnabled:YES forSegmentAtIndex:1];
                [self.txtFirstname becomeFirstResponder];
            }
            break;
        case 1:
            // next
            [segmentedControl setEnabled:YES forSegmentAtIndex:1];
            if ([self.txtFirstname isFirstResponder]) {
                [segmentedControl setEnabled:YES forSegmentAtIndex:0];
                [self.txtLastname becomeFirstResponder];
            }else if ([self.txtLastname isFirstResponder]){
                [self.txtLanguage becomeFirstResponder];
            }else if ([self.txtLanguage isFirstResponder]){
                [self.txtEmail becomeFirstResponder];
            }else if ([self.txtEmail isFirstResponder]){
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                [self.txtPassword becomeFirstResponder];
                [segmentedControl setEnabled:YES forSegmentAtIndex:0];
                [segmentedControl setEnabled:NO forSegmentAtIndex:1];
            }
            break;
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.txtFirstname]) {
        [segmentedControl setEnabled:NO forSegmentAtIndex:0];
        [segmentedControl setEnabled:YES forSegmentAtIndex:1];
    }else if ([textField isEqual:self.txtPassword]){
        [segmentedControl setEnabled:YES forSegmentAtIndex:0];
        [segmentedControl setEnabled:NO forSegmentAtIndex:1];
    }else {
        [segmentedControl setEnabled:YES forSegmentAtIndex:0];
        [segmentedControl setEnabled:YES forSegmentAtIndex:1];
    }
}

//name, fname, email, language, addtonews, password

-(void)requestServer
{
    
    if([self.txtEmail.text isEqualToString:@""] || [self.txtPassword.text isEqualToString:@""] || [self.txtFirstname.text isEqualToString:@""] || [self.txtLastname.text isEqualToString:@""] || [self.txtLanguage.text isEqualToString:@""]){
        [self alertStatus:@"Please fill in all fields" withTitle:@"Registration failed"];
    }else{
        loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loader startAnimating];
        NSString *newsletter;
        if ([self.switcher isOn]){
            newsletter = @"1";
        }else{
            newsletter = @"0";
        }
        NSString *post = [[NSString alloc] initWithFormat:@"name=%@&fname=%@&language=%@&email=%@&password=%@&addtonews=%@", self.txtLastname.text, self.txtFirstname.text, self.txtLanguage.text, self.txtEmail.text, self.txtPassword.text, newsletter];
        NSLog(@"PostData: %@", post);
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
        NSString *postLength = [[NSString alloc] initWithFormat:@"%d", [postData length]];
        
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://bivoapp.eu01.aws.af.cm/adduser.php"]];
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
                    [self alertStatus:@"Your account has succesfully been created. Please check your mail to activate your account." withTitle:@"Account Created"];
                    [loader stopAnimating];
                    
                    
                } else {
                    [loader stopAnimating];
                    [self alertStatus:@"An error occurred while creating your account. Please try again." withTitle:@"Error"];
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



#pragma mark - picker view delegate/datasource

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [languages objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [languages count];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.txtLanguage.text = [languages objectAtIndex:row];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0){
        UIView *customTitleView = [ [UIView alloc] initWithFrame:CGRectMake(10, 0, self.tableView.frame.size.width, 44)];
        
        UILabel *titleLabel;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(55, 0, self.tableView.frame.size.width, 44)];
        }else{
            titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(20, 0, self.tableView.frame.size.width, 44)];
        }
        
        titleLabel.text = @"Please fill out the form";
        
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        titleLabel.textColor = [UIColor orangeColor];
        
        titleLabel.backgroundColor = [UIColor clearColor];
        
        [customTitleView addSubview:titleLabel];
        
        return customTitleView;
    }
    return nil;
}

-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        [self requestServer];
    }
}
- (void)viewDidUnload {
    [self setSwitcher:nil];
    [super viewDidUnload];
}
@end
