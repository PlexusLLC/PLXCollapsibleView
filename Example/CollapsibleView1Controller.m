//
//  CollapsibleView1Controller.m
//  PLXCollapsibleView
//
//  Created by pjv on 5/7/12.
//  Copyright (c) 2012 Plexus Publishing, LLC. All rights reserved.
//

#import "CollapsibleView1Controller.h"

@interface CollapsibleView1Controller ()

@end

@implementation CollapsibleView1Controller

- (void) awakeFromNib {
  [super awakeFromNib];
  
  // override defaults
  self.animated = TRUE;
  self.animationDuration = 1.0;
  self.collapsedSize = NSMakeSize(300, 20);
  self.expandedSize = NSMakeSize(300, 120);
  self.isExpanded = FALSE; 
  
  [self setupSize];
}

@end
