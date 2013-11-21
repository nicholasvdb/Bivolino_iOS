//
//  NewMaleTVC.m
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 18/04/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import "NewMaleTVC.h"
#import "TestViewController.h"
#import "MaleResultTVC.h"
#import "Male.h"
#import "Reachability.h"
#import "CustomCell.h"

#define kPickerAnimationDuration 0.7

@interface NewMaleTVC ()
{
    UIPopoverController *popOverController;
    UIToolbar *toolBar;
}

@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, strong) NSMutableArray *heightInchArray;
@property (nonatomic, strong) NSMutableArray *weightArray;
@property (nonatomic, strong) NSMutableArray *ageArray;
@property (nonatomic, strong) NSMutableArray *collarSizeArray;

@property (nonatomic, strong) UIPickerView *heightPicker;
@property (nonatomic, strong) UIPickerView *weightPicker;
@property (nonatomic, strong) UIPickerView *weightStonePicker;
@property (nonatomic, strong) UIPickerView *agePicker;
@property (nonatomic, strong) UIPickerView *collarSizePicker;

@property (weak, nonatomic) IBOutlet UITableViewCell *heightCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *weightCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *ageCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *collarSizeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *calculateCell;


@property (nonatomic) BOOL isMetric;
@property (nonatomic, strong) UISwitch *switcher;
@property (nonatomic, strong) NSUserDefaults *defaults;
//@property (strong, nonatomic) IBOutlet UISwitch *switcher;
@property (weak, nonatomic) IBOutlet UILabel *lblSetting;

@property (strong, nonatomic) UIActionSheet *actionSheet;

@property (weak, nonatomic) IBOutlet UIView *menuView;

@property (nonatomic) BOOL slideOut;

@end

@implementation NewMaleTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

        
    }
    return self;
}





- (void)toggleMetric:(UISwitch *)sender
{
    NSString *key = @"metric";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([sender isOn]){
        [defaults setBool:NO forKey:key];
    }else{
        [defaults setBool:YES forKey:key];
    }
    [defaults synchronize];
    self.isMetric = [defaults boolForKey:key];
    
    [self initArrays];
    [self.heightPicker reloadAllComponents];
    [self.weightPicker reloadAllComponents];
    [self.agePicker reloadAllComponents];
    [self.collarSizePicker reloadAllComponents];
    
     
}

- (void)initSettings
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLocale *locale = [NSLocale currentLocale];
    
    NSString *key = @"metric";
    NSLog(@"%@", [locale localeIdentifier]);
    if([[NSUserDefaults standardUserDefaults] objectForKey:key] == nil) {
        BOOL metrisch = [[locale objectForKey:NSLocaleUsesMetricSystem] boolValue];
        NSLog(@"%d", metrisch);
        if (metrisch){
            if ([[locale localeIdentifier ] isEqualToString:@"en_GB"]){
                self.isMetric = NO;
                [defaults setObject:[NSNumber numberWithBool:NO] forKey:key];
                [self.switcher setOn:YES];
            }else{
                [defaults setObject:[NSNumber numberWithBool:YES] forKey:key];
                self.isMetric = YES;
                [self.switcher setOn:NO];
            }
        }else{
            self.isMetric = NO;
            [defaults setObject:[NSNumber numberWithBool:NO] forKey:key];
            [self.switcher setOn:YES];
        }
        
    }else{
        self.isMetric = [defaults boolForKey:key];
        [self.switcher setOn:!self.isMetric];
    }

    [defaults synchronize];
    
    
    [self initArrays];
    [self.heightPicker reloadAllComponents];
    [self.weightPicker reloadAllComponents];
    [self.agePicker reloadAllComponents];
    [self.collarSizePicker reloadAllComponents];
    
}

- (void)initArrays
{
    NSLog(@"Init arrays");

    if (![self.switcher isOn]) {
        self.heightArray = [[NSMutableArray alloc] init];
        for (int i = 150; i <= 215; i++){
            [self.heightArray addObject:[NSString stringWithFormat:@"%d cm", i]];
        }
        
        self.weightArray = [[NSMutableArray alloc] init];
        for (int i = 45; i <= 165; i++){
            [self.weightArray addObject:[NSString stringWithFormat:@"%d kg", i]];
        }
        
        self.collarSizeArray = [[NSMutableArray alloc] init];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d / %@", 36, @"XS"]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d", 37]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d / %@", 38, @"S"]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d", 39]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d / %@", 40, @"M"]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d", 41]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d / %@", 42, @"L"]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d", 43]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d / %@", 44, @"XL"]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d", 45]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d / %@", 46, @"2XL"]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d", 47]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d / %@", 48, @"3XL"]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d", 49]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d / %@", 50, @"4XL"]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d", 51]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d / %@", 52, @"5XL"]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d", 53]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d / %@", 54, @"6XL"]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d", 55]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d / %@", 56, @"7XL"]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d", 57]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d / %@", 58, @"8XL"]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d", 59]];
        [self.collarSizeArray addObject:[NSString stringWithFormat:@"%d / %@", 60, @"9XL"]];
    }else {
        self.heightArray = [[NSMutableArray alloc] init];
        for (int i = 4; i <= 7; i++){
            [self.heightArray addObject:[NSString stringWithFormat:@"%d feet", i]];
        }
        
        self.heightInchArray = [[NSMutableArray alloc] init];
        for (float i = 0; i <= 11.5; i += 0.5){
            [self.heightInchArray addObject:[NSString stringWithFormat:@"%.1f inches", i]];
        }
        
        self.collarSizeArray = [[NSMutableArray alloc] init];
        [self.collarSizeArray addObject:@"14.00 inches"];
        [self.collarSizeArray addObject:@"14.50 inches"];
        [self.collarSizeArray addObject:@"15.00 inches"];
        [self.collarSizeArray addObject:@"15.50 inches"];
        [self.collarSizeArray addObject:@"15.75 inches"];
        [self.collarSizeArray addObject:@"16.50 inches"];
        [self.collarSizeArray addObject:@"17.00 inches"];
        [self.collarSizeArray addObject:@"17.50 inches"];
        [self.collarSizeArray addObject:@"17.75 inches"];
        [self.collarSizeArray addObject:@"18.00 inches"];
        [self.collarSizeArray addObject:@"18.50 inches"];
        [self.collarSizeArray addObject:@"19.00 inches"];
        [self.collarSizeArray addObject:@"19.25 inches"];
        [self.collarSizeArray addObject:@"19.50 inches"];
        [self.collarSizeArray addObject:@"20.00 inches"];
        [self.collarSizeArray addObject:@"20.50 inches"];
        [self.collarSizeArray addObject:@"21.00 inches"];
        [self.collarSizeArray addObject:@"21.25 inches"];
        [self.collarSizeArray addObject:@"21.75 inches"];
        [self.collarSizeArray addObject:@"22.00 inches"];
        [self.collarSizeArray addObject:@"22.50 inches"];
        [self.collarSizeArray addObject:@"23.00 inches"];
        [self.collarSizeArray addObject:@"23.25 inches"];
        [self.collarSizeArray addObject:@"23.50 inches"];
        
        self.weightArray = [[NSMutableArray alloc] init];
        float stone = 7.0;
        int index = 1;
        for (int i = 99; i < 366; i++){
            if (index == 13){
                
                [self.weightArray addObject:[NSString stringWithFormat:@"%d/%.0f.%d lbs/stone", i, stone,index]];
                index = 0;
                stone += 1;
            }else{
                [self.weightArray addObject:[NSString stringWithFormat:@"%d/%.0f.%d lbs/stone", i, stone,index]];
                index += 1;
            }
        }
    }
    
    self.ageArray = [[NSMutableArray alloc] init];
    for (int i = 16; i <= 99; i++){
        [self.ageArray addObject:[NSString stringWithFormat:@"%d year", i]];
    }
}

- (void)initPickers
{
    self.heightPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.heightPicker.delegate = self;
    self.heightPicker.dataSource = self;
    [self.heightPicker setShowsSelectionIndicator:YES];
    
    self.weightPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.weightPicker.delegate = self;
    self.weightPicker.dataSource = self;
    [self.weightPicker setShowsSelectionIndicator:YES];
    
    self.agePicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.agePicker.delegate = self;
    self.agePicker.dataSource = self;
    [self.agePicker setShowsSelectionIndicator:YES];
    
    self.collarSizePicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.collarSizePicker.delegate = self;
    self.collarSizePicker.dataSource = self;
    [self.collarSizePicker setShowsSelectionIndicator:YES];
}




- (void)getSwitchMenu:(UIButton *)sender
{
    
    NSLog(@"Show info please");
    if (self.slideOut) {
        //self.menuView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 0);
        
        //[self.switcher addTarget:self action:@selector(toggleMetric:) forControlEvents:UIControlEventValueChanged];
        //[self initSettings];
 

        [self.tableView addSubview:self.menuView];
        [UIView animateWithDuration:0.7
                         animations:^{
                             self.menuView.frame = CGRectMake(self.tableView.frame.origin.x,self.tableView.frame.origin.y, self.tableView.frame.size.width, 44);
                             
                         }
                         completion:^(BOOL finished) {
                             //nothing
                         }];
        self.slideOut = NO;
    }else{
        [UIView animateWithDuration:0.7
                         animations:^{
                             self.menuView.frame = CGRectMake(self.menuView.frame.origin.x,self.menuView.frame.origin.y, self.menuView.frame.size.width, 0);
                             //self.lblSetting.frame = CGRectZero;
                             //self.switcher.frame = CGRectZero;
                         }
                         completion:^(BOOL finished){
                             [self.menuView removeFromSuperview];
                         }];
        self.slideOut = YES;
    }
}

- (BOOL)checkInternet
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changedNetwork)
                                                 name:kReachabilityChangedNotification
                                               object:reachability];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        return NO;
    }
    else {
        return YES;
    }
    
}

- (void) addNotifier
{
    Reachability* reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
}

- (void) reachabilityChanged:(NSNotification*) notification
{
	Reachability* reachability = notification.object;
    
	if(reachability.currentReachabilityStatus == NotReachable){
		NSLog(@"Internet off");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to Load" message:@"No Internet connection available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
	}else{
		NSLog(@"Internet on");
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
   //self.tabBarController.navigationItem.hidesBackButton=YES;
    UIColor * color = [UIColor colorWithRed:249/255.0f green:168/255.0f blue:58/255.0f alpha:1.0f];
    [self.calculateCell setBackgroundColor:color];
    
    
    
    
    
    
    self.slideOut = NO;
    
    //self.switcher = [[UISwitch alloc] init];
    
    //[self initSettings];
    [self addNotifier];
    //[self initArrays];
    [self initPickers];
    [self setUIColors];
    //[self addTabBarIcons];
    [self addInfoButton];
    [self createSettingsView];
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_app.jpg"]]];


        
}

-(void)createSettingsView
{
    self.menuView.frame = CGRectMake(self.tableView.frame.origin.x,self.tableView.frame.origin.y, self.tableView.frame.size.width, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 7.5, 200, 30)];
    label.text = @"Imperial Sizes";
    label.font = [UIFont boldSystemFontOfSize:17.0];
    self.switcher = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 100,7.5, 100, 30)];
    self.switcher.onTintColor = [UIColor orangeColor];
    [self.switcher addTarget:self action:@selector(toggleMetric:) forControlEvents:UIControlEventValueChanged];
    [self.menuView addSubview:label];
    [self.menuView addSubview:self.switcher];
}

#pragma mark - Setting up Layout

- (void)setUIColors
{
    

        UIColor * color = [UIColor colorWithRed:0/255.0f green:153/255.0f blue:204/255.0f alpha:1.0f];
        self.tabBarController.navigationController.navigationBar.tintColor = color;
        self.tabBarController.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_small2"]];


    
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_app.jpg"]]];
}

- (void)addTabBarIcons
{
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Men" image:nil tag:0];
    [[self tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"man-icon.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"man-icon.png"]];
    [[self tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor whiteColor], UITextAttributeTextColor,
                                               nil] forState:UIControlStateNormal];
}

- (void)addInfoButton
{
    
    UIImage *infoImage = [UIImage imageNamed:@"cog_02.png"];
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton addTarget:self action:@selector(getSwitchMenu:) forControlEvents:UIControlEventTouchUpInside];
    infoButton.bounds = CGRectMake( 0, 0, infoImage.size.width, infoImage.size.height);
    [infoButton setImage:infoImage forState:UIControlStateNormal];
    UIBarButtonItem *navButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    
    self.tabBarController.navigationItem.rightBarButtonItem = navButton;
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0){
        return 4;
    }else{
        return 1;
    }
    
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
    if ([targetCell isEqual:self.heightCell]){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self appropriatePicker:self.heightPicker inCell:self.heightCell];
    }else if ([targetCell isEqual:self.weightCell]){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self appropriatePicker:self.weightPicker inCell:self.weightCell];
    }else if ([targetCell isEqual:self.ageCell]){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self appropriatePicker:self.agePicker inCell:self.ageCell];
    }else if ([targetCell isEqual:self.collarSizeCell]){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self appropriatePicker:self.collarSizePicker inCell:self.collarSizeCell];
    }else if ([targetCell isEqual:self.calculateCell]){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (NSString *)validateInput
{
    NSMutableString *error = [[NSMutableString alloc] init];
    if ([self.heightCell.detailTextLabel.text isEqualToString:@""]){
        [error appendString:@"Height is empty.\n"];
    }
    if ([self.weightCell.detailTextLabel.text isEqualToString:@""]){
        [error appendString:@"Weight is empty.\n"];
    }
    if ([self.ageCell.detailTextLabel.text isEqualToString:@""]){
        [error appendString:@"Age is empty.\n"];
    }
    if ([self.collarSizeCell.detailTextLabel.text isEqualToString:@""]){
        [error appendString:@"Collar Size is empty.\n"];
    }
    return error;
}

-(NSString *)coherentValuesCheck
{
    NSMutableString *error = [[NSMutableString alloc] init];
    if ([self.switcher isOn]) {
        if (([self.heightCell.detailTextLabel.text rangeOfString:@"cm"].location != NSNotFound) ||
            ([self.weightCell.detailTextLabel.text rangeOfString:@"kg"].location != NSNotFound) ||
            ([self.collarSizeCell.detailTextLabel.text length] <= 8)) {
            [error setString:@""];
            [error appendString:@"Metric value(s) used"];
        }
    }else{
        if (([self.heightCell.detailTextLabel.text rangeOfString:@"feet"].location != NSNotFound) ||
            ([self.weightCell.detailTextLabel.text rangeOfString:@"lbs"].location != NSNotFound) ||
            ([self.collarSizeCell.detailTextLabel.text rangeOfString:@"inches"].location != NSNotFound)) {
            [error setString:@""];
            [error appendString:@"Imperial value(s) used"];
        }
    }
    return error;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"goToMaleResults"])
    {
        if ([[self validateInput] isEqualToString:@""] && [[self coherentValuesCheck] isEqualToString:@""]) {
            Reachability *reachability = [Reachability reachabilityForInternetConnection];
            NetworkStatus networkStatus = [reachability currentReachabilityStatus];
            if (networkStatus == ReachableViaWWAN || networkStatus == ReachableViaWiFi) {
                return YES;
            }else{
                NSLog(@"No internet");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No internet connection" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
                [alert show];
                
                return NO;
            }
        }else if (![[self validateInput] isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input Error" message:[self validateInput] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            return NO;
        }else if (![[self coherentValuesCheck] isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input Error" message:[self coherentValuesCheck] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goToMaleResults"]) {
        
        // Get destination view
        MaleResultTVC *secondView = [segue destinationViewController];
        Male *m = [[Male alloc] init];
        
        m.height = [self getValueForCell:self.heightCell];
        m.weight = [self getValueForCell:self.weightCell];
        m.age = [self getValueForCell:self.ageCell];
        m.collarSize = [self getValueForCell:self.collarSizeCell];
        if ([self.switcher isOn]){
            m.cm = @"2";
        }else{
            m.cm = @"1";
        }
        m.gender = @"M";
        secondView.male = m;
    }
        
}

- (NSString *)getValueForCell:(UITableViewCell *)cell
{
    NSArray *listItems;
    if ([self.switcher isOn] && ([cell isEqual:self.weightCell])){
        listItems = [cell.detailTextLabel.text componentsSeparatedByString:@"/"];
    }else if([self.switcher isOn] && ([cell isEqual:self.heightCell])){
        NSMutableString *height = [[NSMutableString alloc] initWithString:cell.detailTextLabel.text];
        NSString *p1 = [height stringByReplacingOccurrencesOfString:@" feet " withString:@"'"];
        NSString *p2 = [p1 stringByReplacingOccurrencesOfString:@" inches" withString:@""];
        NSLog(@"%@", p2);
        return p2;
    }else{
        listItems = [cell.detailTextLabel.text componentsSeparatedByString:@" "];
    }
    return [listItems objectAtIndex:0];
}

-(void)viewWillDisappear:(BOOL)animated
{
    //self.tabBarController.navigationItem.titleView = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}


-(void)viewDidAppear:(BOOL)animated
{
    [self initSettings];
    [self addInfoButton];
    //[self setUIColors];
}


- (void) appropriatePicker:(UIPickerView *)picker inCell:(UITableViewCell *)cell
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        UIViewController *popOverContent = [[UIViewController alloc]init];
        UIView *popOverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, picker.frame.size.width, picker.frame.size.height + 44)];
        picker.frame = CGRectMake(popOverView.frame.origin.x, popOverView.frame.origin.y + 44, 0, 0);
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(popOverView.frame.origin.x, popOverView.frame.origin.y + 44, popOverView.frame.size.width, 44)];
        [toolBar setBarStyle:UIBarStyleBlack];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        //UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissPopup)];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPopup)];
        [toolBar setItems:[NSArray arrayWithObjects:flexSpace, doneButton, nil]];
        //picker.frame = CGRectMake(0, 40, self.view.frame.size.width, 216);
        [popOverView addSubview:picker];
        [popOverView addSubview:toolBar];
        
        [popOverContent setView:popOverView];
        
        popOverController = [[UIPopoverController alloc] initWithContentViewController:popOverContent];
        popOverController.popoverContentSize = CGSizeMake(picker.frame.size.width, popOverView.frame.size.height);
        
        [popOverController presentPopoverFromRect:cell.frame inView:[self view] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: nil];
        [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        [self.view addSubview:self.actionSheet];
        
        CGRect rect = CGRectMake(0, self.view.frame.size.height, 0, 0);
        self.actionSheet.frame = rect;
        
        picker.frame = CGRectMake(0, 44, self.view.frame.size.width, 216);
        
        [self.actionSheet addSubview:picker];
        UIToolbar *tools = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        tools.barStyle = UIBarStyleBlackOpaque;
        [self.actionSheet addSubview:tools];
        
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        //UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissPicker)];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker)];
        
        NSArray *array = [[NSArray alloc]initWithObjects:flexSpace, doneButton, nil];
        [tools setItems:array];
        
        [self.actionSheet showFromTabBar:self.tabBarController.tabBar];
        
        [UIView animateWithDuration:0.7
                         animations:^{
                             self.actionSheet.frame = CGRectMake(0, self.view.frame.size.height - (picker.frame.size.height - 11), self.view.frame.size.width, picker.frame.size.height + tools.frame.size.height);
                             
                         }
                         completion:^(BOOL finished) {
                             //[self.actionSheet removeFromSuperview];
                         }];
    }
}

- (void)dismissPicker
{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    //[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [self.tableView reloadData];
}

- (void)dismissPopup
{
    [popOverController dismissPopoverAnimated:YES];
    [self.tableView reloadData];
}


// Picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([pickerView isEqual:self.heightPicker] && [self.switcher isOn]){
        return 2;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.heightPicker]){
        if ([self.switcher isOn]){
            if (component == 0){
                return [self.heightArray count];
            }else if (component == 1){
                return [self.heightInchArray count];
            }
        }else{
            return [self.heightArray count];
        }
    }else if ([pickerView isEqual:self.weightPicker]){
        return [self.weightArray count];
    }else if ([pickerView isEqual:self.agePicker]){
        return [self.ageArray count];
    }else if ([pickerView isEqual:self.collarSizePicker]){
        return [self.collarSizeArray count];
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if ([pickerView isEqual:self.heightPicker]){
        if ([self.switcher isOn]) {
            if (component == 0){
                return [self.heightArray objectAtIndex:row];
            }else if (component == 1){
                return [self.heightInchArray objectAtIndex:row];
            }
        }else{
            return [self.heightArray objectAtIndex:row];
        }
    }else if ([pickerView isEqual:self.weightPicker]){
        return [self.weightArray objectAtIndex:row];
    }else if ([pickerView isEqual:self.agePicker]){
        return [self.ageArray objectAtIndex:row];
    }else if ([pickerView isEqual:self.collarSizePicker]){
        return [self.collarSizeArray objectAtIndex:row];
    }
    return @"";
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UITableViewCell *targetCell;
    
    if ([pickerView isEqual:self.heightPicker]){
        NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:0];
        targetCell = [self.tableView cellForRowAtIndexPath:path];
        if ([pickerView isEqual:self.heightPicker] && [self.switcher isOn]){
            NSMutableString *height = [[NSMutableString alloc] init];
            if (component == 0) {
                [height appendString:[self.heightArray objectAtIndex:row]];
                NSInteger secondComponentRow = [self.heightPicker selectedRowInComponent:1];
                [height appendString:@" "];
                [height appendString:[self.heightInchArray objectAtIndex:secondComponentRow]];
                targetCell.detailTextLabel.text = height;
            }else if (component == 1){
                NSInteger firstComponentRow = [self.heightPicker selectedRowInComponent:0];
                [height appendString:[self.heightArray objectAtIndex:firstComponentRow]];
                [height appendString:@" "];
                [height appendString:[self.heightInchArray objectAtIndex:row]];
                targetCell.detailTextLabel.text = height;
            }
        }else if ([pickerView isEqual:self.heightPicker]){
            targetCell.detailTextLabel.text = [self.heightArray objectAtIndex:row];
        }
        
    }else if ([pickerView isEqual:self.weightPicker]){
        NSIndexPath* path = [NSIndexPath indexPathForRow:1 inSection:0];
        targetCell = [self.tableView cellForRowAtIndexPath:path];
        targetCell.detailTextLabel.text = [self.weightArray objectAtIndex:row];
    }else if ([pickerView isEqual:self.agePicker]){
        NSIndexPath* path = [NSIndexPath indexPathForRow:2 inSection:0];
        targetCell = [self.tableView cellForRowAtIndexPath:path];
        targetCell.detailTextLabel.text = [self.ageArray objectAtIndex:row];
    }else if ([pickerView isEqual:self.collarSizePicker]){
        NSIndexPath* path = [NSIndexPath indexPathForRow:3 inSection:0];
        targetCell = [self.tableView cellForRowAtIndexPath:path];
        targetCell.detailTextLabel.text = [self.collarSizeArray objectAtIndex:row];
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
        
        
        titleLabel.text = @"Your Size";
        
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        titleLabel.textColor = [UIColor orangeColor];
        
        titleLabel.backgroundColor = [UIColor clearColor];
        
        [customTitleView addSubview:titleLabel];
        
        return customTitleView;
    }
    return nil;
}


@end
