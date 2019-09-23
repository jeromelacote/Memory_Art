package com.jeromelacote.mylib{
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	public class UIEventDispatcher extends EventDispatcher{
		
		public static const INSTANCE:UIEventDispatcher = new UIEventDispatcher();
		
		public function UIEventDispatcher(){
			if( INSTANCE == null ){
				super();
			}
			else throw new Error( 'You Attempted to Instansiate a Singleton Instance' );
		}
	}
}