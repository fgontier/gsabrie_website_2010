package com.gsabrie.pages
{
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	
	
	public class IndexPage extends AbstractPage
	{	
			
		public function IndexPage()
		{
			super();
			alpha = 0;
			//new Scaffold(this);
		}
		
		override public function transitionIn():void 
		{
			super.transitionIn();
			TweenMax.to(this, 0.3, { alpha:1, onComplete:transitionInComplete } );
			//addXMLassets();
			Gaia.api.setPreloaderDelay(1000);
			trace("page.assetArray.length " + page.assetArray.length)
		}
		
		// not used:
		private function addXMLassets():void
		{
			
/*    var assetNodes:XMLList = IXml(assets.menuStory).xml.asset;
    var homePage:IPageAsset = Gaia.api.getPage("index/nav/menuStory");
    Gaia.api.addAssets(assetNodes, homePage);*/			
	
			for (var i:int = 0; i < page.assetArray.length; i++) 
			{	
				// get the assets of the index page:
				var assetNodes:XMLList = page.assetArray[i].xml.asset;
				// get the id of the assets of the index page:
				var idName:String = page.assetArray[i].id;
				// get the page with the same id name:
				var addAssetsTo:IPageAsset = Gaia.api.getPage("index/nav/" + idName);
				// add the assets to the corresponding page:
				Gaia.api.addAssets(assetNodes, addAssetsTo);	
			}
		}
		
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}
