package classes.graphic{

	import com.gaiaframework.api.Gaia;
	import flash.text.*

	//[Embed(source = '../../arial.ttf', fontFamily = "arial")]
	//[Embed(source = '../../arialbd.ttf', fontFamily = "arial2")]
	

	public class TextHandle extends TextField {
		
		private var _format:TextFormat;
		private var _myFont:Class;
		
		public function TextHandle(w:Number = 20, h:Number = 10, xt:Number = 0, yt:Number = 0, size:int = 11, colour:uint = 0x222222, align:String = "left", mult:Boolean = false, auto:String = "left", sel:Boolean = true, bord:Boolean = false, wWrap:Boolean = true, textFont:String = "arial"){
			
			x					= xt;
			y					= yt;
			width 				= w;
			height				= h;

			_format				= new TextFormat();
			_format.font		= Gaia.api.getFontName("regularFont");
			_format.color		= colour;
			_format.size		= size;
			_format.align		= align;
			//_format.leading		= 5;		
			_format.leading		= 2;		

			defaultTextFormat	= _format;
			embedFonts			= true;
			autoSize			= auto;
			multiline			= mult;
			selectable			= sel;
			antiAliasType		= AntiAliasType.ADVANCED;
			condenseWhite 		= true;	
			mouseEnabled		= true;	
			border 				= bord;
			wordWrap			= wWrap;
			//background			= true;
			//backgroundColor		= 0xffff11
		}
		
		public function get format():TextFormat { return _format; }
		  
	}
}