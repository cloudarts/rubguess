package RubbelRat
{
	//import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author W. Jurczyk
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = "../../gfx/brechtbau.png")] private static var IMG_BRECHTBAU:Class;
		[Embed(source = "../../gfx/hoefstrasse.png")] private static var IMG_HOEFSTRASSE:Class;
		[Embed(source = "../../gfx/wow.png")] private static var IMG_WOW:Class;
		[Embed(source = "../../gfx/granada.png")] private static var IMG_GRANADA:Class;
		[Embed(source = "../../gfx/tauchen.png")] private static var IMG_TAUCHEN:Class;
		[Embed(source = "../../gfx/ronja.png")] private static var IMG_RONJA:Class;
		[Embed(source = "../../gfx/heiraten.png")] private static var IMG_HEIRATEN:Class;
		
		private var canvas:RubbelCanvas;
		private var wordWindow:WordWindow;
		private var pointsTF:TextField;
		private var percentTF:TextField;
		
		private var currentPoints:int = 0;
		private var currentPercent:int = 100;
		
		private var currentStage:int = -1;
		private var words:Array = [	["Berlin", "Osten", "Gefängnis", "Brechtbau"],
									["Heilbronn", "Lego", "Wendelsheim", "Höfstraße"],
									["CoD", "Ringelrei", "wOw", "WoW"],
									["Toscana", "Griechenland", "Ungarn", "Granada"],
									["Fallschirmspringen", "Techtauchen", "LSD", "Tauchen"],
									["Kerstin", "Andrea", "Caro", "Ronja"],
									["Öhm", "Och", "Weißt du...", "Ja"]	];
		
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
			
			
			pointsTF = new TextField();
			pointsTF.textColor = 0xffffff;
			pointsTF.text = "0 pts";
			pointsTF.defaultTextFormat.align = TextFieldAutoSize.RIGHT;
			pointsTF.x = 480 - pointsTF.textWidth;
			pointsTF.mouseEnabled = false;
			
			percentTF = new TextField();
			percentTF.textColor = 0xffffff;
			percentTF.text = "100%";
			percentTF.defaultTextFormat.align = TextFieldAutoSize.LEFT;
			percentTF.x = 0;
			percentTF.mouseEnabled = false;
			
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
			
			if( pointsTF.parent ) {
				this.removeChild(percentTF);
				this.removeChild(pointsTF);
			}
			
			currentStage++;
			
			var bd:BitmapData = new BitmapData(480, 600, false, 0xffff00);
			
			switch( currentStage ) {
				case 0:
					bd = new IMG_BRECHTBAU().bitmapData;
					break;
					
				case 1:
					bd = new IMG_HOEFSTRASSE().bitmapData;
					break;
					
				case 2:
					bd = new IMG_WOW().bitmapData;
					break;
					
				case 3:
					bd = new IMG_GRANADA().bitmapData;
					break;
					
				case 4:
					bd = new IMG_TAUCHEN().bitmapData;
					break;	
					
				case 5:
					bd = new IMG_RONJA().bitmapData;
					break;	
					
				case 6:
					bd = new IMG_HEIRATEN().bitmapData;
					break;					
			}
			
			canvas = new RubbelCanvas(bd, 0xff000000, this);
			this.addChild(canvas);	
			
			wordWindow = new WordWindow(words[currentStage], onWordClicked);
			this.addChild(wordWindow);
			wordWindow.height = 200;
			wordWindow.width = 480;
			wordWindow.y = 600;		
			
			this.addChild(percentTF);
			this.addChild(pointsTF);
		}	
		
		public function onPixelsUncovered(percentCovered_:Number) : void
		{
			var intval:int = percentCovered_*100;
			percentTF.text = "" + intval + "%";
			currentPercent = intval;
		}
		
		public function onWordClicked(text_:String) : void {
			
			var correctWord:String = "";
			
			switch( currentStage ) {
				case 0:
					correctWord = "Brechtbau";
					break;
					
				case 1:
					correctWord = "Höfstraße";
					break;
					
				case 2:
					correctWord = "WoW";
					break;
					
				case 3:
					correctWord = "Granada";
					break;
					
				case 4:
					correctWord = "Tauchen";
					break;	
					
				case 5:
					correctWord = "Ronja";
					break;	
					
				case 6:
					correctWord = "Ja";
					break;					
			}
			
			if ( text_ == correctWord ) {
				currentPoints += currentPercent;
				pointsTF.text = "" + currentPoints + " pts";
				startNextStage();
			}
		}	
	}	
}