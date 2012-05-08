//
//  PLXHuggingSuperviewController.m
//
//  Created by pjv on 5/4/12.
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

#import "PLXHuggingSuperviewController.h"

@interface PLXHuggingSuperviewController ()

@end

@implementation PLXHuggingSuperviewController
@synthesize heightConstraint, widthConstraint, animationDuration, animated;

- (void) awakeFromNib {
  
  // delete all constraints for a blank slate
  [self.view removeConstraints:self.view.constraints];
  
  // create default height and width constraints
  self.heightConstraint = [NSLayoutConstraint
                           constraintWithItem:self.view 
                           attribute:NSLayoutAttributeHeight 
                           relatedBy:NSLayoutRelationEqual 
                           toItem:nil 
                           attribute:NSLayoutAttributeNotAnAttribute 
                           multiplier:1.0 
                           constant:[self.view intrinsicContentSize].height];
  
  self.widthConstraint  = [NSLayoutConstraint
                           constraintWithItem:self.view 
                           attribute:NSLayoutAttributeWidth 
                           relatedBy:NSLayoutRelationEqual 
                           toItem:nil 
                           attribute:NSLayoutAttributeNotAnAttribute 
                           multiplier:1.0 
                           constant:[self.view intrinsicContentSize].width];
  
  // set defaults
  self.animated = NO;
  self.animationDuration = 0.01;
  
}

- (void) setupSize {
  // set new height and width constraints for my view
  self.heightConstraint.constant = [self.view intrinsicContentSize].height;
  self.widthConstraint.constant = [self.view intrinsicContentSize].width;
  
  // set new window size based on my view
  [self.view.window setContentSize:[self.view intrinsicContentSize]];
  [self.view.window flushWindow];
}

- (void) updateViewSizeWithDeltaH:(float)deltaH deltaW:(float)deltaW animate:(BOOL)animate {
  
  // this routine is called in response to one of the subviews being resized
  // animation is generally controlled by the collapsible subview
  // if animation is on, an NSAnimation group is begun and ended there
  
  // window frame calculations
  NSRect oldWFrame = [self.view.window frame];
  NSSize oldSize = [self.view.window contentRectForFrameRect:oldWFrame].size;
  NSSize newSize;
  newSize.height = oldSize.height + deltaH;
  newSize.width = oldSize.width + deltaW;

  NSRect newWFrame = [self.view.window frameRectForContentRect:NSMakeRect(0, 0, newSize.width, newSize.height)];
  newWFrame.origin.x = oldWFrame.origin.x;
  newWFrame.origin.y = oldWFrame.origin.y + (oldWFrame.size.height - newWFrame.size.height);
  
  
  if (animate) {
    
    // superview animation
    [self.heightConstraint.animator setConstant:newSize.height];
    [self.widthConstraint.animator setConstant:newSize.width];
    
    // window animation
    [self.view.window.animator setFrame: newWFrame display:YES animate:YES];

  } else { // not animating resize
    [self.view.window disableScreenUpdatesUntilFlush];
    
    // superview size
    self.heightConstraint.constant = [self.view intrinsicContentSize].height;
    self.widthConstraint.constant = [self.view intrinsicContentSize].width;
    
    // window size
    [self.view.window setFrame:newWFrame display:YES];
    [self.view.window flushWindow];
  }
}

@end
