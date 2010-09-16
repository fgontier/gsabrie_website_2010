﻿package classes.graphic
{
    import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gs.TweenLite;
    
    public class Arrow extends Sprite 
	{
		private var _startX:Number;
		private var _thickness:Number;
		private var _width:Number;
		private var _height:Number;
		
        public function Arrow(startX:Number, thickness:Number, width:Number, height:Number):void 
		{
			_startX = startX;
			_thickness = thickness;
			_width = width;
			_height = height;
			
			graphics.lineStyle(_thickness, 0xcccccc , 1, false, "normal", "square" )
            graphics.moveTo(_startX, 0);
            graphics.lineTo(_width, _height/2);
            graphics.lineTo(_startX, _height);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, arrow_mouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT, arrow_mouseOutHandler);
			
			this.buttonMode = true
			this.mouseChildren = false;			
			this.useHandCursor = true;
        }
		
		private function arrow_mouseOverHandler(e:Event):void 
		{
			TweenLite.to(e.target, 0.5, { tint:0x333333 })
		}
		
		private function arrow_mouseOutHandler(e:Event):void 
		{
			TweenLite.to(e.target, 0.5, { tint:0xcccccc })
		}
    }
}