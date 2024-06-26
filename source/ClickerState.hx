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

class ClickerState extends FlxState
{
	public static var score:Int = 0;

	var scoreText:FlxText;
	var cookie:FlxButton;
	var settings:FlxButton;
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
		text.text = "BGM: Neko Atsume";
		text.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4);
		text.font = "assets/fonts/serifbi.ttf";
		text.y = 10;
		text.x = 10;
		text.size = 16;
		add(text);
		if (FlxG.sound.music == null) // don't restart the music if it's already playing
		{
			FlxG.sound.playMusic("assets/music/music.ogg", 1, true);
		}
		scoreText = new FlxText(0, 10, FlxG.width, '$score');
		scoreText.size = 48;
		scoreText.alignment = FlxTextAlign.CENTER;
		scoreText.setFormat("assets/fonts/serifbi.ttf", 48, 0xffffff, "center");
		scoreText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4);
		add(scoreText);
		cookie = new FlxButton(100, 100, "", onCookieButtonClick);
		cookie.loadGraphic("assets/images/art/0.png");
		cookie.screenCenter();
		add(cookie);
		settings = new FlxButton(580, 10, "", onOptionsClick);
		settings.loadGraphic("assets/images/settings.png");
		add(settings);
	}

	var cookieTween:FlxTween;
	var scoreTween:FlxTween;
	var settingsTween:FlxTween;

	function onCookieButtonClick()
	{
		score += 1;
		scoreText.text = '$score';
		if (score % 100 == 0)
			FlxG.sound.play("assets/sounds/squeak.ogg");
		else
			FlxG.sound.play("assets/sounds/mouse-click.ogg");
		if (cookieTween == null)
			cookieTween = FlxTween.tween(cookie.scale, {x: 0.9, y: 0.9}, 0.5, {ease: FlxEase.quadInOut, type: FlxTweenType.BACKWARD});
		else
			cookieTween.start();
		if (scoreTween == null)
			scoreTween = FlxTween.tween(scoreText.scale, {x: 1.1, y: 1.1}, 0.2, {ease: FlxEase.quadInOut, type: FlxTweenType.BACKWARD});
		else
			scoreTween.start();
	}

	function onOptionsClick()
	{
		if (settingsTween == null)
			settingsTween = FlxTween.tween(settings.scale, {x: 0.9, y: 0.9}, 0.5, {ease: FlxEase.quadInOut, type: FlxTweenType.BACKWARD});
		else
			settingsTween.start();
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false, null, true);
		delayTimer = new FlxTimer();
		delayTimer.start(0.5, switchStateAfterDelay);
	}

	private function switchStateAfterDelay(timer:FlxTimer):Void
	{
		FlxG.switchState(new OptionsState());
	}

	var meowPlayed:Bool = false; // Flag to track if the meow sound has been played

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (score % 10 == 0 && score != 0 && !meowPlayed)
		{
			FlxG.sound.play("assets/sounds/meow.ogg");
			meowPlayed = true; // Set the flag to true after playing the sound
		}
		if (score % 10 == 9)
		{
			meowPlayed = false;
		}
	}
}
