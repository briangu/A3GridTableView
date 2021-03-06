//
//  A3GridTableViewCell.m
//  A3GridTableViewSample
//
//  A3GridView for iOS
//  Created by Botond Kis on 28.09.12.
//  Copyright (c) 2012 aaa - All About Apps
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//
//      - Redistributions of source code must retain the above copyright notice, this list
//      of conditions and the following disclaimer.
//
//      - Redistributions in binary form must reproduce the above copyright notice, this list
//      of conditions and the following disclaimer in the documentation and/or other materials
//      provided with the distribution.
//
//      - Neither the name of the "aaa - All About Apps" nor the names of its contributors may be used
//      to endorse or promote products derived from this software without specific prior written
//      permission.
//
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
//  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
//  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//  NO DOUGHNUTS WHERE HARMED DURING THE CODING OF THIS CLASS. BUT CHEESECAKES
//  WHERE. IF YOU READ THIS YOU ARE EITHER BORED OR A LAWYER.


#import "A3GridTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CGColor.h>
#import "FXLabel.h"

@implementation A3GridTableViewCell

//===========================================================================================
#pragma mark - Memory

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super init];
    if (self) {
        // Set the reuseIdentifier
        _reuseIdentifier = SAFE_ARC_RETAIN(reuseIdentifier);
        
        // set up contentView
        self.contentView = SAFE_ARC_AUTORELEASE([[UIView alloc] initWithFrame:self.bounds]);
        self.contentView.backgroundColor = [UIColor clearColor];
        
        // set up Background
        self.backgroundView = SAFE_ARC_AUTORELEASE([[UIView alloc] initWithFrame:self.bounds]);
        self.backgroundView.backgroundColor = [UIColor clearColor];
        
        // set up selected BG
        self.selectedBackgroundView = SAFE_ARC_AUTORELEASE([[UIView alloc] initWithFrame:self.bounds]);
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        // set up highlighted BG
        self.highlightedBackgroundView  = SAFE_ARC_AUTORELEASE([[UIView alloc] initWithFrame:self.bounds]);
        self.highlightedBackgroundView.backgroundColor = [UIColor clearColor];
        
        // set up titleLabel
        self.titleLabel = SAFE_ARC_AUTORELEASE([[UILabel alloc] init]);
        //self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        //self.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        //self.titleLabel.textAlignment = UITextAlignmentLeft;
        
        [self.contentView addSubview: self.titleLabel];
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)transitionImage:(UIImage *)newImage {
    [UIView transitionWithView:self.backgroundView
                      duration:1.0f
                       options:UIViewAnimationOptionTransitionCurlDown //UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        ((UIImageView*)self.backgroundView).image = newImage;
                    } completion:NULL];
}

- (void)dealloc{
    SAFE_ARC_RELEASE(_titleLabel);
    SAFE_ARC_RELEASE(_reuseIdentifier);
/*
    [_backgroundView release];
    [_contentView release];
    [_selectedBackgroundView release];
    [_highlightedBackgroundView release];
    [_reuseIdentifier release];
    [_indexPath release];
 [super dealloc];
 */
}


//===========================================================================================
#pragma mark - Reuse
- (void)prepareForReuse{}

//===========================================================================================
#pragma mark - Properties
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    int xMargin = 3;
    int yMargin = 3;

//    UIImageView *img = ((UIImageView*)_backgroundView);
    //xMargin = (self.bounds.size.width - img.image.size.width) / 2 + 3;
    //yMargin = (self.bounds.size.height - img.image.size.height) / 2 + 3;

    _backgroundView.frame = CGRectMake(xMargin, yMargin, self.bounds.size.width - 2*xMargin, self.bounds.size.height - 2*yMargin);
    
    // update title label
    int textXMargin = 14;
    int textYMargin = 8;
    _titleLabel.frame = CGRectMake(textXMargin, textYMargin, _contentView.bounds.size.width - 2*textXMargin, _contentView.bounds.size.height - 2*textYMargin);
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = UITextAlignmentLeft;
    _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0];
    
    _titleLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
    _titleLabel.shadowOffset = CGSizeMake(1.0f, 2.0f);
    
    [_titleLabel setNumberOfLines:0];
    [_titleLabel sizeToFit];
    _titleLabel.center = CGPointMake(floor(_titleLabel.center.x), floor(_titleLabel.center.y));
    _titleLabel.frame = CGRectIntegral(_titleLabel.frame);
}

- (void)setSelected:(BOOL)selected{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    _selected = selected;
    
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.selectedBackgroundView.alpha = selected?1.0f:0.0f;
        }];
    }
    else{
        self.selectedBackgroundView.alpha = selected?1.0f:0.0f;
    }
}

- (void)setHighlighted:(BOOL)highlighted{
    [self setHighlighted:highlighted animated:NO];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    _highlighted = highlighted;
    
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.highlightedBackgroundView.alpha = highlighted?1.0f:0.0f;
        }];
    }
    else{
        self.highlightedBackgroundView.alpha = highlighted?1.0f:0.0f;
    }
}

- (void)setBackgroundView:(UIView *)backgroundView{
    [_backgroundView removeFromSuperview];
    
    _backgroundView = backgroundView;
//    _backgroundView.frame = self.bounds;
//    _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight;// | UIViewAutoresizingFlexibleWidth;
    _backgroundView.backgroundColor = [UIColor clearColor];
    
    [self addSubview: _backgroundView];
    [self sendSubviewToBack:_backgroundView];
}

- (void)setContentView:(UIView *)contentView{
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    _contentView.frame = self.bounds;
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview: _contentView];
    [self bringSubviewToFront:_contentView];
    [self bringSubviewToFront:_titleLabel];
}

- (void)setSelectedBackgroundView:(UIView *)selectedBackgroundView{
    [_selectedBackgroundView removeFromSuperview];
    
    _selectedBackgroundView = selectedBackgroundView;
    _selectedBackgroundView.frame = self.bounds;
    _selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _selectedBackgroundView.alpha = 0.0f;
    
    [self insertSubview:_selectedBackgroundView aboveSubview:_backgroundView];
}

- (void)setHighlightedBackgroundView:(UIView *)highlightedBackgroundView{
    [_highlightedBackgroundView removeFromSuperview];
    
    _highlightedBackgroundView = highlightedBackgroundView;
    _highlightedBackgroundView.frame = self.bounds;
    _highlightedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _highlightedBackgroundView.alpha = 0.0f;
    
    [self insertSubview:_highlightedBackgroundView aboveSubview:_selectedBackgroundView];
}

@end
