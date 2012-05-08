//
//  PLXCollapsibleViewController.m
//
//  Created by pjv on 5/2/12.
//  Copyright (c) 2012 Plexus Publishing, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//  * Neither the name of Plexus Publishing, LLC nor the
//    names of its contributors may be used to endorse or promote products
//    derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL PLEXUS PUBLISHING, LLC BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//   LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "PLXCollapsibleViewController.h"

@interface PLXCollapsibleViewController ()
- (void) changeViewToSize:(NSSize)size animated:(BOOL)animate;
@end

@implementation PLXCollapsibleViewController
@synthesize parentController, disclosureButton, collapsedSize, 
expandedSize, isExpanded, heightConstraint, widthConstraint, animated, animationDuration;

- (void) awakeFromNib {
  [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
  
  // create height and width constraints
  self.heightConstraint = [NSLayoutConstraint
                           constraintWithItem:self.view 
                           attribute:NSLayoutAttributeHeight 
                           relatedBy:NSLayoutRelationEqual 
                           toItem:nil 
                           attribute:NSLayoutAttributeNotAnAttribute 
                           multiplier:1.0 
                           constant:10];
  
  self.widthConstraint  = [NSLayoutConstraint
                           constraintWithItem:self.view 
                           attribute:NSLayoutAttributeWidth 
                           relatedBy:NSLayoutRelationEqual 
                           toItem:nil 
                           attribute:NSLayoutAttributeNotAnAttribute 
                           multiplier:1.0 
                           constant:10];  
  // set defaults
  self.animated = YES;
  self.animationDuration = 0.2;
  self.collapsedSize = NSMakeSize(100, 20);
  self.expandedSize = NSMakeSize(100, 120);
}

- (void) setupSize {
  // set height and width
  float height, width;
  if (self.isExpanded) {
    height = self.expandedSize.height;
    width = self.expandedSize.width;
  } else {
    height = self.collapsedSize.height;
    width = self.collapsedSize.width;
  }
  
  self.heightConstraint.constant = height;
  self.widthConstraint.constant = width;
  
  if (self.isExpanded) {
    [self changeViewToSize:self.expandedSize animated:NO];
  } else {
    [self changeViewToSize:self.collapsedSize animated:NO];
  }
}

- (IBAction)toggleDisclosure:(id)sender {
  if ([self.disclosureButton state] == NSOffState) {
    [self collapseView];
  } else {
    [self expandView];
  }
}

- (void) collapseView {
  [self changeViewToSize:self.collapsedSize animated:self.animated];
}
- (void) expandView {
  [self changeViewToSize:self.expandedSize animated:self.animated];
}

- (void) changeViewToSize:(NSSize)size animated:(BOOL)animate {
  
  float deltaH = self.expandedSize.height - self.collapsedSize.height;
  float deltaW = self.expandedSize.width - self.collapsedSize.width;
  
  if (NSEqualSizes(size, self.collapsedSize)) {
    self.isExpanded = NO;
    deltaH = -1*deltaH;
    deltaW = -1*deltaW;
  } else {
    self.isExpanded = YES;
  }
  
  [self.view.window disableScreenUpdatesUntilFlush];
  if (animate) {
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:self.animationDuration];
    [self.view.animator setFrameSize:size];
    [self.heightConstraint.animator setConstant:size.height];
    [self.widthConstraint.animator setConstant:size.width];
    // tell parent controller to update
    [self.parentController updateViewSizeWithDeltaH:deltaH deltaW:deltaW animate:animate];
    [NSAnimationContext endGrouping];
  } else { // not animated
    [self.view setFrameSize:size];
    [self.heightConstraint setConstant:size.height];
    [self.widthConstraint setConstant:size.width];
    // tell parent controller to update
    [self.parentController updateViewSizeWithDeltaH:deltaH deltaW:deltaW animate:animate];
  }
}

@end
