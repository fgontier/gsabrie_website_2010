package classes.menu 
{
	import classes.graphic.TextHandle;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class CreateButton extends MovieClip
	{
		
		public function CreateButton(buttonLabel:String) 
		{
			var _buttonText:TextHandle = new TextHandle(0, 0, 0, 0, 12, 0xcccccc, "left", false, "left", false, false, false, "arial");
			_buttonText.text = buttonLabel;
			addChild(_buttonText);
		}
		
	}
}