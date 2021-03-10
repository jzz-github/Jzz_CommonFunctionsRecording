//
//  IADisplayButton.h
//  IADisplayButton
//
//  Created by JinFeng on 2019/4/22.
//  Copyright © 2019 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IAButtonDisplay) {
    /// 上图，下文字，默认
    IAButtonDisplayTopImage,
    /// 左图，右文字
    IAButtonDisplayLeftImage,
    /// 下图，上文字
    IAButtonDisplayBottomImage,
    /// 右图，左文字
    IAButtonDisplayRightImage
};

IB_DESIGNABLE
@interface IADisplayButton : UIControl

+ (instancetype)button;
+ (instancetype)buttonWithDisplay:(IAButtonDisplay)display;

@property (nonatomic, readonly) IBInspectable IAButtonDisplay buttonDisplay;

/// {0,0,0,0}
@property (nonatomic) UIEdgeInsets contentEdgeInsets;
/// font-12,textColor-0x303030
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UIImageView *imageView;
/// 图片和文字之间的距离,默认为6
@property (nonatomic) IBInspectable CGFloat space;

- (void)setImage:(UIImage *)image
        forState:(UIControlState)state;

- (void)setTitle:(NSString *)title
        forState:(UIControlState)state;

- (void)setTitleColor:(UIColor *)color
             forState:(UIControlState)state;

- (void)setBackgroundColor:(UIColor *)color
                  forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
