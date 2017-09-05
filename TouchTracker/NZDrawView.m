//
//  NZDrawView.m
//  TouchTracker
//
//  Created by Neil Zhang on 2017/8/11.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "NZDrawView.h"
#import "NZLine.h"

@interface NZDrawView ()<UIGestureRecognizerDelegate>

//@property (nonatomic,strong) NZLine *currentLine;

@property (nonatomic,strong) NSMutableDictionary *linesInProgress;

@property (nonatomic,strong) NSMutableArray *finishedLines;

@property (nonatomic,weak) NZLine *selectedLine;

@property (nonatomic,strong) UIPanGestureRecognizer *moveRecognizer;

@end

@implementation NZDrawView

#pragma mark - view life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.finishedLines = [[NSMutableArray alloc]init];
        self.linesInProgress = [[NSMutableDictionary alloc]init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
        UITapGestureRecognizer *doubleTap =
        [[UITapGestureRecognizer alloc]initWithTarget:self
                                               action:@selector(doubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        doubleTap.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTap];
        
        UITapGestureRecognizer *onceTap =
        [[UITapGestureRecognizer alloc]initWithTarget:self
                                            action:@selector(onceTap:)];
        onceTap.delaysTouchesBegan = YES;
        [onceTap requireGestureRecognizerToFail:doubleTap];
        [self addGestureRecognizer:onceTap];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
//        [self addGestureRecognizer:longPress];
        
        self.moveRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
//    [[UIColor redColor] set];
//    for (NZLine *line in self.finishedLines) {
//        [self strokeLine:line];
//    }
//    if (self.linesInProgress) {
//        
//    }
    
    [[UIColor redColor] set];
    for (NZLine *line in self.finishedLines) {
        [self strokeLine:line];
    }
    [[UIColor blueColor] set];
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }
    if (self.selectedLine) {
        [[UIColor greenColor] set];
        [self strokeLine:self.selectedLine];
    }
}

#pragma mark - delegate method

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    UITouch *touch = [touches anyObject];
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView:self];
        NZLine *line = [[NZLine alloc]init];
        line.begin = location;
        line.end = location;
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        self.linesInProgress[key] = line;
    }
//    CGPoint location = [touch locationInView:self];
//    self.currentLine = [[NZLine alloc]init];
//    self.currentLine.begin = location;
//    self.currentLine.end = location;
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    UITouch *touch = [touches anyObject];
//    CGPoint location = [touch locationInView:self];
//    self.currentLine.end = location;
//    [self setNeedsDisplay];
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        NZLine *line = self.linesInProgress[key];
        line.end = [touch locationInView:self];
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        NZLine *line = [self.linesInProgress objectForKey:key];
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
//    [self.finishedLines addObject:self.linesInProgress];
//    self.currentLine = nil;
    [self setNeedsDisplay];
}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == self.moveRecognizer) {
        return YES;
    }
    return NO;
}
#pragma mark - override super method

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - privete method
- (void)moveLine:(UIPanGestureRecognizer *)pan
{
    if (!self.selectedLine) {
        return;
    }
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [pan translationInView:self];
        NSLog(@"translation.x = %f\ntranslation.y = %f",translation.x,translation.y);
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
        begin.x += translation.x;
        end.x += translation.x;
        begin.y += translation.y;
        end.y += translation.y;
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;
        [self setNeedsDisplay];
        [pan setTranslation:CGPointZero inView:self];
    }
}

- (NZLine *)lineAtPoint:(CGPoint)point
{
    for (NZLine *line in self.finishedLines) {
        CGPoint begin =  line.begin;
        CGPoint end = line.end;
        for (float i = 0; i <= 1.0; i += 0.05) {
            float x = begin.x + i * (end.x - begin.x);
            float y = begin.y + i * (end.y - end.y);
            if (hypot(x - point.x, y - point.y) < 40) {
                return line;
            }
        }
    }
    return nil;
}

- (void)onceTap:(UIGestureRecognizer *)geus
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    CGPoint point = [geus locationInView:self];
    NZLine *theLine = [self lineAtPoint:point];
    self.selectedLine = theLine;
    if (self.selectedLine) {
        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *deleteItem = [[UIMenuItem alloc]initWithTitle:@"Delete"
                                                           action:@selector(deleteSelectedLine:)];
        menu.menuItems = @[deleteItem];
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2)
                     inView:self];
        [menu setMenuVisible:YES animated:YES];
    }else{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    [self setNeedsDisplay];
}

- (void)doubleTap:(UIGestureRecognizer *)sender
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [self.finishedLines removeAllObjects];
    [self.linesInProgress removeAllObjects];
    [self setNeedsDisplay];
}

- (void)strokeLine:(NZLine *)line
{
    UIBezierPath *path = [[UIBezierPath alloc]init];
    path.lineWidth = 10;
    path.lineCapStyle = kCGLineCapRound;
    [path moveToPoint:line.begin];
    [path addLineToPoint:line.end];
    [path stroke];
    
}

- (void)deleteSelectedLine:(id)sender
{
    [self.finishedLines removeObject:self.selectedLine];
    [self setNeedsDisplay];
}

- (void)longPress:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gesture locationInView:self];
        self.selectedLine = [self lineAtPoint:point];
        if (self.selectedLine) {
            [self.linesInProgress removeAllObjects];
        }
    }else if (gesture.state == UIGestureRecognizerStateEnded){
        self.selectedLine = nil;
    }
    [self setNeedsDisplay];
}

@end
