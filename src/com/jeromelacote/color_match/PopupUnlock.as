package com.jeromelacote.color_match
{
	import caurina.transitions.*;
	
	import com.jeromelacote.color_match.PopupEvent;
	import com.jeromelacote.mylib.FileUtilities;
	import com.jeromelacote.mylib.UIEventDispatcher;
	import com.kutty.utils.components.Scrollbar;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	
	public class PopupUnlock extends PopupUnlock_mc
	{
		public var myUnlockLevel:Number;
		public var UnlockName= new Array("Modern Art","Impressionist","Classic");
		public function PopupUnlock(unlockLevel:Number)
		{
			myUnlockLevel=unlockLevel;
			close_btn.addEventListener(MouseEvent.CLICK, onClick);
			buy_btn.addEventListener(MouseEvent.CLICK, onBuy);
			buy_btn.label_txt.text="BUY !";
			level_txt.text="level to unlock is "+UnlockName[unlockLevel];
			buy_btn.buttonMode=true;
			close_btn.buttonMode=true;
			illus_mc.gotoAndStop(unlockLevel+1);
		}
		
		public function onClick(e:MouseEvent) 
		{
			var cevt:PopupEvent = new PopupEvent( PopupEvent.ON_HIDEUNLOCKPOPUP);
			UIEventDispatcher.INSTANCE.dispatchEvent(cevt);
			
		}
		public function onBuy(e:MouseEvent) 
		{
			trace(onBuy)
			var evt:PopupEvent = new PopupEvent( PopupEvent.ON_BUYUNLOCK);
			evt.data=new Array(myUnlockLevel,myUnlockLevel);
			UIEventDispatcher.INSTANCE.dispatchEvent(evt);
			e.target.visible=false;
			
		}
	}
}