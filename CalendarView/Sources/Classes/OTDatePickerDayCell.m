//
//  OTDatePickerDayCell.m
//  CalendarView
//
//  Created by Oleksii Taran on 1/19/14.
//  Copyright (c) 2014 Oleksii Taran. All rights reserved.
//

#import "OTDatePickerDayCell.h"


@implementation OTDatePickerDayCell

- (void)prepareForReuse
{
	[super prepareForReuse];
	
	self.dayLabel.backgroundColor = [UIColor clearColor];
}

@end
