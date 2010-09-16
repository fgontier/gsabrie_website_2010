package com.gsabrie.pages
{
	import classes.graphic.Arrow;
	import classes.graphic.CreateCaption;
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import com.gaiaframework.assets.*;
	import com.soundstep.ui.BaseUI;
	import com.soundstep.ui.ElementUI;
	import com.soundstep.ui.events.BaseEventUI;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	
	public class SlideShowPage extends AbstractPage
	{	
		private var arrowRight:Arrow;
		private var arrowLeft:Arrow;
		private var _currentSlide:int = 1;
		private var _totalSlides:Number; 
		private var myAsset:*;
		private var _baseUI:BaseUI;
		//private var element_image:ElementUI;
		//private var element_caption:ElementUI;
		//private var element_captionBgd:ElementUI;
		private var _slideCaption:CreateCaption;
		
		public function SlideShowPage()
		{					
			super();
			alpha = 0;
			//new Scaffold(this);
		}
		override public function transitionIn():void 
		{
			super.transitionIn();
			createSlideShow();
			TweenMax.to(this, 0.3, { alpha:1, onComplete:transitionInComplete } );
		}	
		
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
		
		private function createSlideShow():void
		{ 	
			_baseUI = new BaseUI(this);	
			createArrow();

			// get the xml assets for this story:				
			var assetNodes:XMLList = page.assetArray[0].xml.asset;
			// get the page to add assets to:
			var addAssetsTo:IPageAsset = Gaia.api.getPage(Gaia.api.getCurrentBranch());
			// add the assets to the page:
			Gaia.api.addAssets(assetNodes, addAssetsTo);
			// load the first photo asset:	
//myAsset =  page.assetArray[1];	
//myAsset.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetLoaded, false, 0, true);
//myAsset.load();
			loadAsset(_currentSlide);
			_totalSlides = page.assetArray.length -1;
		}

		private function loadAsset(i:int):void
		{
			myAsset = IBitmapSprite(page.assetArray[i]);
			//if the asset is already preloaded, show the photo
			if (myAsset.percentLoaded > 0) 
			{
				showPhoto();
			}
			else 
			{
				myAsset.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetLoaded, false, 0, true);
				myAsset.load();			
			}
		}			

		private function onAssetLoaded(e:AssetEvent):void 
		{		
			e.target.removeEventListener(AssetEvent.ASSET_COMPLETE, onAssetLoaded);
			e.target.alpha = 0;
			e.target.visible = true;
			showPhoto();
	
			// get when this element image position is changed:
			//element_image.addEventListener(BaseEventUI.UPDATED, element_imageUdapated)

			arrowRight.mouseEnabled = true;
		}	
		
		private function showPhoto():void
		{
			// add this image to baseUI:
			var element_image:ElementUI = _baseUI.add(DisplayObject(myAsset.content));
			element_image.ratio = ElementUI.RATIO_IN;
			element_image.left = 80;
			element_image.right = 80;
			element_image.top = 54;
			element_image.bottom = 36;
			// fire an BaseEvent when this element image  is changed:
			element_image.addEventListener(BaseEventUI.UPDATED, element_imageUdapated)			
			
			// show the current slide
			TweenMax.to(IBitmapSprite(myAsset), 0.3, { autoAlpha:1, onComplete:onFinishTween } )
		
			// if we have caption, create it:
			if (myAsset.node.toString() != "" )
			{				
				//myAsset.container.addEventListener(MouseEvent.MOUSE_OVER, showCaption);
				//myAsset.container.addEventListener(MouseEvent.MOUSE_OUT, hideCaption);		
				myAsset.buttonMode = true;
				myAsset.mouseEnabled = true;
				myAsset.useHandCursor = true;
				myAsset.mouseChildren = true;			
				_slideCaption = new CreateCaption(page.assetArray[_currentSlide].node);				
				
				myAsset.container.addChild(_slideCaption);			
			}
			// refresh _baseUI to update caption
			_baseUI.refresh();
			//var e:ElementUI = _baseUI.getElement(IBitmapSprite(page.assetArray[_currentSlide]).content);
			//e.forceRefresh();	
		}		
		
		private function element_imageUdapated(e:BaseEventUI):void 
		{	trace("element_imageUdapated "  + e.target)
			// resize the caption when the browser window changes:
			_slideCaption.x = ElementUI(e.target).element.x;
			_slideCaption.y = ElementUI(e.target).element.y;
			_slideCaption.captionBgd.width = e.target.screenWidth;
			_slideCaption.myCaption.width = e.target.screenWidth -10;
			_slideCaption.captionBgd.height = _slideCaption.myCaption.height;
		}
		

		
		private function onFinishTween():void
		{
			arrowRight.mouseEnabled = true;	// we can click again.
		}
		
		private function createArrow():void
		{			
			// creates the navigation arrows:
			arrowRight = new Arrow(0, 10, 20, 40);
			arrowRight.addEventListener(MouseEvent.CLICK, arrowRight_mouseClickHandler);
			addChild(arrowRight);
			
			var element_arrowRight:ElementUI = _baseUI.add(arrowRight);
			element_arrowRight.right = 10
			element_arrowRight.verticalCenter = 20;
			
			arrowLeft = new Arrow(20, 10, 0, 40);
			arrowLeft.addEventListener(MouseEvent.CLICK, arrowLeft_mouseClickHandler);
			// hide the arrow left for the first photo:
			arrowLeft.visible = false;
			addChild(arrowLeft);
			
			var element_arrowLeft:ElementUI = _baseUI.add(arrowLeft);
			element_arrowLeft.left = 20
			element_arrowLeft.verticalCenter = 20;
		}
		
		private function arrowRight_mouseClickHandler(e:Event):void 
		{
			e.target.mouseEnabled = false;		// can't click the right arrow.
			arrowLeft.visible = true;
			// hide the current slide:
			TweenMax.to(IBitmapSprite(page.assetArray[_currentSlide]), 1, { autoAlpha:0 } );	
				
			if (_currentSlide < _totalSlides) 
			{
				_currentSlide ++; 
			}
			if (_currentSlide == _totalSlides)  
			{
				arrowRight.visible = false; // hide arrowRight if this is the last photo
			}
			loadAsset(_currentSlide);
		}	
		
		private function arrowLeft_mouseClickHandler(e:MouseEvent):void 
		{
			arrowRight.visible = true;
			// hide the current slide:
			TweenMax.to(IBitmapSprite(page.assetArray[_currentSlide]), 1, { autoAlpha:0 } );	
			
			if (_currentSlide > 1) 
			{
				_currentSlide --;		// show the previous slide
			}
			if (_currentSlide == 1) 
			{
				arrowLeft.visible = false; // hide arrowLeft
			}
			
			myAsset = IBitmapSprite(page.assetArray[_currentSlide]);
			showPhoto();
		}
		
		private function showCaption(e:MouseEvent):void 
		{
			IBitmapSprite(page.assetArray[_currentSlide]).getChildAt(1).alpha = 1;
			// resize the caption bgd height:
			_slideCaption.captionBgd.height =  _slideCaption.myCaption.height
			trace("e.e "  + e.currentTarget.height)
		}
		
		private function hideCaption(e:MouseEvent):void 
		{
			IBitmapSprite(page.assetArray[_currentSlide]).getChildAt(1).alpha = 0
		}
	}
}

/*			var assetArray:Array = page.assetArray;
			var len:int = assetArray.length;
			for (var i:int = 0; i < len; i++)
			{
				IBitmap(assetArray[0]).visible = true;
			}*/	

/*		override public function transitionInComplete():void {			
			super.transitionInComplete();
			trace("lala")				
		}*/	
			//trace("lolo " + page.assetArray);
			//trace("this.asset1 " + assets)	
			//myBitmap = IBitmap(assetArray[i]).content
			//myBitmap.visible = true;
			//trace ("IBitmap(assets.asset1) " + IBitmap(assets.asset1).visible);
			//trace("lll " + GaiaDebug.log(IBitmap(assets.asset1).content))
			//IBitmap(assets.asset1).visible  = true;
			//IDisplayObject(assets.asset1).visible = true;	
				//trace("myBitmap =" + IBitmap(page.assetArray[i]).content)		
				//trace("page.assetArray[i] " + " i: " + i + "  " + page.assetArray[i]);
				//trace("this.assets " + page.assetArray[i].xml)		
				//trace("this.asset1 " + this.assets.asset1)