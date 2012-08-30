package RubbelRat 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author W. Jurczyk
	 */
	public class WordWindow extends Sprite 
	{
		private var words:Array;
		private var wordTFs:Array = new Array();
		private var currentWordIndex:int = 0;
		private var callBack:Function;
		
		private var lastTime:Number;
		
		private const speed:Number = 400;
		
		public function WordWindow(words_:Array, callBack_:Function) 
		{
			words = words_;
			callBack = callBack_;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function deinit():void 
		{
			words = null;
			callBack = null;
			
			if( this.hasEventListener(Event.ENTER_FRAME) ) {
				this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			
			for ( var i:int = 0; i < wordTFs.length; i++ ) {
				wordTFs[i].removeEventListener(MouseEvent.CLICK, onTFClicked);
				if( wordTFs[i].parent ) {
					this.removeChild(wordTFs[i]);
				}
				wordTFs[i] = null;
			}
			
			wordTFs = null;
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.width = 480;
			this.height = 200;
			
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(0, 0, 480, 200);
			this.graphics.endFill();
			
			createWords();
			startAnimation();
		}
		
		private function startAnimation():void 
		{
			lastTime = new Date().getTime();
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			currentWordIndex = 0;
			this.addChild(wordTFs[currentWordIndex]);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			var now:Number = new Date().getTime();
			var diff:Number = now - lastTime;
			var delta:Number = diff / 1000;
			
			var tf:TextField = wordTFs[currentWordIndex];
			
			tf.x -= speed * delta;
			
			if ( tf.x <= -tf.width ) {
				tf.x = 480;
				this.removeChild(tf);
				currentWordIndex++;
				if ( currentWordIndex >= words.length ) {
					currentWordIndex = 0;
				}
				this.addChild(wordTFs[currentWordIndex]);
				wordTFs[currentWordIndex].x = 800;
			}
			
			lastTime = now;
		}
		
		private function createWords():void 
		{
			for ( var i:int = 0; i < words.length; i++ ) {
				var tf:TextField = new TextField();
				var format:TextFormat = new TextFormat();
				format.size = 150;
				tf.defaultTextFormat = format;
				//tf.cacheAsBitmap = true;
				tf.text = words[i];
				tf.textColor = 0x000000;
				tf.cacheAsBitmap = true;
				wordTFs.push(tf);
				tf.addEventListener(MouseEvent.CLICK, onTFClicked);
				tf.autoSize = TextFieldAutoSize.LEFT;
				tf.x = 800;
				tf.y = 25;
				tf.width = tf.textWidth;
			}
		}
		
		private function onTFClicked(e:MouseEvent):void 
		{
			var tf:TextField = e.target as TextField;
			callBack(tf.text);
		}		
	}
}