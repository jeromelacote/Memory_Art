package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	[SWF(frameRate="30", backgroundColor="#eeeeee", width=640, height=960)]
	public class MemoryArt extends Sprite
	{
		public var game:Color_match=new Color_match();
		public function MemoryArt()
		{
			super();
			this.addChild(game);
			game.scaleX=game.scaleY=.9;
			//var pst:ProductStoreTest=new ProductStoreTest();
			//this.addChild(pst);
			trace ("HI");
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
	}
}