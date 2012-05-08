//
//  StaticView2Controller.m
//  PLXCollapsibleView
//
//  Created by pjv on 5/7/12.
//  Copyright (c) 2012 Plexus Publishing, LLC. All rights reserved.
//

#import "StaticView2Controller.h"

@interface StaticView2Controller ()

@end

@implementation StaticView2Controller

- (void) awakeFromNib {
  [super awakeFromNib];
  
  // override default size 
  self.heightConstraint.constant = 120; // height of view
  self.widthConstraint.constant = 300; // width of view
}

@end
