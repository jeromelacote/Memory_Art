//////////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2012 Freshplanet (http://freshplanet.com | opensource@freshplanet.com)
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//    http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  
//////////////////////////////////////////////////////////////////////////////////////

package com.jeromelacote.nativeExtensions
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;

	public class InAppPurchase extends EventDispatcher
	{
		private static var _instance:InAppPurchase;
		
		private var extCtx:*;
		
		public function InAppPurchase()
		{
			if (!_instance)
			{
				if (this.isInAppPurchaseSupported)
				{
					extCtx = ExtensionContext.createExtensionContext("com.jeromelacote.nativeExtensions.AirInAppPurchase", null);
					if (extCtx != null)
					{
						extCtx.addEventListener(StatusEvent.STATUS, onStatus);
					} else
					{
						trace('[InAppPurchase] extCtx is null.');
					}
				}
			_instance = this;
			}
			else
			{
				throw Error( 'This is a singleton, use getInstance, do not call the constructor directly');
			}
		}
		
		
		public static function getInstance():InAppPurchase
		{
			return _instance != null ? _instance : new InAppPurchase();
		}
		
		
		public function init():void
		{
			// dont do anything, just create the context.
			// needed when user has transactions pending. Google keeps spamming until we confirm.
			// so the extension has to be ready at launch.
		}
			
		
		
		public function makePurchase(productId:String ):void
		{
			if (this.isInAppPurchaseSupported)
			{
				trace("[InAppPurchase] purchasing", productId);
				extCtx.call("makePurchase", productId);
			} else
			{
				this.dispatchEvent(new InAppPurchaseEvent(InAppPurchaseEvent.PURCHASE_ERROR, "InAppPurchase not supported"));
			}
		}
		
		// receipt is for android device.
		public function removePurchaseFromQueue(productId:String, receipt:String):void
		{
			if (this.isInAppPurchaseSupported)
			{
				trace("[InAppPurchase] removing product from queue", productId, receipt);
				extCtx.call("removePurchaseFromQueue", productId, receipt);
			}
		}
		
		
		
		public function getProductsInfo(productsId:Array):void
		{
			if (this.isInAppPurchaseSupported)
			{
				trace("[InAppPurchase] get Products Info");
				extCtx.call("getProductsInfo", productsId);
			} else
			{
				this.dispatchEvent( new InAppPurchaseEvent(InAppPurchaseEvent.PRODUCT_INFO_ERROR) );
			}

		}
		
		
		public function userCanMakeAPurchase():void 
		{
			if (this.isInAppPurchaseSupported)
			{
				trace("[InAppPurchase] check user can make a purchase");
				extCtx.call("userCanMakeAPurchase");
			} else
			{
				this.dispatchEvent(new InAppPurchaseEvent(InAppPurchaseEvent.PURCHASE_DISABLED));
			}
			
		}
			
		
		
		public function get isInAppPurchaseSupported():Boolean
		{
			var value:Boolean = Capabilities.manufacturer.indexOf('iOS') > -1 || Capabilities.manufacturer.indexOf('Android') > -1;
			trace(value ? '[InAppPurchase]  in app purchase is supported ' : '[InAppPurchase]  in app purchase is not supported ');
			return value;
		}
		
		
		
		private function onStatus(event:StatusEvent):void
		{
			trace(event);
			var e:InAppPurchaseEvent;
			switch(event.code)
			{
				case "PURCHASE_SUCCESSFUL":
					e = new InAppPurchaseEvent(InAppPurchaseEvent.PURCHASE_SUCCESSFULL, event.level);
					break;
				case "PURCHASE_ERROR":
					e = new InAppPurchaseEvent(InAppPurchaseEvent.PURCHASE_ERROR, event.level);
					break;
				case "PURCHASE_ENABLED":
					e = new InAppPurchaseEvent(InAppPurchaseEvent.PURCHASE_ENABLED);
					break;
				case "PURCHASE_DISABLED":
					e = new InAppPurchaseEvent(InAppPurchaseEvent.PURCHASE_DISABLED);
					break;
				case "PRODUCT_INFO_SUCCESS":
					e = new InAppPurchaseEvent(InAppPurchaseEvent.PRODUCT_INFO_RECEIVED, event.level);
					break;
				case "PRODUCT_INFO_ERROR":
					e = new InAppPurchaseEvent(InAppPurchaseEvent.PRODUCT_INFO_ERROR);
					break;
				default:
				
			}
			if (e)
			{
				this.dispatchEvent(e);
			}
			
		}
		
		
		
	}
}