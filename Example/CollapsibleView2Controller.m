//
//  CollapsibleView2Controller.m
//  PLXCollapsibleView
//
//  Created by pjv on 5/7/12.
//  Copyright (c) 2012 Plexus Publishing, LLC. All rights reserved.
//

#import "CollapsibleView2Controller.h"

@interface CollapsibleView2Controller ()

@end

@implementation CollapsibleView2Controller

- (void) awakeFromNib {
  [super awakeFromNib];
  
  // override defaults
  self.animated = TRUE;
  self.animationDuration = 0.1;
  self.collapsedSize = NSMakeSize(300, 20);
  self.expandedSize = NSMakeSize(300, 120);
  self.isExpanded = FALSE; 
  
  [self setupSize];
}

@end
