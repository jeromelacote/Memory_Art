/*************************************************************************
*
* ADOBE CONFIDENTIAL
* ___________________
*
*  Copyright [first year code created] Adobe Systems Incorporated
*  All Rights Reserved.
*
* NOTICE:  All information contained herein is, and remains
* the property of Adobe Systems Incorporated and its suppliers,
* if any.  The intellectual and technical concepts contained
* herein are proprietary to Adobe Systems Incorporated and its
* suppliers and are protected by trade secret or copyright law.
* Dissemination of this information or reproduction of this material
* is strictly forbidden unless prior written permission is obtained
* from Adobe Systems Incorporated.
**************************************************************************/

package
{
	import com.adobe.ane.productStore.Product;
	import com.adobe.ane.productStore.ProductEvent;
	import com.adobe.ane.productStore.ProductStore;
	import com.adobe.ane.productStore.Transaction;
	import com.adobe.ane.productStore.TransactionEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.sampler.NewObjectSample;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ProductStoreTest extends Sprite
	{			
		private var productStore:ProductStore = null;
		private var arrC3:Array=new Array();
		private var arrC2:Array=new Array();
		
		private var avlTxt:CustomTextField;
		private var isAvailable:CustomButton;
		private var isSupported:CustomButton;
		private var suppTxt:CustomTextField;
		private var restoreTransaction:CustomButton;
		private var getProduct:CustomButton;
		private var gt:TextField;
		private var proSuc:CustomTextField;
		private var prodSuccess:TextField;
		private var val:String;
		private var restoreVal:CustomTextField;
		private var restoreTxt:TextField;
		private var pendBtn:CustomButton;
		
		public function ProductStoreTest()
		{
		  isAvailable = new CustomButton( "isAvailable", 0,-135,70,25);
		 addChild(isAvailable);
		  avlTxt = new CustomTextField();
		 addChild(avlTxt);
		 isAvailable.addEventListener(MouseEvent.CLICK, is_Available);
		 
		 isSupported = new CustomButton("isSupported",250,-135,70,25);
		 addChild(isSupported);
		 suppTxt = new CustomTextField();
		 addChild(suppTxt);
		 isSupported.addEventListener(MouseEvent.CLICK, check_isSupported);
		 
		 restoreTransaction = new CustomButton("restoreTransaction", 0,-90,100,25);
		 addChild(restoreTransaction);
		 restoreTransaction.addEventListener(MouseEvent.CLICK, restore_Transactions);
		 restoreVal = new CustomTextField();
		 restoreTxt = restoreVal.create(130,-90,150,25);
		 addChild(restoreTxt);
		 		 
		 getProduct = new CustomButton("getProduct",0,-50,70,25);
		 addChild(getProduct);
		 getProduct.addEventListener(MouseEvent.CLICK, get_Product);
		 
		 proSuc = new CustomTextField();
		 addChild(proSuc);
		 prodSuccess = proSuc.create(135,-20,200,50);
		 addChild(prodSuccess);
		 prodSuccess.text = "PRODUCT DETAILS";
		 
		 pendBtn = new CustomButton("Pending Transactions", 0, 180, 110, 25);
		 addChild(pendBtn);
		 pendBtn.addEventListener(MouseEvent.CLICK, pending_transaction);
		 
		 gt = new TextField();
		 gt.x = 0;
		 gt.y = -20;
		 gt.width = 120;
		 gt.height = 50;
		 gt.border = true;
		 addChild(gt);
		}
		
		protected function check_isSupported(event:MouseEvent):void
		{
			trace("in ckeck is supported");
			productStore=new ProductStore()
			var t1:Boolean=ProductStore.isSupported;
			var t:TextField = suppTxt.create(330,-135,60,25);
			t.text=t1.toString();
		}
		
//		protected function abc(ps:ProductStore):void
//		{
//			trace("in abc");
//		}
		
		protected function is_Available(event:MouseEvent):void
		{
			var ps:ProductStore=new ProductStore();
			trace("in is_Available");
			var t2:Boolean=productStore.available;
			var t:TextField = avlTxt.create(90, -135,60,20);
			t.text=t2.toString();
		}
		
		public function get_Product(event:MouseEvent):void
		{
			trace("in get_Product");
			productStore.addEventListener(ProductEvent.PRODUCT_DETAILS_SUCCESS,productDetailsSucceeded);
			productStore.addEventListener(ProductEvent.PRODUCT_DETAILS_FAIL, productDetailsFailed);
			
			var vector:Vector.<String> = new Vector.<String>(3);
			vector[0] = "9";
			vector[1] = "p8";
			vector[2] = "1234897";
			productStore.requestProductsDetails(vector);
			gt.text =( "Available products: \n" + "1. Consumable \n" + "2. Non Consumable \n"+ vector);
			var consumable:CustomButton = new CustomButton("Consumable", 0,50, 70,25);
			addChild(consumable);
			consumable.addEventListener(MouseEvent.CLICK, consumableProduct);
			var nonconsumable:CustomButton = new CustomButton("Non Consumable", 90, 50, 90,25);
			addChild(nonconsumable);
			nonconsumable.addEventListener(MouseEvent.CLICK, nonconsumableProduct);		
		}
		
		public function productDetailsSucceeded(e:ProductEvent):void
		{
			trace("in productDetailsSucceeded "+e);
			var i:uint=0;
			while(e.products && i < e.products.length)
			{
				var p:Product = e.products[i];
				prodSuccess.appendText("\nTITLE: " + p.title + "\nDescription: " + p.description + "\nIdentifier : " + p.identifier + "PriceLocale : " + p.priceLocale + "\nPrice: " + p.price);
				trace("title : "+p.title);
				trace("description: "+p.description);
				trace("identifier: "+p.identifier);
				trace("priceLocale: "+p.priceLocale);
				trace("price :"+p.price);
				i++;
			}
		}
		
		public function productDetailsFailed(e:ProductEvent):void
		{
			trace("in productDetailsFailed"+e);
			var i:uint=0;
			while(e.invalidIdentifiers && i < e.invalidIdentifiers.length)
			{
				trace(e.invalidIdentifiers[i]);
				i++;
			}
		}
		
		public function consumableProduct(e:MouseEvent):void
		{
			trace("consumable product...");
			productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_SUCCESS, purchaseTransactionSucceeded);
			productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_CANCEL, purchaseTransactionCanceled);
			productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_FAIL, purchaseTransactionFailed);
			productStore.makePurchaseTransaction("p8",1);
		}
		
		public function nonconsumableProduct(e:MouseEvent):void
		{
			trace("Non consumable product...");
			productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_SUCCESS, purchaseTransactionSucceeded);
			productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_CANCEL, purchaseTransactionCanceled);
			productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_FAIL, purchaseTransactionFailed);
			productStore.makePurchaseTransaction("9",1);
		}
		
		protected function purchaseTransactionSucceeded(e:TransactionEvent):void
		{
			trace("in purchaseTransactionSucceeded" +e);
			var i:uint=0;
			var t:Transaction;
			while(e.transactions && i < e.transactions.length)
			{
				t = e.transactions[i];
				printTransaction(t);
				i++;
				var Base:Base64=new Base64();
				var encodedReceipt:String = Base64.Encode(t.receipt);
				var req:URLRequest = new URLRequest("https://sandbox.itunes.apple.com/verifyReceipt");
				req.method = URLRequestMethod.POST;
				req.data = "{\"receipt-data\" : \""+ encodedReceipt+"\"}";
				var ldr:URLLoader = new URLLoader(req);
				ldr.load(req);
				ldr.addEventListener(Event.COMPLETE,function(e:Event):void{
					trace("LOAD COMPLETE: " + ldr.data);
					productStore.addEventListener(TransactionEvent.FINISH_TRANSACTION_SUCCESS, finishTransactionSucceeded);
					productStore.finishTransaction(t.identifier);
				});
				
				trace("Called Finish on/Finish Transaction " + t.identifier); 
			}
			getPendingTransaction(productStore);
		}
		
		protected function purchaseTransactionCanceled(e:TransactionEvent):void{
			trace("in purchaseTransactionCanceled"+e);
			var i:uint=0;
			while(e.transactions && i < e.transactions.length)
			{
				var t:Transaction = e.transactions[i];
				printTransaction(t);
				i++;
				trace("FinishTransactions" + t.identifier);
				productStore.addEventListener(TransactionEvent.FINISH_TRANSACTION_SUCCESS, finishTransactionSucceeded);
				productStore.finishTransaction(t.identifier);
			}
			getPendingTransaction(productStore);
		}
		
		protected function purchaseTransactionFailed(e:TransactionEvent):void
		{
			trace("in purchaseTransactionFailed"+e);
			var i:uint=0;
			while(e.transactions && i < e.transactions.length)
			{
				var t:Transaction = e.transactions[i];
				printTransaction(t);
				i++;
				trace("FinishTransactions" + t.identifier);
				productStore.addEventListener(TransactionEvent.FINISH_TRANSACTION_SUCCESS, finishTransactionSucceeded);
				productStore.finishTransaction(t.identifier);
			}
			
			getPendingTransaction(productStore);
		}
		
		protected function finishTransactionSucceeded(e:TransactionEvent):void{
			trace("in finishTransactionSucceeded" +e);
			var i:uint=0;
			while(e.transactions && i < e.transactions.length)
			{
				var t:Transaction = e.transactions[i];
				printTransaction(t);
				i++;
			}
		}
		
		protected function restore_Transactions(event:MouseEvent):void
		{
			trace("in restore_Transactions");
			productStore.addEventListener(TransactionEvent.RESTORE_TRANSACTION_SUCCESS, restoreTransactionSucceeded);
			productStore.addEventListener(TransactionEvent.RESTORE_TRANSACTION_FAIL, restoreTransactionFailed);
			productStore.addEventListener(TransactionEvent.RESTORE_TRANSACTION_COMPLETE,  restoreTransactionCompleted);
			productStore.restoreTransactions();
			
		}
		
		protected function restoreTransactionSucceeded(e:TransactionEvent):void{
			trace("in restoreTransactionSucceeded" +e);
			val= "Restore Success";
			restoreTxt.text = val;
			var i:uint=0;
			while(e.transactions && i < e.transactions.length)
			{
				var t:Transaction = e.transactions[i];
				printTransaction(t);
				i++;
				
				trace("FinishTransactions" + t.identifier);
				productStore.addEventListener(TransactionEvent.FINISH_TRANSACTION_SUCCESS, finishTransactionSucceeded);
				productStore.finishTransaction(t.identifier);
			}
			
			getPendingTransaction(productStore);
		}
		
		protected function restoreTransactionFailed(e:TransactionEvent):void{
			trace("in restoreTransactionFailed" +e);
			val="Restore Fail";
			restoreTxt.text = val;
		}
		
		protected function restoreTransactionCompleted(e:TransactionEvent):void{
			trace("in restoreTransactionCompleted" +e);
			val = "Restore Complete";
			restoreTxt.text = val;
		}
		
		protected function pending_transaction(event:MouseEvent):void
		{
			getPendingTransaction(productStore);
		}
		
		public function getPendingTransaction(prdStore:ProductStore):void
		{
			trace("pending transaction");
			var transactions:Vector.<Transaction> = prdStore.pendingTransactions; 
			var i:uint=0;
			while(transactions && i<transactions.length)
			{
				var t:Transaction = transactions[i];
				printTransaction(t);
				i++;
			}
		}
		
		public function printTransaction(t:Transaction):void
		{
			trace("-------------------in Print Transaction----------------------");
			trace("identifier :"+t.identifier);
			trace("productIdentifier: "+ t.productIdentifier);
			trace("productQuantity: "+t.productQuantity);
			trace("date: "+t.date);
			trace("receipt: "+t.receipt);
			trace("error: "+t.error);
			trace("originalTransaction: "+t.originalTransaction);
			if(t.originalTransaction)
				printTransaction(t.originalTransaction);
			trace("---------end of print transaction----------------------------");
		}		
	}
}