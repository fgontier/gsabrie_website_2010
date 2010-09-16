package com.gsabrie.pages
{
	import classes.graphic.TextHandle;
	import classes.menu.accordionMenuRoll;
	import classes.menu.MenuEvent;
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	import com.gaiaframework.utils.AssetFilter;	

	
	public class MenuStoryPage extends AbstractPage
	{
		private var loadedImageNum:int = 0;
		private var _slideTitle:TextHandle;	
		
		public function MenuStoryPage()
		{
			super();
			alpha = 0;
			//new Scaffold(this);
		}
		override public function transitionIn():void 
		{
			super.transitionIn();
			TweenMax.to(this, 0.3, { alpha:1, onComplete:transitionInComplete } );
			//createMenu();
			preloadImages();
			// create title:
			_slideTitle = new TextHandle(0, 0, 260, 17, 15, 0x333333, "left", false, "left", false, false, false, "arial");
			_slideTitle.text = " |   STORIES" 
			addChild(_slideTitle);
		}
		
		private function preloadImages():void
		{
			// get the xml assets for this story:				
			var assetNodes:XMLList = page.assetArray[0].xml.asset;
			
			// get the page to add assets to:
			var addAssetsTo:IPageAsset = Gaia.api.getPage(Gaia.api.getCurrentBranch());
			
			// add the assets to the page:
			Gaia.api.addAssets(assetNodes, addAssetsTo);
			
			// load the menu images:
			for (var i:int = 1; i < page.assetArray.length; i++) 
			{
				//if the asset is already preloaded, show the photo:
				if (page.assetArray[i].percentLoaded > 0) 
				{
					createMenu();	trace("loaded already ")
					break;
				}
				// if not, load the photo:
				else 			
				{	
				page.assetArray[i].addEventListener(AssetEvent.ASSET_COMPLETE, onAssetLoaded, false, 0, true);
				page.assetArray[i].load();
				}
			}
		}
		
		private function onAssetLoaded(e:AssetEvent):void 
		{		
			e.target.removeEventListener(AssetEvent.ASSET_COMPLETE, onAssetLoaded);
			loadedImageNum++;
			//trace("loadedImageNum " + loadedImageNum)
			if (loadedImageNum == page.assetArray.length -1) 
			{
				createMenu();
			}
		}
		
		private function createMenu():void
		{
			for (var i:int = 1; i < page.assetArray.length; i++) 
			{	
				// get the title of the page:
				var menuTitle:String = page.assetArray[i].title;
				// get the menuText:
				var menuText:String = page.assetArray[i].node;	
				// show the image:
				page.assetArray[i].visible = true;
				// create the menu:
				var newMenu:accordionMenuRoll = new accordionMenuRoll(IBitmap(page.assetArray[i]).content, menuTitle, menuText, "not used");
				addChild(newMenu);	
				addEventListener("MENU_EVENT", clickedStory);
			}
			//dispatch a new event telling the first menu item to open
			dispatchEvent(new MenuEvent(MenuEvent.MENU_EVENT, 0 ));	
		}
		
		private function clickedStory(e:Event):void 
		{
			Gaia.api.goto("index/nav/" + page.assetArray[(e.target.id) +1].id); 
			trace("id " + page.assetArray[(e.target.id) +1].id);

			SiteTracking.googleEvent('Story', 'Click', page.assetArray[(e.target.id) +1].id);
		}
		
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}
