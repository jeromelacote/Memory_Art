package com.jeromelacote.color_match
{
	import com.jeromelacote.color_match.PopupEvent;
	import com.jeromelacote.mylib.FileUtilities;
	import com.jeromelacote.mylib.UIEventDispatcher;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	
	
	
	public class Level_selection_item extends Level_selection_item_mc
	{
		
		public var mylevel:Number;
		public var curentLevel:Number;
		public var so:SharedObject = SharedObject.getLocal("colorMatchObject");
		public var imageCollec:Array=new Array("img1","img2","img3","img4","img5","img6","img7","img8","img9","img10","img11","img12","img13","img14","img15","img16","img17","img18","img19","img20","img21","img22","img23","img24","img25","img26","img27","img28","img29","img30","img31","img32","img33","img34","img35","img36");
		public var mydata:FileUtilities=new FileUtilities();
		public var img:Painting=new Painting();
		
		public function Level_selection_item()
		{
			super();
			addChild(img);
			img.scaleX=img.scaleY=0.196;
			addChild(this["secret_mc"]);
			addChild(this["lock_mc"]);
			addChild(this["btn_play"]);
			addChild(this["label_txt"]);
		}

		
		public function init(id:Number):void
		{
			curentLevel=StorageManager.instance.top_level[StorageManager.instance.difficulty];
			//trace ("curentLevel "+curentLevel)
			
			if(curentLevel==0){curentLevel=1;}
			
			//curentLevel=40; //hack
			
			mylevel=id+1;
			
			//img.gotoAndStop(mylevel);
			this["img"].loadImg(imageCollec[mylevel-1]);
			//trace("-----------imageCollec--------"+imageCollec[mylevel-1]);
			this["label_txt"].text="LEVEL "+(mylevel);
			this["secret_mc"].visible=false;
			this["lock_mc"].visible=false;
			this["btn_play"].visible=false;
			if(id==(curentLevel-1)){
				this["secret_mc"].visible=true;
			}
			if(id>(curentLevel-1)){
				this["btn_play"].visible=false;
					this["lock_mc"].visible=true;
			}else{
				this["btn_play"].visible=true;
				this["btn_play"].addEventListener(MouseEvent.CLICK, onClick);
				this["img"].addEventListener(MouseEvent.CLICK, onClick);
				this["btn_play"].label_txt.text="PLAY";
				this["btn_play"].buttonMode=true;
			}
			
			
		}
		
		
		public function onClick(e:MouseEvent):void 
		{
			trace ("onClick" + mylevel)

			var revt:PopupEvent = new PopupEvent( PopupEvent.ON_PLAYLEVEL );
			revt.data=mylevel;
			StorageManager.instance.current_level[StorageManager.instance.difficulty]=mylevel;
			UIEventDispatcher.INSTANCE.dispatchEvent(revt);
			
		}
		
		
	}
}