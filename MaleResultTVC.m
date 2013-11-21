//
//  MaleResultTVC.m
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 24/04/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import "MaleResultTVC.h"
#import "MACAddress.h"
#import "KGModal.h"
#import "MailTVC.h"
#import "Measure.h"



@interface MaleResultTVC ()
@property (nonatomic, retain) BioAppProxy *service;


@property (weak, nonatomic) IBOutlet UITableViewCell *collarSizeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *sleeveCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *shoulderCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *chestCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *bellyCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *waistCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *armCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *wristCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *backCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *sizePredictionCell;


@property (weak, nonatomic) IBOutlet UITableViewCell *bmiCell;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadIndicator;

@end

@implementation MaleResultTVC

@synthesize male;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addInfoButton];
    [self setUIColors];
    NSLog(@"%@",[MACAddress address]);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.loadIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 50, 50)] ;
    [self.view addSubview:self.loadIndicator];
    
    [self.loadIndicator startAnimating];
    
    self.tableView.tableHeaderView = self.loadIndicator;
    
    self.service = [[BioAppProxy alloc] initWithUrl:@"http://biometric.bivolino.com:81/csp/div/BioApp.cls" AndDelegate:self];
    
    [self.service CalculateSize:self.male.gender :self.male.cm :self.male.age :self.male.weight :self.male.height :self.male.collarSize :[MACAddress address] :@"test@gmail.com" :@"" :@"" :@"" :@""];

}


-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    
}


- (void)addInfoButton
{

    UIImage *mailImage = [UIImage imageNamed:@"letter_closed.png"];
    UIButton *mailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mailButton addTarget:self action:@selector(getMailForm:) forControlEvents:UIControlEventTouchUpInside];
    mailButton.bounds = CGRectMake( 0, 0, mailImage.size.width, mailImage.size.height);
    [mailButton setImage:mailImage forState:UIControlStateNormal];
    UIBarButtonItem *navMailButton = [[UIBarButtonItem alloc] initWithCustomView:mailButton];
    
    
    self.navigationItem.rightBarButtonItem = navMailButton;
}

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goToMail"]) {
        
        // Get destination view
        MailTVC *secondView = [segue destinationViewController];
        Measure *m = [[Measure alloc] init];
        m.collar = self.collarSizeCell.detailTextLabel.text;
        m.sleeve = self.sleeveCell.detailTextLabel.text;
        m.shoulder = self.shoulderCell.detailTextLabel.text;
        m.chest = self.chestCell.detailTextLabel.text;
        m.belly = self.bellyCell.detailTextLabel.text;
        m.waist = self.waistCell.detailTextLabel.text;
        m.arm = self.armCell.detailTextLabel.text;
        m.wrist = self.wristCell.detailTextLabel.text;
        m.back = self.backCell.detailTextLabel.text;
        m.predictedSize = self.sizePredictionCell.detailTextLabel.text;
       
        
        m.gender = self.male.gender;
        secondView.measure = m;
    }
}
 */

- (void)getMailForm:(UIButton *)sender
{
    NSLog(@"Testing mail");
    NSString *key = @"username";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:key] == nil) {
        [self performSegueWithIdentifier: @"goToLogin" sender: self];
    }else{
        [self performSegueWithIdentifier: @"goToMail" sender: self];
    }

}





- (void)setUIColors
{
    UIColor * color = [UIColor colorWithRed:0/255.0f green:153/255.0f blue:204/255.0f alpha:1.0f];
    self.tabBarController.navigationController.navigationBar.tintColor = color;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_small2"]];
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_app.jpg"]]];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0){
        return 9;
    }
    return 1;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self showPopupImage:cell];
}

-(void)showPopupImage:(UITableViewCell *)cell
{
    UIImage *image;
    if ([cell isEqual:self.collarSizeCell]) {
        image = [UIImage imageNamed:@"collar_male.png"];
    }else if([cell isEqual:self.sleeveCell]){
        image = [UIImage imageNamed:@"sleeve_male.png"];
    }else if([cell isEqual:self.shoulderCell]){
        image = [UIImage imageNamed:@"shoulder_male.png"];
    }else if([cell isEqual:self.chestCell]){
        image = [UIImage imageNamed:@"chest_male.png"];
    }else if([cell isEqual:self.bellyCell]){
        image = [UIImage imageNamed:@"belly_male.png"];
    }else if([cell isEqual:self.waistCell]){
        image = [UIImage imageNamed:@"waist_male.png"];
    }else if([cell isEqual:self.armCell]){
        image = [UIImage imageNamed:@"arm_male.png"];
    }else if([cell isEqual:self.wristCell]){
        image = [UIImage imageNamed:@"wrist_male.png"];
    }else if([cell isEqual:self.backCell]){
        image = [UIImage imageNamed:@"back_male.png"];
    }else if ([cell isEqual:self.bmiCell]){
        image = [UIImage imageNamed:@"bmi.png"];
    }

    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    CGRect imageRect = contentView.bounds;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageRect];
    [imageView setImage:image];
   
    [contentView addSubview:imageView];

    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
}


- (void)proxydidFinishLoadingData:(id)data InMethod:(NSString *)method
{
    NSLog(@"Service done");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    sleep(1);
    [self.loadIndicator stopAnimating];
    //[self.tableView setContentOffset:CGPointMake(0, 40) animated:YES];
    [UIView animateWithDuration:0.7
                     animations:^{
                         [self.tableView setContentOffset:CGPointMake(0, 50) animated:NO];
                     }
                     completion:^(BOOL finished) {
                         [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
                         self.tableView.tableHeaderView = nil;
                     }];
    
    
    
    
    if ([data isKindOfClass:[Antwoord class]]){
        Antwoord *d = (Antwoord *)data;
        Measure *sizes = [[Measure alloc] init];
        
        sizes.gender = @"M";
        sizes.cm = self.male.cm;
        sizes.collar = [NSString stringWithFormat:@"%.1f", d.collarsize];
        sizes.sleeve = [NSString stringWithFormat:@"%.1f", d.sleeve];
        sizes.shoulder = [NSString stringWithFormat:@"%.1f", d.shoulder];
        sizes.chest = [NSString stringWithFormat:@"%.1f", d.chest];
        sizes.waist = [NSString stringWithFormat:@"%.1f", d.waist];
        sizes.belly = [NSString stringWithFormat:@"%.1f", d.belly];
        sizes.arm = [NSString stringWithFormat:@"%.1f", d.arm];
        sizes.wrist = [NSString stringWithFormat:@"%.1f", d.wrist];
        sizes.back = [NSString stringWithFormat:@"%.1f", d.back];
        sizes.predictedSize = [NSString stringWithFormat:@"%.1f", d.sizePredicition];
        
        NSArray *keys = @[@"gender", @"cm", @"collar", @"sleeve", @"shoulder", @"chest", @"waist", @"belly", @"arm", @"wrist", @"back", @"predictedSize"];
        NSArray *sizesArray = @[sizes.gender, sizes.cm, sizes.collar, sizes.sleeve, sizes.shoulder, sizes.chest, sizes.waist, sizes.belly, sizes.arm, sizes.wrist, sizes.back, sizes.predictedSize];
        NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects:sizesArray forKeys:keys];
        
        NSString *key = @"measures";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:dictionary forKey:key];
        [defaults synchronize];
        
        if ([self.male.cm isEqualToString:@"1"]){
            self.collarSizeCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.collarsize];
            self.sleeveCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.sleeve];
            self.shoulderCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.shoulder];
            self.chestCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.chest];
            self.waistCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.waist];
            self.bellyCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.belly];
            self.armCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.arm];
            self.wristCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.wrist];
            self.backCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.back];
            self.sizePredictionCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f", d.sizePredicition];
            self.bmiCell.detailTextLabel.text = [NSString stringWithFormat:@"%@", d.bmi];
        }else if ([self.male.cm isEqualToString:@"2"]){
            self.collarSizeCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inch", d.collarsize];
            self.sleeveCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inch", d.sleeve];
            self.shoulderCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inch", d.shoulder];
            self.chestCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inch", d.chest];
            self.waistCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inch", d.waist];
            self.bellyCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inch", d.belly];
            self.armCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inch", d.arm];
            self.wristCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inch", d.wrist];
            self.backCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inch", d.back];
            self.sizePredictionCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f", d.sizePredicition];
            self.bmiCell.detailTextLabel.text = [NSString stringWithFormat:@"%@", d.bmi];
            
            
        }
        [self.tableView reloadData];
        [self setBMIColor:self.bmiCell.detailTextLabel.text];
    }
}

- (void)setBMIColor:(NSString *)bmiString;
{
    NSArray *listItems = [bmiString componentsSeparatedByString:@" "];
    NSString *bmi = [listItems objectAtIndex:1];
    if ([bmi isEqualToString:@"underweight"] || [bmi isEqualToString:@"overweight"]){
        self.bmiCell.backgroundColor = [UIColor redColor];
    }else{
        self.bmiCell.backgroundColor = [UIColor greenColor];
    }
    
}

- (void)proxyRecievedError:(NSException *)ex InMethod:(NSString *)method
{
    NSLog(@"Error received, %@", method);
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
        
        titleLabel.text = @"My Measurements";
        
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        titleLabel.textColor = [UIColor orangeColor];
        
        titleLabel.backgroundColor = [UIColor clearColor];
        
        [customTitleView addSubview:titleLabel];
        
        return customTitleView;
    }else if (section == 1){
        UIView *customTitleView = [ [UIView alloc] initWithFrame:CGRectMake(10, 0, self.tableView.frame.size.width, 44)];
        
        UILabel *titleLabel;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(55, 0, self.tableView.frame.size.width, 44)];
        }else{
            titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(20, 0, self.tableView.frame.size.width, 44)];
        }
        
        titleLabel.text = @"My Shirt Size";
        
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
        
        titleLabel.text = @"My Body Mass Index";
        
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        titleLabel.textColor = [UIColor orangeColor];
        
        titleLabel.backgroundColor = [UIColor clearColor];
        
        [customTitleView addSubview:titleLabel];
        
        return customTitleView;
    }
    return nil;
}

@end
