//
//  WBTextView.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/2.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBTextView.h"

@interface WBTextView ()

@property (nonatomic, weak) UILabel *placeHolderLabel;
@end
@implementation WBTextView

-(UILabel *)placeHolderLabel
{
    if (!_placeHolderLabel) {
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        [self addSubview:placeHolderLabel];
        _placeHolderLabel = placeHolderLabel;
    }
    return _placeHolderLabel;
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeHolderLabel.font = font;
    // label的尺寸和文字一样
    [self.placeHolderLabel sizeToFit];
}


-(void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    self.placeHolderLabel.text = placeHolder;
    self.placeHolderLabel.textColor = [UIColor lightGrayColor];
    
    
}
-(void)setHideplaceHolder:(BOOL)hideplaceHolder
{
    _hideplaceHolder = hideplaceHolder;
    
    self.placeHolderLabel.hidden = hideplaceHolder;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
}



@end
