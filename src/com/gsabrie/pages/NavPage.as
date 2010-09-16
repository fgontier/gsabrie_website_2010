package com.gsabrie.pages
{
	import classes.menu.Header;
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import com.soundstep.ui.BaseUI;
	import com.soundstep.ui.ElementUI;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	import gs.*;
	
	public class NavPage extends AbstractPage
	{	
		private var _header:Header;	
		private var baseUI:BaseUI;
		private var isFullScreen:Boolean = false;		
		public var btFullScreen:MovieClip;
		
		public function NavPage()
		{
			super();
			alpha = 0;
			//new Scaffold(this);
		}
		override public function transitionIn():void 
		{
			super.transitionIn();
			TweenMax.to(this, 0.3, { alpha:1, onComplete:transitionInComplete } );
			baseUI = new BaseUI(this);
			createNav();
		}
		
		private function createNav():void
		{
			_header = new Header();
			addChild(_header);	
			
			placeFullScreenButton();
			
			//baseUI = new BaseUI(this);
			var element_navContainer:ElementUI = baseUI.add(_header.navContainer);
			//element_navContainer.right = 20;
			element_navContainer.right = 41	;
			_header.navContainer.addEventListener(MouseEvent.CLICK, navContainer_clickHandler);
			
			Gaia.api.afterGoto(onAfterGoto);
			updateButtonStates(Gaia.api.getCurrentBranch());

		}

		private function placeFullScreenButton() 
		{
			//_header.navContainer.addChild(btFullScreen);
			var element_btFullScreen:ElementUI = baseUI.add(btFullScreen);
			addChild(btFullScreen);
			element_btFullScreen.top = 23;
			element_btFullScreen.right = 14;
			btFullScreen.buttonMode = true;
			btFullScreen.addEventListener (MouseEvent.MOUSE_OVER, btTimelineOver);
			btFullScreen.addEventListener (MouseEvent.MOUSE_OUT, btTimelineOut);
			btFullScreen.addEventListener (MouseEvent.CLICK, clickFullScreen);
		}
		//
		private function btTimelineOver (event:MouseEvent) {
			event.currentTarget.gotoAndPlay ("over");
		}
		//
		private function btTimelineOut (event:MouseEvent) {
			event.currentTarget.gotoAndPlay ("out");
		}
		//
		//
		private function clickFullScreen (event:MouseEvent) {
			if(isFullScreen == true){
				exitFullScreen();
				isFullScreen = false;
			}
			else{
				goFullScreen();
				isFullScreen = true;
			}
		}
		//
		private function goFullScreen():void {
			stage.displayState = StageDisplayState.FULL_SCREEN;
		}
		//
		private function exitFullScreen():void {
			stage.displayState = StageDisplayState.NORMAL;
		}
		//
		
		
		
		private function onAfterGoto(event:GaiaEvent):void
		{
			 updateButtonStates(event.validBranch);
		}	
		
		private function updateButtonStates(branch:String):void
		{
			
			//trace ("branch " + branch)
			//trace ("page: " + Gaia.api.getPage(branch).title);
			//trace("_header.navContainer " + _header.navContainer.getChildByName("menuStory"))
			
			var i:int = _header.buttonArray.length;
			while (i--)
			{
				var btn:MovieClip = _header.buttonArray[i];
				if (branch != btn.name)
				{
					btn.enabled = true;
					btn.buttonMode = true;
					trace("_header.buttonArray[i] " + _header.buttonArray[i].name)
					btn.addEventListener(MouseEvent.MOUSE_OVER, navContainer_mouseOverHandler);
					btn.addEventListener(MouseEvent.MOUSE_OUT, navContainer_mouseOutHandler);
				}
				else
				{
					btn.buttonMode = false;
					btn.enabled = false;
					btn.removeEventListener(MouseEvent.MOUSE_OVER, navContainer_mouseOverHandler);
					btn.removeEventListener(MouseEvent.MOUSE_OUT, navContainer_mouseOutHandler);
					TweenLite.to(btn, 1, { tint:0xcccccc } );
				}
			}
		}
		
		private function navContainer_mouseOutHandler(e:MouseEvent):void 
		{
			TweenLite.to(e.target, 1, { tint:0xcccccc } );	
		}
		
		private function navContainer_mouseOverHandler(e:MouseEvent):void 
		{
			TweenLite.to(e.target, 1, { tint:0x333333 } );
		}
		
		private function navContainer_clickHandler(e:MouseEvent):void 
		{
				Gaia.api.goto(e.target.name); //	
		}
		
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}
