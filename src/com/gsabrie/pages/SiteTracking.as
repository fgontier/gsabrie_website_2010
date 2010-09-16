package com.gsabrie.pages

{
	import com.gaiaframework.utils.Tracking;

	public class SiteTracking {
		private static const GOOGLE_PAGE_TRACKING_FUNCTION:String  = "trackGooglePageView";
		private static const GOOGLE_EVENT_TRACKING_FUNCTION_ONE:String = "trackGoogleEvent";

		public static function googlePage (tag:String):void {
			Tracking.track (GOOGLE_PAGE_TRACKING_FUNCTION, tag);
		}
		public static function googleEvent (cat:String, tag:String, lbl:String = '', val:Number = undefined):void {
			Tracking.track (GOOGLE_EVENT_TRACKING_FUNCTION_ONE, cat, tag, lbl, val);
		}
	}
}