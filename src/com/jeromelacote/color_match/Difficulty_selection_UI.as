package com.jeromelacote.color_match
{
	import com.jeromelacote.color_match.PopupEvent;
	import com.jeromelacote.mylib.FileUtilities;
	import com.jeromelacote.mylib.UIEventDispatcher;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class Difficulty_selection_UI extends Difficulty_selection_UI_mc
	{
		private var thisdifficulty:Number=0;
		private var mydata:FileUtilities=new FileUtilities();
		var myscore:Number;
		//var btn_diff1:MovieClip;
		//var btn_diff2:MovieClip;
		//var btn_diff3:MovieClip;
		//var btn_diff4:MovieClip;
		//var bestScore_mc:MovieClip;
		
		public function Difficulty_selection_UI()
			
		{
			btn_diff1.addEventListener(MouseEvent.CLICK, onClick);
			btn_diff2.addEventListener(MouseEvent.CLICK, onClick);
			btn_diff3.addEventListener(MouseEvent.CLICK, onClick);
			btn_diff4.addEventListener(MouseEvent.CLICK, onClick);	
			
			btn_diff1.label_txt.text="SUPER EASY";
			btn_diff2.label_txt.text="MEDIUM";
			btn_diff3.label_txt.text="HARD";
			btn_diff4.label_txt.text="SUPER HARD";
			
			//var myscore=Number(mydata.Read("StoreScore"));
			 myscore=StorageManager.instance.topScore;
			if(myscore<=0){
				bestScore_mc.visible=false;
			} else {
				bestScore_mc.bestscore_txt.text=myscore.toString();
			}
		}
		
		public function onClick(e:MouseEvent):void
		{
			trace ("->onClick");
			if (e.target==btn_diff1){
				thisdifficulty = 1;
			}else if(e.target==btn_diff2){
				thisdifficulty = 2;
			}else if(e.target==btn_diff3){
				thisdifficulty = 3;
			}else if(e.target==btn_diff4){
				thisdifficulty = 4;
			}
			trace("thisdifficulty "+thisdifficulty);
			
			
			var evt:PopupEvent = new PopupEvent( PopupEvent.ON_DIFFICULTYSELECTED );
			evt.data= new Array(thisdifficulty, thisdifficulty);
			StorageManager.instance.difficulty=thisdifficulty;
			UIEventDispatcher.INSTANCE.dispatchEvent(evt);
			
			
		}
		
	}
}

