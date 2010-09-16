package classes.graphic 
{
	import classes.graphic.DrawRectangle;
	import classes.graphic.TextHandle;
	//import com.easingTrans.EasingTransition;
	import com.soundstep.ui.events.BaseEventUI;
	import flash.display.Sprite;
	import flash.events.Event;

	public class CreateCaption extends Sprite
	{
		public var myCaption:TextHandle;			// public because resized by CreateImage.
		public var captionBgd:DrawRectangle;		// public because resized by CreateImage.
		public var captionText:String = "test";		// public because resized by CreateImage.
		
		//private var pcLB:RegExp = /\r\n/g;
		//private var macLB:RegExp = /\r/g;
		//private var linuxLB:RegExp = /\n/g;
           
		public function CreateCaption() 
		{
			//captionText = captionText.replace(pcLB, "\n");
			//captionText = captionText.replace(macLB, "\n");
			
			// creates white background:
			captionBgd = new DrawRectangle(0, 0, 200, 100);
			captionBgd.alpha = 1;
			addChild(captionBgd);
			
			/*public function TextHandle(
			 * w:Number = 20, 
			 * h:Number = 10, 
			 * xt:Number = 0, 
			 * yt:Number = 0, 
			 * size:int = 11, 
			 * colour:uint = 0x222222, 
			 * align:String = "left", 
			 * mult:Boolean = false,
			 * auto:String = "left", 
			 * sel:Boolean = true, 
			 * bord:Boolean = false, 
			 * wWrap:Boolean = true, 
			 * textFont:String = "arial")
			 * */
			
			// create the caption:
			myCaption = new TextHandle(100, 100, 0, 0, 11, 0x333333, "justify", true, "left", false, false, true, "arial");
		
			//myCaption.text = captionText;
			
			addChild(myCaption);
		}
	}
}


	