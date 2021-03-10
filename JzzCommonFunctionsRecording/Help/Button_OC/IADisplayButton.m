//
//  IADisplayButton.m
//  IADisplayButton
//
//  Created by JinFeng on 2019/4/22.
//  Copyright © 2019 Netease. All rights reserved.
//

#import "IADisplayButton.h"

@interface IADisplayButton ()

@property (nonatomic) IBInspectable NSInteger display;
@property (nonatomic, strong) IBInspectable UIImage *image;
@property (nonatomic, copy) IBInspectable NSString *title;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSMutableDictionary *titleDic;
@property (nonatomic, strong) NSMutableDictionary *titleColorDic;
@property (nonatomic, strong) NSMutableDictionary *imageDic;
@property (nonatomic, strong) NSMutableDictionary *backgroundDic;

@property (nonatomic, strong) NSLayoutConstraint *spaceConstraint;
@property (nonatomic, strong) NSLayoutConstraint *contentTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *contentLeftConstraint;
@property (nonatomic, strong) NSLayoutConstraint *contentBottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *contentRightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *contentCenterX;
@property (nonatomic, strong) NSLayoutConstraint *contentCenterY;

@end

@implementation IADisplayButton

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.userInteractionEnabled = NO;
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imageView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _buttonDisplay = IAButtonDisplayTopImage;
        [self p_setupConfigs];
        [self p_addSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _buttonDisplay = IAButtonDisplayTopImage;
        [self p_setupConfigs];
        [self p_addSubviews];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _buttonDisplay = IAButtonDisplayTopImage;
        [self p_setupConfigs];
        [self p_addSubviews];
    }
    return self;
}

- (instancetype)initWithButtonDisplay:(IAButtonDisplay)display {
    self = [super init];
    if (self) {
        _buttonDisplay = display;
        [self p_setupConfigs];
        [self p_addSubviews];
    }
    return self;
}

+ (instancetype)button {
    return [self buttonWithDisplay:IAButtonDisplayTopImage];
}

+ (instancetype)buttonWithDisplay:(IAButtonDisplay)display {
    return [[self alloc] initWithButtonDisplay:display];
}

- (void)p_setupConfigs {
    self.titleColorDic = [NSMutableDictionary dictionary];
    self.titleDic      = [NSMutableDictionary dictionary];
    self.imageDic      = [NSMutableDictionary dictionary];
    self.backgroundDic = [NSMutableDictionary dictionary];
    self.space = 6;
}

- (void)p_addSubviews {
    [self.titleLabel removeFromSuperview];
    [self.imageView removeFromSuperview];
    [self.contentView removeFromSuperview];
    if (self.constraints) {
        [self removeConstraints:self.constraints];
    }
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.imageView];
    [self addSubview:self.contentView];
    
    if (self.buttonDisplay == IAButtonDisplayTopImage) {
        NSLayoutConstraint *imageTop = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *imageLeft = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *imageRight = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        NSLayoutConstraint *imageCenterX = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [self addConstraints:@[imageTop, imageLeft, imageRight, imageCenterX]];
        
        NSLayoutConstraint *labelTop = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:self.space];
        NSLayoutConstraint *labelLeft = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *labelRight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        NSLayoutConstraint *labelCenterX = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        NSLayoutConstraint *labelBottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [self addConstraints:@[labelTop, labelLeft, labelRight, labelCenterX, labelBottom]];
        
        self.spaceConstraint = labelTop;
    } else if (self.buttonDisplay == IAButtonDisplayBottomImage) {
        NSLayoutConstraint *labelTop = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *labelLeft = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *labelRight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        NSLayoutConstraint *labelCenterX = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [self addConstraints:@[labelTop, labelLeft, labelRight, labelCenterX]];
        
        NSLayoutConstraint *imageTop = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:self.space];
        NSLayoutConstraint *imageLeft = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *imageRight = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        NSLayoutConstraint *imageCenterX = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        NSLayoutConstraint *imageBottom = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [self addConstraints:@[imageTop, imageLeft, imageRight, imageCenterX, imageBottom]];
        
        self.spaceConstraint = imageTop;
    } else if (self.buttonDisplay == IAButtonDisplayLeftImage) {
        NSLayoutConstraint *imageTop = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *imageLeft = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *imageBottom = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        NSLayoutConstraint *imageCenterY = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [self addConstraints:@[imageTop, imageLeft, imageBottom, imageCenterY]];
        
        NSLayoutConstraint *labelTop = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *labelLeft = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.imageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:self.space];
        NSLayoutConstraint *labelRight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        NSLayoutConstraint *labelCenterY = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        NSLayoutConstraint *labelBottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [self addConstraints:@[labelTop, labelLeft, labelRight, labelCenterY, labelBottom]];
        
        self.spaceConstraint = labelLeft;
    } else if (self.buttonDisplay == IAButtonDisplayRightImage) {
        NSLayoutConstraint *labelTop = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *labelLeft = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *labelBottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        NSLayoutConstraint *labelCenterY = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [self addConstraints:@[labelTop, labelLeft, labelBottom, labelCenterY]];
        
        NSLayoutConstraint *imageTop = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *imageLeft = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.titleLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:self.space];
        NSLayoutConstraint *imageRight = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        NSLayoutConstraint *imageCenterY = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        NSLayoutConstraint *imageBottom = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [self addConstraints:@[imageTop, imageLeft, imageRight, imageCenterY, imageBottom]];
        
        self.spaceConstraint = imageLeft;
    }
    
    NSLayoutConstraint *contentTop = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.contentEdgeInsets.top];
    NSLayoutConstraint *contentLeft = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.contentEdgeInsets.left];
    NSLayoutConstraint *contentRight = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:self.contentEdgeInsets.right];
    NSLayoutConstraint *contentBottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:self.contentEdgeInsets.bottom];
    
    self.contentTopConstraint = contentTop;
    self.contentLeftConstraint = contentLeft;
    self.contentBottomConstraint = contentBottom;
    self.contentRightConstraint = contentRight;
    
    [self addConstraints:@[contentTop, contentLeft, contentRight, contentBottom]];
    
    // 设置下默认的内边距
    self.contentEdgeInsets = UIEdgeInsetsZero;
}

#pragma mark - set

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [self.titleDic setObject:title forKey:@(state)];
    if (state == UIControlStateNormal) {
        self.titleLabel.text = title;
    }
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [self.imageDic setObject:image forKey:@(state)];
    if (state == UIControlStateNormal) {
        self.imageView.image = image;
    }
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    [self.titleColorDic setObject:color forKey:@(state)];
    if (state == UIControlStateNormal) {
        self.titleLabel.textColor = color;
    }
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    [self.backgroundDic setObject:color forKey:@(state)];
    if (state == UIControlStateNormal) {
        self.backgroundColor = color;
    }
}

- (void)setSpace:(CGFloat)space {
    _space = space;
    self.spaceConstraint.constant = space;
    [self setNeedsLayout];
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
    _contentEdgeInsets = contentEdgeInsets;
    self.contentTopConstraint.constant = contentEdgeInsets.top;
    self.contentBottomConstraint.constant = contentEdgeInsets.bottom;
    self.contentLeftConstraint.constant = contentEdgeInsets.left;
    self.contentRightConstraint.constant = contentEdgeInsets.right;
    NSLayoutRelation relationY = NSLayoutRelationEqual, relationX = NSLayoutRelationEqual;
    if (contentEdgeInsets.top > contentEdgeInsets.bottom) {
        relationY = NSLayoutRelationGreaterThanOrEqual;
    } else if (contentEdgeInsets.top < contentEdgeInsets.bottom) {
        relationY = NSLayoutRelationLessThanOrEqual;
    } else {
        relationY = NSLayoutRelationEqual;
    }
    NSLayoutConstraint *contentCenterY = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeCenterY relatedBy:relationY toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    contentCenterY.priority = UILayoutPriorityRequired;
    if (self.contentCenterY) {
        [self removeConstraint:self.contentCenterY];
        [self addConstraint:contentCenterY];
    } else {
        [self addConstraint:contentCenterY];
    }
    self.contentCenterY = contentCenterY;
    
    if (contentEdgeInsets.left > contentEdgeInsets.right) {
        relationX = NSLayoutRelationGreaterThanOrEqual;
    } else if (contentEdgeInsets.left < contentEdgeInsets.right) {
        relationX = NSLayoutRelationLessThanOrEqual;
    } else {
        relationX = NSLayoutRelationEqual;
    }
    NSLayoutConstraint *contentCenterX = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeCenterX relatedBy:relationX toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    contentCenterX.priority = UILayoutPriorityRequired;
    if (self.contentCenterX) {
        [self removeConstraint:self.contentCenterX];
        [self addConstraint:contentCenterX];
    } else {
        [self addConstraint:contentCenterX];
    }
    self.contentCenterX = contentCenterX;
    [self setNeedsLayout];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
    [self.imageDic setObject:image forKey:@(UIControlStateNormal)];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self.titleDic setObject:title forKey:@(UIControlStateNormal)];
}

- (void)setDisplay:(NSInteger)display {
    _display = display;
    if (display > IAButtonDisplayRightImage) {
        display = IAButtonDisplayRightImage;
    }
    if (display < IAButtonDisplayTopImage) {
        display = IAButtonDisplayTopImage;
    }
    self->_buttonDisplay = (IAButtonDisplay)display;
    [self p_addSubviews];
}

#pragma mark - change state

- (void)setNormalState {
    self.backgroundColor = self.backgroundDic[@(UIControlStateNormal)];
    self.titleLabel.text = self.titleDic[@(UIControlStateNormal)];
    self.titleLabel.textColor = self.titleColorDic[@(UIControlStateNormal)];
    self.imageView.image = self.imageDic[@(UIControlStateNormal)];
}

- (void)setSelectedState {
    self.backgroundColor = self.backgroundDic[@(UIControlStateSelected)] ? self.backgroundDic[@(UIControlStateSelected)] : self.backgroundDic[@(UIControlStateNormal)];
    self.titleLabel.text = self.titleDic[@(UIControlStateSelected)] ? self.titleDic[@(UIControlStateSelected)] : self.titleDic[@(UIControlStateNormal)];
    self.titleLabel.textColor = self.titleColorDic[@(UIControlStateSelected)] ? self.titleColorDic[@(UIControlStateSelected)] : self.titleColorDic[@(UIControlStateNormal)];
    self.imageView.image = self.imageDic[@(UIControlStateSelected)] ? self.imageDic[@(UIControlStateSelected)] : self.imageDic[@(UIControlStateNormal)];
}

- (void)setHighlightState {
    self.backgroundColor = self.backgroundDic[@(UIControlStateHighlighted)] ? self.backgroundDic[@(UIControlStateHighlighted)] : self.backgroundDic[@(UIControlStateNormal)];
    self.titleLabel.text = self.titleDic[@(UIControlStateHighlighted)] ? self.titleDic[@(UIControlStateHighlighted)] : self.titleDic[@(UIControlStateNormal)];
    self.titleLabel.textColor = self.titleColorDic[@(UIControlStateHighlighted)] ? self.titleColorDic[@(UIControlStateHighlighted)] : self.titleColorDic[@(UIControlStateNormal)];
    self.imageView.image = self.imageDic[@(UIControlStateHighlighted)] ? self.imageDic[@(UIControlStateHighlighted)] : self.imageDic[@(UIControlStateNormal)];
}

- (void)saveNormalState {
    if (!self.backgroundDic[@(UIControlStateNormal)]) {
        [self.backgroundDic setObject:self.backgroundColor ? self.backgroundColor : [UIColor whiteColor] forKey:@(UIControlStateNormal)];
    }
    if (!self.titleColorDic[@(UIControlStateNormal)]) {
        [self.titleColorDic setObject:self.titleLabel.textColor ? self.titleLabel.textColor : [UIColor blackColor] forKey:@(UIControlStateNormal)];
    }
}

#pragma mark - touch

// tracking 按压
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    [self saveNormalState];
    [self setHighlightState];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    return YES;
}

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    if (self.isSelected) {
        [self setSelectedState];
    } else {
        [self setNormalState];
    }
}

- (void)cancelTrackingWithEvent:(nullable UIEvent *)event {
    [self setNormalState];
}

#pragma mark - layout

- (void)p_layout {
    
}

- (void)layoutSubviews {
    [self p_layout];
}

@end
