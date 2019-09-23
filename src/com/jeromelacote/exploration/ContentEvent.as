package com.jeromelacote.exploration
{
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class ContentEvent extends Event
	{
		
		public static const ON_MOVECONTENT:String = 'ContentEvent.ON_MOVECONTENT';
		
		public var data:Object;
		public var who:MovieClip;
		
		public function ContentEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
		
		/*public override function clone():Event{
			var evt:GameplayEvent=new GameplayEvent(type);
			evt.data=data;
			return evt;
		}*/
		
	}
}



