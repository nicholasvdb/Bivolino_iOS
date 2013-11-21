//
//  CustomCell.m
//  SizingTableTextApp
//
//  Created by Nicholas Vandenbroeck on 07/05/13.
//  Copyright (c) 2013 Nicholas Vandenbroeck. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    UIColor * color = [UIColor colorWithRed:249/255.0f green:168/255.0f blue:58/255.0f alpha:1.0f];
    if (highlighted) {
        self.backgroundColor = color;
        self.textLabel.textColor = [UIColor blackColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
        self.textLabel.textColor = [UIColor blackColor];
    }
}

- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType
{
    if (accessoryType == UITableViewCellAccessoryDisclosureIndicator)
    {
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"info_icon.png"]];
    }
    else
    {
        [super setAccessoryType:accessoryType];
    }
}

@end
