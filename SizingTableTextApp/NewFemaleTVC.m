//
//  NewFemaleTVC.m
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 18/04/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import "NewFemaleTVC.h"
#import "FemaleResultTVC.h"
#import "Female.h"
#import "Reachability.h"
#import "NewMaleTVC.h"

#define kPickerAnimationDuration 0.7


@interface NewFemaleTVC ()
{
    UIPopoverController *popOverController;
    UIToolbar *toolBar;
}
@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, strong) NSMutableArray *heightInchArray;
@property (nonatomic, strong) NSMutableArray *weightArray;
@property (nonatomic, strong) NSMutableArray *ageArray;
@property (nonatomic, strong) NSMutableArray *cupSizeEuArray;
@property (nonatomic, strong) NSMutableArray *cupSizeFrArray;
@property (nonatomic, strong) NSMutableArray *cupSizeCombinedArray;
@property (nonatomic, strong) NSMutableArray *cupSizeUkArray;
@property (nonatomic, strong) NSMutableArray *cupLetterArray;
@property (nonatomic, strong) NSMutableArray *waistSizeArray;
@property (nonatomic, strong) NSMutableArray *armLengthArray;
@property (nonatomic, strong) NSMutableArray *hipSizeArray;

@property (nonatomic, strong) UIPickerView *heightPicker;
@property (nonatomic, strong) UIPickerView *weightPicker;
@property (nonatomic, strong) UIPickerView *agePicker;
@property (nonatomic, strong) UIPickerView *cupSizePicker;
@property (nonatomic, strong) UIPickerView *waistSizePicker;
@property (nonatomic, strong) UIPickerView *armLengthPicker;
@property (nonatomic, strong) UIPickerView *hipSizePicker;

@property (weak, nonatomic) IBOutlet UITableViewCell *heightCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *weightCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *ageCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *cupSizeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *waistSizeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *armLengthCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *hipSizeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *calculateCell;



@property (nonatomic, strong) NSMutableString *cupSize;
@property (nonatomic, strong) NSMutableString *cupLetter;
@property (nonatomic, strong) NSMutableString *additionalMeasure;

@property (nonatomic) BOOL isMetric;
@property (nonatomic, strong) UISwitch *switcher;
@property (nonatomic, strong) NSUserDefaults *defaults;

@property (strong, nonatomic) UIActionSheet *actionSheet;

@property (weak, nonatomic) IBOutlet UIView *menuView;
//@property (weak, nonatomic) IBOutlet UILabel *lblSetting;
//@property (weak, nonatomic) IBOutlet UISwitch *switcher;

@property (nonatomic) BOOL slideOut;


@end

@implementation NewFemaleTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)toggleMetric:(UISwitch *)sender
{
    NSString *key = @"metric";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([sender isOn]){
        [defaults setObject:@"0" forKey:key];
    }else{
        [defaults setObject:@"1" forKey:key];
    }
    self.isMetric = [defaults boolForKey:key];
    
    [defaults synchronize];
    
    [self initArrays];
    [self.heightPicker reloadAllComponents];
    [self.weightPicker reloadAllComponents];
    [self.agePicker reloadAllComponents];
    [self.cupSizePicker reloadAllComponents];
    [self.waistSizePicker reloadAllComponents];
    [self.armLengthPicker reloadAllComponents];
    [self.hipSizePicker reloadAllComponents];
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
    [self.cupSizePicker reloadAllComponents];
    [self.waistSizePicker reloadAllComponents];
    [self.armLengthPicker reloadAllComponents];
    [self.hipSizePicker reloadAllComponents];
}

- (void)initArrays
{
    self.cupSizeEuArray = [[NSMutableArray alloc] init];
    for (int i = 65; i <= 110; i+=5) {
        [self.cupSizeEuArray addObject:[NSString stringWithFormat:@"%d (Eu)", i]];
    }
    // initwithcapacity => performance
    
    if (![self.switcher isOn]) {
        self.heightArray = [[NSMutableArray alloc] init];
        for (int i = 150; i <= 215; i++){
            [self.heightArray addObject:[NSString stringWithFormat:@"%d cm", i]];
        }
        
        self.weightArray = [[NSMutableArray alloc] init];
        for (int i = 45; i <= 165; i++){
            [self.weightArray addObject:[NSString stringWithFormat:@"%d kg", i]];
        }
        
        
        self.cupSizeFrArray = [[NSMutableArray alloc]init];
        for (int i = 80; i <= 125; i+=5) {
            [self.cupSizeFrArray addObject:[NSString stringWithFormat:@"%d (Fr)", i]];
        }
        self.cupSizeCombinedArray = [[NSMutableArray alloc] init];
        [self.cupSizeCombinedArray addObjectsFromArray:self.cupSizeFrArray];
        [self.cupSizeCombinedArray addObjectsFromArray:self.cupSizeEuArray];
        
        
        
    }else{
        // UK Sizes
        
        // cup size
        self.cupSizeUkArray = [[NSMutableArray alloc] init];
        for (int i = 30; i <= 48; i+=2){
            [self.cupSizeUkArray addObject:[NSString stringWithFormat:@"%d (Uk)", i]];
            
        }
        
        
        //height
        self.heightArray = [[NSMutableArray alloc] init];
        for (int i = 4; i <= 6; i++) {
            [self.heightArray addObject:[NSString stringWithFormat:@"%d feet", i]];
        }
        
        self.heightInchArray = [[NSMutableArray alloc] init];
        for (float i = 0; i <= 11.5; i+= 0.5) {
            [self.heightInchArray addObject:[NSString stringWithFormat:@"%.1f inches", i]];
        }
        
        //weight
        self.weightArray = [[NSMutableArray alloc] init];
        float stone = 6.0;
        int index = 10;
        for (int i = 94; i < 242; i++){
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
    
    self.cupLetterArray = [[NSMutableArray alloc] initWithCapacity:8];
    [self.cupLetterArray addObject:@"AA"];
    [self.cupLetterArray addObject:@"A"];
    [self.cupLetterArray addObject:@"B"];
    [self.cupLetterArray addObject:@"C"];
    [self.cupLetterArray addObject:@"D"];
    [self.cupLetterArray addObject:@"DD/E"];
    [self.cupLetterArray addObject:@"F"];
    [self.cupLetterArray addObject:@"G"];
    
    
    self.waistSizeArray = [[NSMutableArray alloc] initWithCapacity:5];
    [self.waistSizeArray addObject:@"xsmall"];
    [self.waistSizeArray addObject:@"small"];
    [self.waistSizeArray addObject:@"average"];
    [self.waistSizeArray addObject:@"large"];
    [self.waistSizeArray addObject:@"xlarge"];
    
    self.armLengthArray = [[NSMutableArray alloc] initWithCapacity:3];
    [self.armLengthArray addObject:@"short"];
    [self.armLengthArray addObject:@"normal"];
    [self.armLengthArray addObject:@"long"];
    
    self.hipSizeArray = [[NSMutableArray alloc] initWithCapacity:5];
    [self.hipSizeArray addObject:@"xslender"];
    [self.hipSizeArray addObject:@"slender"];
    [self.hipSizeArray addObject:@"average"];
    [self.hipSizeArray addObject:@"fuller"];
    [self.hipSizeArray addObject:@"xfull"];
    
}

- (void) initPickers
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
    
    self.cupSizePicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.cupSizePicker.delegate = self;
    self.cupSizePicker.dataSource = self;
    [self.cupSizePicker setShowsSelectionIndicator:YES];
    
    self.waistSizePicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.waistSizePicker.delegate = self;
    self.waistSizePicker.dataSource = self;
    [self.waistSizePicker setShowsSelectionIndicator:YES];
    
    self.armLengthPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.armLengthPicker.delegate = self;
    self.armLengthPicker.dataSource = self;
    [self.armLengthPicker setShowsSelectionIndicator:YES];
    
    self.hipSizePicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.hipSizePicker.delegate = self;
    self.hipSizePicker.dataSource = self;
    [self.hipSizePicker setShowsSelectionIndicator:YES];
}

-(void)getSwitchMenu:(UIButton *)sender
{
    NSLog(@"Show info please");
    if (self.slideOut) {
        
        [self.tableView addSubview:self.menuView];
        [UIView animateWithDuration:0.7
                         animations:^{
                             self.menuView.frame = CGRectMake(self.tableView.frame.origin.x,self.tableView.frame.origin.y, self.tableView.frame.size.width, 44);
                         }
                         completion:^(BOOL finished) {
                             //[self.actionSheet removeFromSuperview];
                         }];
        
        self.slideOut = NO;
        
    }else{
        [UIView animateWithDuration:0.7
                         animations:^{
                             self.menuView.frame = CGRectMake(self.menuView.frame.origin.x,self.menuView.frame.origin.y, self.menuView.frame.size.width, 0);
                             
                         }
                         completion:^(BOOL finished){
                             [self.menuView removeFromSuperview];
                         }];
        self.slideOut = YES;
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [self initSettings];
    [self addInfoButton];
    
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
    UIColor * color = [UIColor colorWithRed:249/255.0f green:168/255.0f blue:58/255.0f alpha:1.0f];
    [self.calculateCell setBackgroundColor:color];
    self.menuView.frame = CGRectMake(self.tableView.frame.origin.x,self.tableView.frame.origin.y, self.tableView.frame.size.width, 44);
    [self.switcher addTarget:self action:@selector(toggleMetric:) forControlEvents:UIControlEventValueChanged];
    self.slideOut = NO;
    [super viewDidLoad];
    //[self initSettings];
    //[self initArrays];
    [self initPickers];
    [self addInfoButton];
    [self setUIColors];
    
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

- (void)setUIColors
{
    
    UIColor * color = [UIColor colorWithRed:0/255.0f green:153/255.0f blue:204/255.0f alpha:1.0f];
    self.tabBarController.navigationController.navigationBar.tintColor = color;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_small2"]];
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_app.jpg"]]];
    
    
}


- (void)addTabBarIcons
{
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Women" image:nil tag:0];
    [[self tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"woman-icon.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"woman-icon.png"]];
    [[self tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor whiteColor], UITextAttributeTextColor,
                                               nil] forState:UIControlStateNormal];
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
    if  (section == 0){
        return 4;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 1;
    }
    return 0;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
    if ([targetCell isEqual:self.heightCell]){
        [self appropriatePicker:self.heightPicker inCell:self.heightCell];
    }else if ([targetCell isEqual:self.weightCell]){
        [self appropriatePicker:self.weightPicker inCell:self.weightCell];
    }else if ([targetCell isEqual:self.ageCell]){
        [self appropriatePicker:self.agePicker inCell:self.ageCell];
    }else if ([targetCell isEqual:self.cupSizeCell]){
        [self appropriatePicker:self.cupSizePicker inCell:self.cupSizeCell];
    }else if ([targetCell isEqual:self.waistSizeCell]){
        [self appropriatePicker:self.waistSizePicker inCell:self.waistSizeCell];
    }else if ([targetCell isEqual:self.armLengthCell]){
        [self appropriatePicker:self.armLengthPicker inCell:self.armLengthCell];
    }else if ([targetCell isEqual:self.hipSizeCell]){
        [self appropriatePicker:self.hipSizePicker inCell:self.hipSizeCell];
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
    if ([self.cupSizeCell.detailTextLabel.text isEqualToString:@""]){
        [error appendString:@"Cup Size is empty.\n"];
    }
    if ([self.waistSizeCell.detailTextLabel.text isEqualToString:@""]){
        [error appendString:@"Waist Size is empty.\n"];
    }
    if ([self.armLengthCell.detailTextLabel.text isEqualToString:@""]){
        [error appendString:@"Arm Length is empty.\n"];
    }
    if ([self.hipSizeCell.detailTextLabel.text isEqualToString:@""]){
        [error appendString:@"Hip Size is empty.\n"];
    }
    
    return error;
}

-(NSString *)coherentValuesCheck
{
    NSLog(@"Komt hier!");
    NSMutableString *error = [[NSMutableString alloc] init];
    if ([self.switcher isOn]) {
        
        if (([self.heightCell.detailTextLabel.text rangeOfString:@"cm"].location != NSNotFound) ||
            ([self.weightCell.detailTextLabel.text rangeOfString:@"kg"].location != NSNotFound) ||
            ([self.cupSizeCell.detailTextLabel.text rangeOfString:@"Fr"].location != NSNotFound)) {
            [error setString:@""];
            [error appendString:@"Metric value(s) used"];
        }
    }else{
        if (([self.heightCell.detailTextLabel.text rangeOfString:@"feet"].location != NSNotFound) ||
            ([self.weightCell.detailTextLabel.text rangeOfString:@"lbs"].location != NSNotFound) ||
            ([self.cupSizeCell.detailTextLabel.text rangeOfString:@"Uk"].location != NSNotFound)) {
            [error setString:@""];
            [error appendString:@"Imperial value(s) used"];
        }
    }
    return error;
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"goToFemaleResults"])
    {
        if ([[self validateInput] isEqualToString:@""] && [[self coherentValuesCheck] isEqualToString:@""]) {
            Reachability *reachability = [Reachability reachabilityForInternetConnection];
            NetworkStatus networkStatus = [reachability currentReachabilityStatus];
            if (networkStatus == ReachableViaWWAN || networkStatus == ReachableViaWiFi) {
                return YES;
            }else{
                NSLog(@"No internet");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test" message:@"Geen internet" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
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
    if ([[segue identifier] isEqualToString:@"goToFemaleResults"]) {
        
        // Get destination view
        FemaleResultTVC *secondView = [segue destinationViewController];
        Female *f = [[Female alloc] init];
        
        f.height = [self getValueForCell:self.heightCell];
        f.weight = [self getValueForCell:self.weightCell];
        f.age = [self getValueForCell:self.ageCell];
        f.cup = [self getValueForCell:self.cupSizeCell];
        
        if ([self.switcher isOn]){
            f.cm = @"2";
        }else{
            f.cm = @"1";
        }
        f.gender = @"F";
        f.arms = self.armLengthCell.detailTextLabel.text;
        f.hips = self.hipSizeCell.detailTextLabel.text;
        f.waist = self.waistSizeCell.detailTextLabel.text;
        secondView.female = f;
    }
    
    
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
        UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissPopup)];
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
    if ([pickerView isEqual:self.heightPicker]){
        if ([self.switcher isOn]){
            return 2;
        }else{
            return 1;
        }
    }
    if ([pickerView isEqual:self.cupSizePicker]) {
        return 2;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.heightPicker]){
        if (![self.switcher isOn]){
            return [self.heightArray count];
        }else{
            if (component == 0){
                return [self.heightArray count];
            }else if (component == 1){
                return [self.heightInchArray count];
            }
        }
    }else if ([pickerView isEqual:self.weightPicker]){
        return [self.weightArray count];
    }else if ([pickerView isEqual:self.agePicker]){
        return [self.ageArray count];
    }else if ([pickerView isEqual:self.cupSizePicker]){
        if (![self.switcher isOn]){
            if (component == 0){
                return [self.cupSizeCombinedArray count];
            }else if (component == 1){
                return [self.cupLetterArray count];
            }
        }else{
            if (component == 0){
                return [self.cupSizeUkArray count];
                NSLog(@"%d", [self.cupSizeUkArray count]);
            }else if (component == 1){
                return [self.cupLetterArray count];
            }
        }
    }else if ([pickerView isEqual:self.waistSizePicker]){
        return [self.waistSizeArray count];
    }else if ([pickerView isEqual:self.armLengthPicker]){
        return [self.armLengthArray count];
    }else if ([pickerView isEqual:self.hipSizePicker]){
        return [self.hipSizeArray count];
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if ([pickerView isEqual:self.heightPicker]){
        if (![self.switcher isOn]){
            return [self.heightArray objectAtIndex:row];
        }else{
            if (component == 0){
                return [self.heightArray objectAtIndex:row];
            }else if (component == 1){
                return [self.heightInchArray objectAtIndex:row];
            }
        }
        
    }else if ([pickerView isEqual:self.weightPicker]){
        return [self.weightArray objectAtIndex:row];
    }else if ([pickerView isEqual:self.agePicker]){
        return [self.ageArray objectAtIndex:row];
    }else if ([pickerView isEqual:self.cupSizePicker]){
        if (![self.switcher isOn]){
            if (component == 0){
                return [self.cupSizeCombinedArray objectAtIndex:row];
            }else if (component == 1){
                return [self.cupLetterArray objectAtIndex:row];
            }
        }else{
            if (component == 0){
                return [self.cupSizeUkArray objectAtIndex:row];
            }else if (component == 1){
                return [self.cupLetterArray objectAtIndex:row];
            }
        }
    }else if ([pickerView isEqual:self.waistSizePicker]){
        return [self.waistSizeArray objectAtIndex:row];
    }else if ([pickerView isEqual:self.armLengthPicker]){
        return [self.armLengthArray objectAtIndex:row];
    }else if ([pickerView isEqual:self.hipSizePicker]){
        return [self.hipSizeArray objectAtIndex:row];
    }
    return @"";
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UITableViewCell *targetCell;
    if ([pickerView isEqual:self.heightPicker]){
        NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:0];
        targetCell = [self.tableView cellForRowAtIndexPath:path];
        if ([self.switcher isOn]){
            NSMutableString *height = [[NSMutableString alloc] init];
            if (component == 0){
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
        }else{
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
    }else if ([pickerView isEqual:self.cupSizePicker]){
        
        //aanpassen
        NSIndexPath* path = [NSIndexPath indexPathForRow:3 inSection:0];
        targetCell = [self.tableView cellForRowAtIndexPath:path];
        NSMutableString *cup = [[NSMutableString alloc] init];
        if (component == 0){
            if (![self.switcher isOn]){
                self.cupSize = [self.cupSizeCombinedArray objectAtIndex:row];
                if (row < 10){
                    self.additionalMeasure = [self.cupSizeCombinedArray objectAtIndex:row + 10];
                }else{
                    self.additionalMeasure = [self.cupSizeCombinedArray objectAtIndex:row - 10];
                }
            }else{
                self.cupSize = [self.cupSizeUkArray objectAtIndex:row];
                self.additionalMeasure = [self.cupSizeEuArray objectAtIndex:row];
            }
            
            NSLog(@"Measure: %@", self.additionalMeasure);
            [cup appendString:self.cupSize];
            NSInteger secondComponentRow = [self.cupSizePicker selectedRowInComponent:1];
            [cup appendString:@" - "];
            self.cupLetter = [self.cupLetterArray objectAtIndex:secondComponentRow];
            [cup appendString:self.cupLetter];
            targetCell.detailTextLabel.text = cup;
        }else if (component == 1){
            NSInteger firstComponentRow = [self.cupSizePicker selectedRowInComponent:0];
            if (![self.switcher isOn]){
                [cup appendString:[self.cupSizeCombinedArray objectAtIndex:firstComponentRow]];
            }else{
                [cup appendString:[self.cupSizeUkArray objectAtIndex:firstComponentRow]];
            }
            
            [cup appendString:@" - "];
            self.cupLetter = [self.cupLetterArray objectAtIndex:row];
            [cup appendString:self.cupLetter];
            targetCell.detailTextLabel.text = cup;
        }
    }else if ([pickerView isEqual:self.waistSizePicker]){
        NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:1];
        targetCell = [self.tableView cellForRowAtIndexPath:path];
        targetCell.detailTextLabel.text = [self.waistSizeArray objectAtIndex:row];
    }else if ([pickerView isEqual:self.armLengthPicker]){
        NSIndexPath* path = [NSIndexPath indexPathForRow:1 inSection:1];
        targetCell = [self.tableView cellForRowAtIndexPath:path];
        targetCell.detailTextLabel.text = [self.armLengthArray objectAtIndex:row];
    }else if ([pickerView isEqual:self.hipSizePicker]){
        NSIndexPath* path = [NSIndexPath indexPathForRow:2 inSection:1];
        targetCell = [self.tableView cellForRowAtIndexPath:path];
        targetCell.detailTextLabel.text = [self.hipSizeArray objectAtIndex:row];
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
    }else if(![self.switcher isOn] && [cell isEqual:self.cupSizeCell]){
        NSString *result = [self.cupSize stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *addM = [self.additionalMeasure stringByReplacingOccurrencesOfString:@" " withString:@""];
        listItems = [result componentsSeparatedByString:@"-"];
        NSLog(@"result: %@", result);
        NSLog(@"addC: %@", addM);
        NSMutableString *cup;
        if ([addM rangeOfString:@"Fr"].location != NSNotFound) {
            cup = [NSMutableString stringWithFormat:@"%@-%@/%@-%@", addM, self.cupLetter, result, self.cupLetter];
        } else {
            cup = [NSMutableString stringWithFormat:@"%@-%@/%@-%@", result, self.cupLetter, addM, self.cupLetter];
        }
        NSLog(@"%@", cup);
        return cup;
    }else if ([self.switcher isOn] && [cell isEqual:self.cupSizeCell]){
        NSString *result = [self.cupSize stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *addC = [self.additionalMeasure stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSMutableString *cup = [NSMutableString stringWithFormat:@"%@-%@/%@-%@", result, self.cupLetter, addC, self.cupLetter];
        NSLog(@"%@", cup);
        return cup;
    }else{
        listItems = [cell.detailTextLabel.text componentsSeparatedByString:@" "];
    }
    //38(uk)-C/85(eu)-C
    return [listItems objectAtIndex:0];
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
    }else if (section == 1){
        UIView *customTitleView = [ [UIView alloc] initWithFrame:CGRectMake(10, 0, self.tableView.frame.size.width, 44)];
        
        UILabel *titleLabel;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(55, 0, self.tableView.frame.size.width, 44)];
        }else{
            titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(20, 0, self.tableView.frame.size.width, 44)];
        }
        
        titleLabel.text = @"Body Shape";
        
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        titleLabel.textColor = [UIColor orangeColor];
        
        titleLabel.backgroundColor = [UIColor clearColor];
        
        [customTitleView addSubview:titleLabel];
        
        return customTitleView;
    }
    return nil;
}



@end
