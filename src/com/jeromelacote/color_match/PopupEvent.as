package com.jeromelacote.color_match
{
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class PopupEvent extends Event
	{
		
		public static const ON_REPLAY:String = 'PopupEvent.ON_REPLAY';
		public static const ON_SETDATA:String = 'PopupEvent.ON_SETDATA';
		public static const ON_SETINFO:String = 'PopupEvent.ON_SETINFO';
		public static const ON_PLAYNEXTLEVEL:String = 'PopupEvent.ON_PLAYNEXTLEVEL';
		public static const ON_PLAYLEVEL:String = 'PopupEvent.ON_PLAYLEVEL';
		public static const ON_BACKHOME:String = 'PopupEvent.ON_BACKHOME';
		public static const ON_UPDATEPAGE:String = 'PopupEvent.ON_UPDATEPAGE';
		public static const ON_SHOWUNLOCKPOPUP:String = 'PopupEvent.ON_SHOWUNLOCKPOPUP';
		public static const ON_HIDEUNLOCKPOPUP:String = 'PopupEvent.ON_HIDEUNLOCKPOPUP';
		public static const ON_BACK:String = 'PopupEvent.ON_BACK';
		public static const ON_HIDEINFO:String = 'PopupEvent.ON_HIDEINFO';
		public static const ON_DIFFICULTYSELECTED:String = 'PopupEvent.ON_DIFFICULTYSELECTED';
		public static const ON_BUYUNLOCK:String = 'PopupEvent.ON_BUYUNLOCK';
		
		
		public var data:Object;
		public var who:MovieClip;
		
		public function PopupEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
		
		/*public override function clone():Event{
			var evt:GameplayEvent=new GameplayEvent(type);
			evt.data=data;
			return evt;
		}*/
		
		
	}
}



