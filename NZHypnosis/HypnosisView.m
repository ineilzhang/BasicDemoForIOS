//
//  HypnosisView.m
//  NZHypnosis
//
//  Created by Neil Zhang on 2017/8/3.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "HypnosisView.h"

@interface HypnosisView()



@end

@implementation HypnosisView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.cycleColor = [UIColor redColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGFloat currentRadius = hypot(self.bounds.size.width, self.bounds.size.height) / 2;
    UIBezierPath *path = [[UIBezierPath alloc]init];
    CGPoint center;
    center.x = self.bounds.origin.x + self.bounds.size.width / 2.0;
    center.y = self.bounds.origin.y + self.bounds.size.height / 2.0;
    while (currentRadius > 0) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center 
                        radius:currentRadius
                    startAngle:0.0f
                      endAngle:2 * M_PI
                     clockwise:YES];
        currentRadius = currentRadius - 10;
    }
    path.lineWidth = 2.0f;
    [self.cycleColor setStroke];
    [path stroke];
//    UIImage *logo = [UIImage imageNamed:@"logo"];
//    [logo drawInRect:rect];
}

- (void)setCycleColor:(UIColor *)cycleColor{
    _cycleColor = cycleColor;
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.cycleColor = [UIColor colorWithRed:(arc4random() % 100) / 100.0f
                                      green:(arc4random() % 100) / 100.0f
                                       blue:(arc4random() % 100) / 100.0f
                                      alpha:1.0f];
}

@end
