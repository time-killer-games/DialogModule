/*

 MIT License
 
 Copyright © 2020 Samuel Venable
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
*/

#import "subclass.h"
#import <Cocoa/Cocoa.h>
#import <sys/types.h>
#import <unistd.h>

CGWindowID quartz_wid = kCGNullWindowID;
CGWindowID quartz_pwid = kCGNullWindowID;

// pid of child wid
pid_t quartz_pid = 0;

// pid of parent wid
pid_t quartz_ppid = 0;

void subclass_helper(NSWindow *window) {
  if (quartz_ppid == getpid() && quartz_wid_exists(quartz_wid)) {
    [window setCanHide:NO];
    [window orderWindow:NSWindowBelow relativeTo:quartz_wid];
  } else if (quartz_pid == getpid() && quartz_wid_exists(quartz_pwid)) {
    [window setCanHide:NO];
    [window orderWindow:NSWindowAbove relativeTo:quartz_pwid];
    quartz_wid_to_top(quartz_wid);
  } else {
    [window setCanHide:YES];
    quartz_wid = kCGNullWindowID;
    quartz_pwid = kCGNullWindowID;
    quartz_pid = 0;
    quartz_ppid = 0;
  }
}

@implementation NSWindow(subclass)

- (void)setChildWindowWithNumber:(CGWindowID)wid {
  [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(windowDidBecomeKey:)
    name:NSWindowDidUpdateNotification object:self];
  [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(windowDidResignKey:)
    name:NSWindowDidUpdateNotification object:self];
  quartz_pwid = [self windowNumber]; quartz_wid = wid;
  quartz_ppid = quartz_pid_from_wid(quartz_pwid);
  quartz_pid = quartz_pid_from_wid(quartz_wid);
  [self orderWindow:NSWindowBelow relativeTo:wid];
}

- (void)setParentWindowWithNumber:(CGWindowID)pwid {
  [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(windowDidBecomeKey:)
    name:NSWindowDidUpdateNotification object:self];
  [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(windowDidResignKey:)
    name:NSWindowDidUpdateNotification object:self];
  quartz_wid = [self windowNumber]; quartz_pwid = pwid;
  quartz_ppid = quartz_pid_from_wid(quartz_pwid);
  quartz_pid = quartz_pid_from_wid(quartz_wid);
  [self orderWindow:NSWindowAbove relativeTo:pwid];
}

- (void)windowDidBecomeKey:(NSNotification *)notification {
  subclass_helper(self);
}

- (void)windowDidResignKey:(NSNotification *)notification {
  subclass_helper(self);
}

- (void)windowDidUpdate:(NSNotification *)notification {
  subclass_helper(self);
}

@end
