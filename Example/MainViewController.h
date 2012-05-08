//
//  MainViewController.h
//  PLXCollapsibleView
//
//  Created by pjv on 5/7/12.
//  Copyright (c) 2012 Plexus Publishing, LLC. All rights reserved.
//

#import "PLXHuggingSuperviewController.h"
#import "CollapsibleView1Controller.h"
#import "CollapsibleView2Controller.h"
#import "StaticView1Controller.h"
#import "StaticView2Controller.h"

@interface MainViewController : PLXHuggingSuperviewController

@property (strong) CollapsibleView1Controller *cvc1;
@property (strong) CollapsibleView2Controller *cvc2;
@property (strong) StaticView1Controller *svc1;
@property (strong) StaticView2Controller *svc2;

@property (weak) NSView *cvOne;
@property (weak) NSView *cvTwo;
@property (weak) NSView *svOne;
@property (weak) NSView *svTwo;

@end
