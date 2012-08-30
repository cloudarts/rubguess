package RubbelRat
{
	//import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author W. Jurczyk
	 */
	public class Main extends Sprite 
	{
		private var canvas:RubbelCanvas;
		private var wordWindow:WordWindow;
		
		private var currentStage:int = -1;
		private var words:Array = [	["stage1", "onkomonko", "stage1", "stage1"],
									["onkomonko", "stage2", "stage2", "stage2"],
									["stage3", "stage3", "onkomonko", "stage3"],
									["stage4", "stage4", "stage4", "onkomonko"],
									["stage5", "onkomonko", "stage5", "stage5"]	];
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			startNextStage();
		}
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			//NativeApplication.nativeApplication.exit();
		}
		
		private function startNextStage() : void {
			
			if ( currentStage == words.length -1 ) {
				trace("done!");
				return;
			}
			
			if ( canvas ) {
				this.removeChild(canvas);
				canvas.deinit();
				canvas = null;
			}
			
			if ( wordWindow ) {
				this.removeChild(wordWindow);
				wordWindow.deinit();
				wordWindow = null;
			}
			
			currentStage++;
			
			canvas = new RubbelCanvas(new BitmapData(480, 600, false, 0xffff00), 0xff000000, this);
			this.addChild(canvas);	
			
			wordWindow = new WordWindow(words[currentStage], onWordClicked);
			this.addChild(wordWindow);
			wordWindow.height = 200;
			wordWindow.width = 480;
			wordWindow.y = 600;			
		}	
		
		public function onPixelsUncovered(percentCovered_:Number) : void
		{
			trace(percentCovered_);
		}
		
		public function onWordClicked(text_:String) : void {
			
			var correctWord:String = "";
			
			switch( currentStage ) {
				case 0:
					correctWord = "onkomonko";
					break;
					
				case 1:
					correctWord = "onkomonko";
					break;
					
				case 2:
					correctWord = "onkomonko";
					break;
					
				case 3:
					correctWord = "onkomonko";
					break;
					
				case 4:
					correctWord = "onkomonko";
					break;					
			}
			
			if ( text_ == correctWord ) {
				startNextStage();
			}
		}	
	}	
}