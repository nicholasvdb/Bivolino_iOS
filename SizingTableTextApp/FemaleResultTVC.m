//
//  FemaleResultTVC.m
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 25/04/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import "FemaleResultTVC.h"
#import "MACAddress.h"
#import "KGModal.h"
#import "CustomCell.h"
#import "MailViewController.h"
#import "Measure.h"


@interface FemaleResultTVC ()

@property (nonatomic, retain) BioAppProxy *service;



@property (weak, nonatomic) IBOutlet UITableViewCell *underbustCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *sleeveCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *shoulderCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *waistCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *armCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *wristCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *backCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *upperbustCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *hipsCell;


@property (weak, nonatomic) IBOutlet UITableViewCell *sizePredictionCell;


@property (weak, nonatomic) IBOutlet UITableViewCell *bmiCell;



@end

@implementation FemaleResultTVC

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
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    self.service = [[BioAppProxy alloc] initWithUrl:@"http://biometric.bivolino.com:81/csp/div/BioApp.cls" AndDelegate:self];
    
    [self.service CalculateSize:self.female.gender :self.female.cm :self.female.age :self.female.weight :self.female.height :@"" :[MACAddress address] :@"test@gmail.com" :self.female.cup :self.female.arms :self.female.waist :self.female.hips];

    //CalculateSize:(NSString *)Gender :(NSString *)Cm :(NSString *)Age :(NSString *)Weight :(NSString *)Height :(NSString *)Collarsize :(NSString *)Fit :(NSString *)Email :(NSString *)FCup :(NSString *)FArms :(NSString *)FWaist :(NSString *)FHips
}



- (void)setUIColors
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_small2"]];
    UIColor * color = [UIColor colorWithRed:0/255.0f green:153/255.0f blue:204/255.0f alpha:1.0f];
    self.tabBarController.navigationController.navigationBar.tintColor = color;
       [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_app.jpg"]]];
}
 

-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goToMail"]) {
        
        // Get destination view
        /*MailViewController *secondView = [segue destinationViewController];
        Measure *m = [[Measure alloc] init];
        m.underbust = self.underbustCell.detailTextLabel.text;
        m.sleeve = self.sleeveCell.detailTextLabel.text;
        m.shoulder = self.shoulderCell.detailTextLabel.text;
        m.hips = self.hipsCell.detailTextLabel.text;
        m.upperbust = self.upperbustCell.detailTextLabel.text;
        m.waist = self.waistCell.detailTextLabel.text;
        m.arm = self.armCell.detailTextLabel.text;
        m.wrist = self.wristCell.detailTextLabel.text;
        m.back = self.backCell.detailTextLabel.text;
        m.predictedSize = self.sizePredictionCell.detailTextLabel.text;
        m.bmi = self.bmiCell.detailTextLabel.text;
        m.gender = self.female.gender;
        secondView.measure = m;
         */
    }
}

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self showPopupImage:cell];
}


-(void)showPopupImage:(UITableViewCell *)cell
{
    UIImage *image;
    if ([cell isEqual:self.underbustCell]) {
        image = [UIImage imageNamed:@"underbust.png"];
    }else if([cell isEqual:self.sleeveCell]){
        image = [UIImage imageNamed:@"sleeve_female.png"];
    }else if([cell isEqual:self.shoulderCell]){
        image = [UIImage imageNamed:@"shoulder_female.png"];
    }else if([cell isEqual:self.waistCell]){
        image = [UIImage imageNamed:@"waist_female.png"];
    }else if([cell isEqual:self.armCell]){
        image = [UIImage imageNamed:@"arm_female.png"];
    }else if([cell isEqual:self.wristCell]){
        image = [UIImage imageNamed:@"wrist_female.png"];
    }else if([cell isEqual:self.backCell]){
        image = [UIImage imageNamed:@"back_female.png"];
    }else if([cell isEqual:self.upperbustCell]){
        image = [UIImage imageNamed:@"upperbust.png"];
    }else if([cell isEqual:self.hipsCell]){
        image = [UIImage imageNamed:@"hip_female.png"];
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
    if ([data isKindOfClass:[Antwoord class]]){
        Antwoord *d = (Antwoord *)data;
        Measure *sizes = [[Measure alloc] init];
        
        sizes.gender = @"F";
        sizes.cm = self.female.cm;
        sizes.underbust = d.underBust;
        sizes.upperbust = d.upperBust;
        sizes.hips = d.hips;
        sizes.sleeve = [NSString stringWithFormat:@"%.1f", d.sleeve];
        sizes.shoulder = [NSString stringWithFormat:@"%.1f", d.shoulder];
        sizes.waist = [NSString stringWithFormat:@"%.1f", d.waist];
        sizes.arm = [NSString stringWithFormat:@"%.1f", d.arm];
        sizes.wrist = [NSString stringWithFormat:@"%.1f", d.wrist];
        sizes.back = [NSString stringWithFormat:@"%.1f", d.back];
        sizes.predictedSize = [NSString stringWithFormat:@"%.1f", d.sizePredicition];
        
        NSArray *keys = @[@"gender", @"cm", @"upperbust", @"underbust", @"hips", @"sleeve", @"shoulder", @"waist", @"arm", @"wrist", @"back", @"predictedSize"];
        NSArray *sizesArray = @[sizes.gender, sizes.cm, sizes.upperbust, sizes.underbust,sizes.hips, sizes.sleeve, sizes.shoulder, sizes.waist, sizes.arm, sizes.wrist, sizes.back, sizes.predictedSize];
        NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects:sizesArray forKeys:keys];
        
        NSString *key = @"measures";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:dictionary forKey:key];
        [defaults synchronize];
    
        
        
        
        if ([self.female.cm isEqualToString:@"1"]){
            self.underbustCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ cm", d.underBust];
            self.upperbustCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ cm", d.upperBust];
            self.hipsCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ cm", d.hips];
            self.sleeveCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.sleeve];
            self.shoulderCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.shoulder];
            self.waistCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.waist];
            self.armCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.arm];
            self.wristCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.wrist];
            self.backCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f cm", d.back];
            self.sizePredictionCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f", d.sizePredicition];
            self.bmiCell.detailTextLabel.text = [NSString stringWithFormat:@"%@", d.bmi];
        }else if ([self.female.cm isEqualToString:@"2"]){
            self.underbustCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ inches", d.underBust];
            self.upperbustCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ inches", d.upperBust];
            self.hipsCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ inches", d.hips];
            self.sleeveCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inches", d.sleeve];
            self.shoulderCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inches", d.shoulder];
            self.waistCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inches", d.waist];
            self.armCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inches", d.arm];
            self.wristCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inches", d.wrist];
            self.backCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f inches", d.back];
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
