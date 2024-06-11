package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class OptionsState extends FlxState
{
	public static var score:Int = 0;

	var back:FlxButton;
	private var delayTimer:FlxTimer;

	override public function create()
	{
		super.create();
		FlxG.camera.flash(FlxColor.BLACK, 1);
		var backdrop = new FlxBackdrop("assets/images/grid.png");
		backdrop.cameras = [FlxG.camera];
		backdrop.velocity.set(50, 50);
		add(backdrop);
		var text = new FlxText();
		text.text = "PRESS + TO TURN UP VOLUME\nPRESS - TO TURN DOWN VOLUME \nPRESS 0 TO MUTE";
		text.alignment = FlxTextAlign.CENTER;
		text.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4);
		text.font = "assets/fonts/serifbi.ttf";
		text.y = 10;
		text.x = 10;
		text.size = 16;
		text.screenCenter();
		add(text);
		if (FlxG.sound.music == null) // don't restart the music if it's already playing
		{
			FlxG.sound.playMusic("assets/music/music.ogg", 1, true);
		}
		back = new FlxButton(10, 10, "", onBackClick);
		back.loadGraphic("assets/images/back.png");
		add(back);
	}

	var settingsTween:FlxTween;

	function onBackClick()
	{
		if (settingsTween == null)
			settingsTween = FlxTween.tween(back.scale, {x: 0.9, y: 0.9}, 0.5, {ease: FlxEase.quadInOut, type: FlxTweenType.BACKWARD});
		else
			settingsTween.start();
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false, null, true);
		delayTimer = new FlxTimer();
		delayTimer.start(0.5, switchStateAfterDelay);
	}

	private function switchStateAfterDelay(timer:FlxTimer):Void
	{
		FlxG.switchState(new ClickerState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
