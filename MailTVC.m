//
//  MailTVC.m
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 18/05/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import "MailTVC.h"
#import "MaleResultTVC.h"
#import "FemaleResultTVC.h"
#import "SBJson.h"

@interface MailTVC ()
{
    UIActivityIndicatorView *loader;
}
@property (weak, nonatomic) IBOutlet UILabel *emailCell;

@end

@implementation MailTVC

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
    NSString *key = @"username";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.emailCell.text = [defaults objectForKey:key];
}

-(void)backToResults:(id)sender
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:NO];
}

-(void)requestServer
{
    
    NSString *key = @"measures";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [defaults objectForKey:key];

    loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [loader startAnimating];
    if ([[dictionary objectForKey:@"gender"] isEqualToString:@"M"])
    {

        NSString *post = [[NSString alloc] initWithFormat:@"email=%@&collar=%@&chest=%@&sleeve=%@&shoulder=%@&arm=%@&wrist=%@&belly=%@&waist=%@&back=%@&predicted=%@&size=%@", [defaults objectForKey:@"username"], [dictionary objectForKey:@"collar"], [dictionary objectForKey:@"chest"], [dictionary objectForKey:@"sleeve"], [dictionary objectForKey:@"shoulder"], [dictionary objectForKey:@"arm"], [dictionary objectForKey:@"wrist"], [dictionary objectForKey:@"belly"], [dictionary objectForKey:@"waist"], [dictionary objectForKey:@"back"], [dictionary objectForKey:@"predictedSize"], [dictionary objectForKey:@"cm"]];
        
        //[dictionary objectForKey:@"collar"], sizes.chest, sizes.sleeve, sizes.shoulder, sizes.arm, sizes.wrist, sizes.belly, sizes.waist, sizes.back, sizes.predictedSize, sizes.cm];
        NSLog(@"PostData: %@", post);
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
        NSString *postLength = [[NSString alloc] initWithFormat:@"%d", [postData length]];
        
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://bivoapp.eu01.aws.af.cm/male.php"]];
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
                    [self alertStatus:@"Your measures have been sent to your mail" withTitle:@"Mail Sended"];
                    [loader stopAnimating];
                    
                    
                } else {
                    [loader stopAnimating];
                    [self alertStatus:@"An unexpected error occurred. Please try again." withTitle:@"Error"];
                }
            });
        }];
        
    }else if ([[dictionary objectForKey:@"gender"] isEqualToString:@"F"]){
        
        NSString *post = [[NSString alloc] initWithFormat:@"email=%@&upperbust=%@&underbust=%@&hip=%@&sleeve=%@&shoulder=%@&arm=%@&wrist=%@&waist=%@&back=%@&predicted=%@&size=%@", [defaults objectForKey:@"username"],[dictionary objectForKey:@"upperbust"], [dictionary objectForKey:@"underbust"], [dictionary objectForKey:@"hips"], [dictionary objectForKey:@"sleeve"], [dictionary objectForKey:@"shoulder"], [dictionary objectForKey:@"arm"], [dictionary objectForKey:@"wrist"], [dictionary objectForKey:@"waist"], [dictionary objectForKey:@"back"], [dictionary objectForKey:@"predictedSize"], [dictionary objectForKey:@"cm"]];
        NSLog(@"PostData: %@", post);
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
        NSString *postLength = [[NSString alloc] initWithFormat:@"%d", [postData length]];

        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://bivoapp.eu01.aws.af.cm/female.php"]];
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
                    [self alertStatus:@"Your measures have been sent to your mail" withTitle:@"Mail Sended"];
                    [loader stopAnimating];
                    
                    
                } else {
                    [loader stopAnimating];
                    [self alertStatus:@"An unexpected error occurred. Please try again." withTitle:@"Error"];
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






#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        NSLog(@"Send mail");
        [self requestServer];
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Do you really want to logout?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
        NSString *key = @"username";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nil forKey:key];
        [defaults synchronize];
        
        //[defaults boolForKey:key];
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
        
        titleLabel.text = @"Logged in as";
        
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        titleLabel.textColor = [UIColor orangeColor];
        
        titleLabel.backgroundColor = [UIColor clearColor];
        
        [customTitleView addSubview:titleLabel];
        
        return customTitleView;
    }else if (section == 2){
        UIView *customTitleView = [ [UIView alloc] initWithFrame:CGRectMake(10, 0, self.tableView.frame.size.width, 44)];
        
        UILabel *titleLabel;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(55, 0, self.tableView.frame.size.width, 44)];
        }else{
            titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(20, 0, self.tableView.frame.size.width, 44)];
        }
        
        titleLabel.text = @"Is this not you?";
        
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        titleLabel.textColor = [UIColor orangeColor];
        
        titleLabel.backgroundColor = [UIColor clearColor];
        
        [customTitleView addSubview:titleLabel];
        
        return customTitleView;
    }
    return nil;
}

@end
