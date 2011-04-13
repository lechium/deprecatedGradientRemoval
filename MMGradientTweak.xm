%hook BRScrollControl


- (CGRect)_visibleRectOfControl:(id)control
{
	// we resize this because the _topFade gradient being removed exposes the text above the menu dividing line, we need to shift the rect down about 20 to crop it out
	
	//%log;
	CGRect theRect = (CGRect)%orig;
	int originY = %orig.origin.y;
	int heights = %orig.size.height;
//	NSLog(@"rect: %@", NSStringFromCGRect(%orig));
	if (originY == 0)
	{
		if (heights == 292)
		{
			theRect.size.height = 272;
			NSLog(@"new rect: %@", NSStringFromCGRect(theRect));
			return theRect;
		}
	}
	
	return %orig;
}


- (void)_updateVerticalEdgeFading
{
	//%log;
	Class BASM = NSClassFromString(@"BRApplicationStackManager");
	Class BMMC = NSClassFromString(@"BRMainMenuController");
	if ([[[[BASM singleton] stack] peekController] isKindOfClass: [BMMC class]] == TRUE)
	{
		id bottomFade(MSHookIvar<id >(self, "_bottomFade"));
		//NSLog(@"bottomFade: %@", bottomFade);

		if (bottomFade != nil)
		{
			[bottomFade removeFromParent];

		}
		id topFade(MSHookIvar<id >(self, "_topFade"));

		//NSLog(@"topFade: %@", bottomFade);

		if (topFade != nil)
		{
			[topFade removeFromParent];
		}
		
	return;

	}
	
	%orig;
}



%end