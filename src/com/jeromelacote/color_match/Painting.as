package com.jeromelacote.color_match
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	
	public class Painting extends Painting_mc
	{
		
		private var bitmapData:BitmapData;
		private var bmVis:Bitmap;
		public var mat:Matrix=new Matrix(); // Matrix for our transformation</span>
		private var bg:Sprite=new Sprite();
		private var offsetX:Number;
		private var offsetY:Number;
		private var tileSize:Number;
		
		public function Painting()
		{
			super();	
			this["framing_mc"].visible=false;
		}
		
		public function loadImg (img:String):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			//trace ("img is "+img);
			try {
			loader.load(new URLRequest("image/"+img+".jpg"));
			}
			catch(error:Error){
				trace (error.toString()+ " - "+img);
			}
		}
		
		public function loadTile (img:String,offX:Number,offY:Number,size:Number):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteTile);
			var url:String="image/"+img+".jpg";
			trace(url);
			loader.load(new URLRequest(url));
			offsetX=offX;
			offsetY=offY;
			tileSize=size;
			
		}
		
		
		public function onComplete (event:Event):void
		{
			//trace("loaded!");
			bitmapData = event.target.content.bitmapData;
			//bmVis = new Bitmap(bitmapData);
			//this.addChild(bmVis);
			
			mat.translate(0,0);  
			
			bg.graphics.clear();
			
			bg.graphics.beginBitmapFill(bitmapData,mat,false,true);
			bg.graphics.drawRect(0,0,640,640);
			this.addChild(bg);
			this["framing_mc"].visible=true;
			this["framing_mc"].alpha=1;
		}
		
		
		public function onCompleteTile (event:Event):void
		{
			//trace("loaded!");
			bitmapData = event.target.content.bitmapData;
			//bmVis = new Bitmap(bitmapData);
			//this.addChild(bmVis);
			
			mat.translate(offsetX,offsetY); 
			
			bg.graphics.clear();
			bg.graphics.beginBitmapFill(bitmapData,mat,true,true);
			bg.graphics.drawRect(0,0,tileSize,tileSize);
			this.addChild(bg);
			this["framing_mc"].visible=false;
		}

	}
}



//////////////////////



