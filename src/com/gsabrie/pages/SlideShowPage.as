package com.gsabrie.pages
{
	import classes.graphic.Arrow;
	import classes.graphic.CreateCaption;
	import classes.graphic.TextHandle;
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
		private var _oldSlide:int = 0;
		private var _baseUI:BaseUI;
		private var element_arrowRight:ElementUI;
		private var element_arrowLeft:ElementUI;
		private var _slideCaption:CreateCaption;
		private var _slideTitle:TextHandle;
		private var _storyTitle:String;
		
		public function SlideShowPage()
		{					
			super();
			alpha = 0;
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
			
			// get the xml assets for this story:				
			var assetNodes:XMLList = page.assetArray[0].xml.asset;
			
			// get the page to add assets to:
			var addAssetsTo:IPageAsset = Gaia.api.getPage(Gaia.api.getCurrentBranch());
			
			// add the assets to the page:
			Gaia.api.addAssets(assetNodes, addAssetsTo);

			// get total slide number:
			_totalSlides = page.assetArray.length -1;
			
			// get the story title:
			_storyTitle = page.title;
			
			// load the first photo asset:	
			loadAsset(_currentSlide);
			
			//create caption:
			_slideCaption = new CreateCaption();
			_slideCaption.alpha = 0;
			
			// create title:
			_slideTitle = new TextHandle(0, 0, 260, 17, 15, 0x333333, "left", false, "left", false, false, false, "arial");
			addChild(_slideTitle);
		}
		
		private function loadAsset(i:int):void
		{
			//if the asset is already preloaded, show the photo:
			if (IBitmapSprite(page.assetArray[i]).percentLoaded > 0) 
			{
				showPhoto();	trace("loaded already ")
			}
			// if not, load the photo:
			else 
			{
				IBitmapSprite(page.assetArray[i]).addEventListener(AssetEvent.ASSET_COMPLETE, onAssetLoaded, false, 0, true);
				IBitmapSprite(page.assetArray[i]).load();			
			}
		}		
		
		private function onAssetLoaded(e:AssetEvent):void 
		{		
			e.target.removeEventListener(AssetEvent.ASSET_COMPLETE, onAssetLoaded);
			IBitmapSprite(e.target).smoothing = true; 

			// add this image to baseUI:
			var element_image:ElementUI = _baseUI.add(DisplayObject(e.target.content));
			element_image.ratio = ElementUI.RATIO_IN;
			element_image.left = 80;
			element_image.right = 80;
			element_image.top = 54;
			element_image.bottom = 36;	
			
			// listen for when this element image position is changed:
			element_image.addEventListener(BaseEventUI.UPDATED, element_imageUdapated)			
			
			// if we have a caption:
			if (IBitmapSprite(page.assetArray[_currentSlide]).node != "")
			{			
				e.target.container.addEventListener(MouseEvent.MOUSE_OVER, showCaption);
				e.target.container.addEventListener(MouseEvent.MOUSE_OUT, hideCaption);		
				e.target.buttonMode = true;
				e.target.mouseEnabled = true;
				e.target.useHandCursor = true;
				e.target.mouseChildren = true;	
			}		
			showPhoto();
		}	
		
		private function element_imageUdapated(e:BaseEventUI):void 
		{	
			// resize the caption when the browser window changes:
			_slideCaption.x = ElementUI(e.target).element.x;
			_slideCaption.y = ElementUI(e.target).element.y;
			_slideCaption.captionBgd.width = e.target.screenWidth;
			_slideCaption.myCaption.width = e.target.screenWidth -10;
			_slideCaption.captionBgd.height = _slideCaption.myCaption.height;
		}
		
		private function showPhoto():void
		{	
			// show the current slide:
			IBitmapSprite(page.assetArray[_currentSlide]).alpha = 0;
			TweenMax.to(IBitmapSprite(page.assetArray[_currentSlide]), 0.5, { autoAlpha:1});

			// show the slide title:
			_slideTitle.text = " |   " + _storyTitle + "  |  " + _currentSlide + "/" + _totalSlides;
			
			
			// create arrows only when the first slide of the story is loaded:
			if (_oldSlide == 0)
			{
				createArrow();
			}
			
			// hide the old slide if it is not the first one:
			if (_oldSlide > 0)
			{
				TweenMax.to(IBitmapSprite(page.assetArray[_oldSlide]), 0.5, { autoAlpha:0 } )
			}
			
			// move the caption on top of the photo:
			IBitmapSprite(page.assetArray[_currentSlide]).addChild(_slideCaption);

			// if we have a caption:
			if (IBitmapSprite(page.assetArray[_currentSlide]).node != "")
			{
				// update the text in the caption:
				_slideCaption.myCaption.text = page.assetArray[_currentSlide].node;
				
			}
			else
			{
				_slideCaption.myCaption.text = "";
			}
			
			// the next image is on screen, we can click again:
			arrowRight.mouseEnabled = true;	
			
			// force refresh the photo in case the stage has been resized:
			var e:ElementUI = _baseUI.getElement(IBitmapSprite(page.assetArray[_currentSlide]).content);
			e.forceRefresh();	
		}	
		
		private function createArrow():void
		{			
			// creates the navigation arrows:
			arrowRight = new Arrow(0, 10, 20, 40);
			arrowRight.addEventListener(MouseEvent.CLICK, arrowRight_mouseClickHandler);
			addChild(arrowRight);
			
			element_arrowRight = _baseUI.add(arrowRight);
			element_arrowRight.right = 15
			element_arrowRight.verticalCenter = 20;
			
			arrowLeft = new Arrow(20, 10, 0, 40);
			arrowLeft.addEventListener(MouseEvent.CLICK, arrowLeft_mouseClickHandler);
			// hide the arrow left for the first photo:
			arrowLeft.visible = false;
			addChild(arrowLeft);
			
			element_arrowLeft = _baseUI.add(arrowLeft);
			element_arrowLeft.left = 25
			element_arrowLeft.verticalCenter = 20;
		}
		
		private function arrowRight_mouseClickHandler(e:MouseEvent):void 
		{
			e.target.mouseEnabled = false;		// can't click the right arrow again.
			
			arrowLeft.visible = true;
			element_arrowLeft.forceRefresh();
			_oldSlide = _currentSlide;
			
			if (_currentSlide < _totalSlides) 
			{
				_currentSlide ++; 
			}
			if (_currentSlide == _totalSlides)  
			{
				arrowRight.visible = false; 	// hide arrowRight if this is the last photo
			}
			loadAsset(_currentSlide);
		}	
		
		private function arrowLeft_mouseClickHandler(e:MouseEvent):void 
		{
			arrowRight.visible = true;
			element_arrowRight.forceRefresh();
			_oldSlide = _currentSlide;
			
			if (_currentSlide > 1) 
			{
				_currentSlide --;				// show the previous slide
			}
			if (_currentSlide == 1) 
			{
				arrowLeft.visible = false; 		// hide arrowLeft
			}
			showPhoto();
		}
		
		private function showCaption(e:MouseEvent):void 
		{
			TweenMax.to(_slideCaption, 0.5, { alpha:1});
		}
		
		private function hideCaption(e:MouseEvent):void 
		{
			TweenMax.to(_slideCaption, 0.5, { alpha:0});
		}
	}
}
