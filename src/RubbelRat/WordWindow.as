package RubbelRat 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author W. Jurczyk
	 */
	public class WordWindow extends Sprite 
	{
		private var words:Array;
		private var wordTFs:Array;
		private var currentWord:int = 0;
		private var callBack:Function;
		
		private var lastTime:Number;
		
		public function WordWindow(words_:Array, callBack_:Function) 
		{
			words = words_;
			callBack = callBack_;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
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
		}
		
		private function onEnterFrame(e:Event):void 
		{
			var diff:Number = new Date().getTime() - lastTime;
			var delta:Number = diff / 1000;
			
			
		}
		
		private function createWords():void 
		{
			for ( var i:int = 0; i < words.length; i++ ) {
				var tf:TextField = new TextField();
				tf.text = words[i];
				wordTFs.push(tf);
				tf.addEventListener(MouseEvent.CLICK, onTFClicked);
			}
		}
		
		private function onTFClicked(e:MouseEvent):void 
		{
			var tf:TextField = (TextField) e.target;
			callBack(tf.text);
		}
		
		
		
	}

}