package com.jeromelacote.color_match
{
	import flash.display.MovieClip;
	
	public class Cell extends Cell_mc
	{
		public var id:Number;
		public var img:Painting=new Painting();
		
		public function Cell()
			
		{
			addChild(img);
			//img.scaleX=img.scaleY=0.196;
			addChild(this["secret_mc"]);

		}
		
		public function init(size:Number)
		{
			//trace ("------------------------------------"+size);
			secret_mc.width=secret_mc.height=size;
		}
	}
}