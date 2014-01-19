//
//  OTDatePicker.m
//  CalendarView
//
//  Created by Oleksii Taran on 1/16/14.
//  Copyright (c) 2014 Oleksii Taran. All rights reserved.
//

#import "OTDatePicker.h"
#import "__OTDatePicker.h"


@interface OTDatePicker ()

@property (nonatomic, strong) __OTDatePicker *contentView;

@end


@implementation OTDatePicker

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self loadContentView];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self loadContentView];
	}
	return self;
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated
{
	// TODO: implement animation
	self.date = date;
}

#pragma mark -

- (void)loadContentView
{
	NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"OTDatePicker" owner:nil options:nil];
	__OTDatePicker *contentView = [objects lastObject];
	contentView.frame = self.bounds;
	[self addSubview:contentView];
	self.contentView = contentView;
}

@end
