package;

import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSubState;

import extension.webview.WebView;

using StringTools;

class VideoSubState extends MusicBeatSubstate
{
	public static var androidPath:String = 'file:///android_asset/';

	public var finishCallback:Void->Void;

	var text:FlxText;

	public function new(source:String)
	{
		super();

		text = new FlxText(0, 0, 0, "Toque para continuar", 48);
		text.screenCenter();
		text.alpha = 0;
		add(text);

		//FlxG.autoPause = false;

		WebView.onClose=onClose;
		WebView.onURLChanging=onURLChanging;

		WebView.open(androidPath + source + '.html', false, null, ['http://exitme(.*)']);
	}

	public override function update(dt:Float) {
		for (touch in FlxG.touches.list)
			if (touch.justReleased)
				onClose();

		super.update(dt);	
	}

	function onClose(){// not working
		text.alpha = 0;
		PlayState.nacutscene = true;
		//FlxG.autoPause = true;
		close();
	}

	function onURLChanging(url:String) {
		text.alpha = 1;
		if (url == 'http://exitme/') onClose(); // drity hack lol
		trace("WebView is about to open: "+url);
	}
}