package classes.graphic 
{
    import flash.display.DisplayObject;
    import flash.display.Graphics;
    import flash.display.JointStyle;
    import flash.display.LineScaleMode;
    import flash.display.Shape;
    import flash.display.Sprite;

    public class DrawRectangle extends Sprite 
	{
		private var bgColor:uint = 0xFFFFFF;
        //private var bgColor:uint = 0xcccccc;

        public function DrawRectangle(xPos:int, yPos:int, sizeWidth:int, sizeHeight:int) 
		{
            var child:Shape = new Shape();
            child.graphics.beginFill(bgColor);
            child.graphics.drawRect(xPos, yPos, sizeWidth, sizeHeight);
            child.graphics.endFill();
            addChild(child);
        }
    }
}

