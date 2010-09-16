package classes.menu 
{
	import classes.graphic.TextHandle;
	import classes.menu.CreateButton;
	import com.soundstep.ui.BaseUI;
	import com.soundstep.ui.ElementUI;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gs.*;
	
	public class Header extends Sprite
	{
		public var navContainer: Sprite;
		public var buttonArray:Array;
		
		public function Header() 
		{
			
			// GILLES SABRIE PHOTOGRAPHY ////////////////////
			var gillesText:TextHandle = new TextHandle(0, 0, 18, 17, 15, 0xcccccc, "left", false, "left", false, false, false,"arial");
			gillesText.text = "GILLES SABRIE PHOTOGRAPHY";
			addChild(gillesText);
			
			// top right navigation ////////////////////
			navContainer = new Sprite();
			navContainer.y = 19;
			addChild(navContainer);
			
			var _buttonStories:CreateButton = new CreateButton("STORIES   |");
			_buttonStories.buttonMode = true
			_buttonStories.useHandCursor = true;
			_buttonStories.mouseChildren = false;
			_buttonStories.name = "index/nav/menuStory";
			navContainer.addChild (_buttonStories);			
			
			var _buttonTearsheets:CreateButton = new CreateButton("TEARSHEETS   |");
			_buttonTearsheets.buttonMode = true
			_buttonTearsheets.useHandCursor = true;
			_buttonTearsheets.mouseChildren = false;
			_buttonTearsheets.name = "index/nav/tearsheets";
			_buttonTearsheets.x = 71;
			navContainer.addChild (_buttonTearsheets);			

			var _buttonInfo:CreateButton = new CreateButton("INFO   |");
			_buttonInfo.buttonMode = true
			_buttonInfo.useHandCursor = true;
			_buttonInfo.mouseChildren = false;
			_buttonInfo.name = "index/nav/info";
			_buttonInfo.x = 172;
			navContainer.addChild(_buttonInfo);
			
			buttonArray = [_buttonStories, _buttonTearsheets, _buttonInfo];
			
/*			var _fullScreen:CreateButton = new CreateButton ("full screen");
			_fullScreen.buttonMode = true
			_fullScreen.useHandCursor = true;
			_fullScreen.mouseChildren = false;
			_fullScreen.name = "fullScreen";
			_fullScreen.x = 232;
			navContainer.addChild(_fullScreen);
*/
			
		}
		
	}
	
}



