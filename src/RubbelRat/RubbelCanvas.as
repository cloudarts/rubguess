package RubbelRat 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author W. Jurczyk
	 */
	public class RubbelCanvas extends Sprite 
	{
		[Embed(source = "../../gfx/pen1.png")] private static var PEN1:Class;
		
		private var delegate:Main;
		private var imageBD:BitmapData;
		private var image:Bitmap;
		
		private var fg:Bitmap;
		private var fgColor:uint;
		
		private var eraser:Bitmap;
		
		private var mouseDown:Boolean;
		private var lastPos:Point;
		
		public function RubbelCanvas(imageBitmapData_:BitmapData, color_:uint, delegate_:Main) 
		{
			imageBD = imageBitmapData_;
			fgColor = color_;
			delegate = delegate_;
			/*
			rubbelFG = createRubbelFG(color_);
			this.addChild(rubbelFG);
			rubbelFG.width = 480;
			rubbelFG.height = 600;
			*/
			
			image = new Bitmap(imageBD);
			this.addChild(image);
			
			fg = new Bitmap(new BitmapData(480, 600, true, color_));
			this.addChild(fg);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);	
			
			eraser = new PEN1();			
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			mouseDown = true;
			lastPos = new Point(e.stageX, e.stageY);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			mouseDown = false
			evaluateImageStatus();
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			if ( !mouseDown ) {
				return;
			}
			
			eraseLine(lastPos, new Point(e.stageX, e.stageY)); 
			lastPos = new Point(e.stageX, e.stageY);
		}
		
		private function eraseLine(from:Point, to:Point):void 
		{			
			var mat:Matrix = new Matrix(1, 0, 0, 1, to.x - eraser.width/2, to.y - eraser.height/2);
			fg.bitmapData.draw(eraser, mat, null, BlendMode.ERASE);
		}		
		
		private function evaluateImageStatus():void 
		{
			var tot:int = fg.width * fg.height;
			var countHiddenPixels:int = 0;
			for ( var j:int = 0; j < fg.height; j++ ) {
				for ( var i:int = 0; i < fg.width; i++ ) {
					if ( fg.bitmapData.getPixel32(i, j) == fgColor ) {
						countHiddenPixels++;
					}
				}
			}
			
			var ratio:Number = countHiddenPixels / tot;
			delegate.onPixelsUncovered(ratio);
		}	
		
	}
}