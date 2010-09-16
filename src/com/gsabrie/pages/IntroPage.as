package com.gsabrie.pages
{
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import com.gaiaframework.assets.*;
	import com.soundstep.ui.BaseUI;
	import com.soundstep.ui.ElementUI;
	import com.soundstep.ui.events.BaseEventUI;

	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	
	public class IntroPage extends AbstractPage
	{	
		private var myAsset:IBitmapSprite;
		private var _baseUI:BaseUI;
		
		public function IntroPage()
		{					
			super();
			alpha = 0;
			//new Scaffold(this);
		}
		override public function transitionIn():void 
		{
			super.transitionIn();
			createIntro();
			TweenMax.to(this, 0.3, { alpha:1, onComplete:transitionInComplete } );
		}	
		
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
		
		private function createIntro():void
		{	
			_baseUI = new BaseUI(this);		
			// get asset from xml:
			var assetNodes:XMLList = assets.intro.xml.asset;						trace("assetNodes " + assetNodes )
			// get the page intro:
			var addAssetsTo:IPageAsset = Gaia.api.getPage("index/nav/intro");
			// add the assets to the corresponding page:
			Gaia.api.addAssets(assetNodes, addAssetsTo);
			
			// load a random asset image for the intro:
			var assetArray:Array = page.assetArray;									trace("assetArray " + page.assetArray[0] )
			var minLimit:uint = 0;													trace("minLimit 1 ")
			var maxLimit:uint = assetArray.length -1;								trace("maxLimit " + maxLimit)
			var range:uint = maxLimit - minLimit;									trace("range " + range)
			var someNum:Number = Math.ceil(Math.random()*range) + minLimit;			trace("someNum " + someNum)

			myAsset =  page.assetArray[someNum];									trace("myAsset " + myAsset)
			myAsset.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetLoaded, false, 0, true);
			myAsset.load();
		}
		
		private function onAssetLoaded(e:AssetEvent):void 
		{		
			e.target.removeEventListener(AssetEvent.ASSET_COMPLETE, onAssetLoaded);
			e.target.alpha = 0;
			IBitmapSprite(e.target).smoothing = true;
			
			// add this image to baseUI:
			var element_image:ElementUI = _baseUI.add(DisplayObject(e.target.content));	
			element_image.ratio = ElementUI.RATIO_IN;
			element_image.left = 80;
			element_image.right = 80;
			element_image.top = 54;
			element_image.bottom = 36;	
			
			trace("e.target " + e.target)
			
			// show the intro photo:
			TweenMax.to(IBitmapSprite(e.target), 0.3, { autoAlpha:1} );
		}	
	}
}