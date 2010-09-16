package com.gsabrie.pages
{
	import classes.graphic.TextHandle;
	import classes.slides.SlideInfo;
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	
	public class InfoPage extends AbstractPage
	{	
		private var _slideTitle:TextHandle;		
		
		public function InfoPage()
		{
			super();
			alpha = 0;
			//new Scaffold(this);
		}
		override public function transitionIn():void 
		{
			super.transitionIn();
			createInfo();
			TweenMax.to(this, 0.3, {alpha:1, onComplete:transitionInComplete});
		}
		
		private function createInfo():void
		{
			var pageInfo:SlideInfo = new SlideInfo( IXml(assets.info).xml.sectionTexts);
			addChild(pageInfo)
			// create title:
			_slideTitle = new TextHandle(0, 0, 260, 17, 15, 0x333333, "left", false, "left", false, false, false, "arial");
			_slideTitle.text = " |   INFO" 
			addChild(_slideTitle);			

		}
		
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}
