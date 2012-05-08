//
//  MainViewController.m
//  PLXCollapsibleView
//
//  Created by pjv on 5/7/12.
//  Copyright (c) 2012 Plexus Publishing, LLC. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize cvc1, cvc2, svc1, svc2, cvOne, cvTwo, svOne, svTwo;

- (void) awakeFromNib {
  [super awakeFromNib];
  
  // initialize subviews
  svc1 = [[StaticView1Controller alloc] initWithNibName:@"StaticView1" bundle:nil];
  self.svOne = self.svc1.view;
  [self.view addSubview:self.svOne];
  
  cvc1 = [[CollapsibleView1Controller alloc] initWithNibName:@"CollapsibleView1" bundle:nil];
  self.cvOne = self.cvc1.view;
  [self.view addSubview:self.cvOne];
  self.cvc1.parentController = self;
  
  svc2 = [[StaticView2Controller alloc] initWithNibName:@"StaticView2" bundle:nil];
  self.svTwo = self.svc2.view;
  [self.view addSubview:self.svTwo];
  
  cvc2 = [[CollapsibleView2Controller alloc] initWithNibName:@"CollapsibleView2" bundle:nil];
  self.cvTwo = self.cvc2.view;
  [self.view addSubview:self.cvTwo];
  self.cvc2.parentController = self;
  
  // setup constraint based layout
  // set up the  subview layout constraints
  NSDictionary *views = NSDictionaryOfVariableBindings(cvOne, cvTwo, svOne, svTwo);
  
  // staticView1
  //width
  [self.view addConstraint:svc1.widthConstraint];
  //height
  [self.view addConstraint:svc1.heightConstraint];
  // position
  [self.view addConstraints:[NSLayoutConstraint 
                             constraintsWithVisualFormat:@"V:|-0-[svOne]" 
                             options:0 metrics:nil views:views]];
  
  // collapsibleView1
  //width
  [self.view addConstraint:cvc1.widthConstraint];
  //height
  [self.view addConstraint:cvc1.heightConstraint];
  //position
  [self.view addConstraints:[NSLayoutConstraint 
                             constraintsWithVisualFormat:@"V:[svOne]-0-[cvOne]" 
                             options:0 metrics:nil views:views]];
  
  // staticView2
  //width
  [self.view addConstraint:svc2.widthConstraint];
  //height
  [self.view addConstraint:svc2.heightConstraint];
  // position
  [self.view addConstraints:[NSLayoutConstraint 
                             constraintsWithVisualFormat:@"V:[cvOne]-0-[svTwo]" 
                             options:0 metrics:nil views:views]];
  
  // collapsibleView2
  //width
  [self.view addConstraint:cvc2.widthConstraint];
  //height
  [self.view addConstraint:cvc2.heightConstraint];
  //position
  [self.view addConstraints:[NSLayoutConstraint 
                             constraintsWithVisualFormat:@"V:[svTwo]-0-[cvTwo]" 
                             options:0 metrics:nil views:views]];
  
  
  // update size for view and window
  [self setupSize];
    
  // show the window
  [self.view.window orderFront:self];
}

@end
