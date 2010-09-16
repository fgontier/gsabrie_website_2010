package classes.slides
{
	import classes.graphic.TextHandle;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	import flash.events.TextEvent;
	
	public class SlideInfo extends MovieClip
	{
		private var _slideData:XMLList;
		private var _sectionText1:TextHandle;
		private var _sectionText2:TextHandle;		
		private var _text:String;
		
		private var pcLB:RegExp = /\r\n/g;
		private var macLB:RegExp = /\r/g;
		private var linuxLB:RegExp = /\n/g;
		
		public function SlideInfo(slideData:XMLList):void 
		{
			_slideData = slideData;	
			
			_sectionText1 = new TextHandle(850, 100, 100, 100, 11, 0x333333, "justify", true, "left", false, false, true, "arial");
			_text = _slideData.sectionText[0] ;
			_text = _text.replace(pcLB, "\n");
			_text = _text.replace(macLB, "\n");	
			_sectionText1.text = _text ;
			addChild(_sectionText1)
				
			
			_sectionText2 = new TextHandle(250, 100, 100, 410, 11, 0x333333, "justify", true, "left", true, false, true, "arial");
			_sectionText2.y = _sectionText1.y + _sectionText1.height + 20;	
			addChild(_sectionText2);
			
			var style:StyleSheet = new StyleSheet();
			 
			var hover:Object = new Object();
			hover.fontWeight = "bold";
			hover.color = "#0000000";
			var link:Object = new Object();
			link.fontWeight = "bold";
			link.textDecoration= "underline";
			link.color = "#555555";
			var active:Object = new Object();
			active.fontWeight = "bold";
			active.color = "#FF0000";
			 
			var visited:Object = new Object();
			visited.fontWeight = "bold";
			visited.color = "#cc0099";
			visited.textDecoration= "underline";
			 
			style.setStyle("a:link", link);
			style.setStyle("a:hover", hover);
			style.setStyle("a:active", active);
			style.setStyle(".visited", visited);
			 
			_sectionText2.styleSheet = style;
			
			var htm:Array = new Array();
			
			// loop through the 3 links:
			for (var i:int = 1; i < _slideData.sectionText.length(); i++) 
			{
				htm.push(_slideData.sectionText[i]);
			}
			
			_sectionText2.htmlText= htm.join("");
			
		}	
	}
}