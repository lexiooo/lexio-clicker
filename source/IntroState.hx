package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class IntroState extends FlxState
{
	var alpha:Float = 1;
	var sprite:FlxSprite;
	var alphaDir:Int = -1;
	var timer:Float = 0;
	var direction:Bool = false;
	var color:FlxColor;
	private var delayTimer:FlxTimer;

	override public function create()
	{
		super.create();
		FlxG.sound.play("assets/sounds/lexio-watermark.ogg");
		var sprite = new FlxSprite();
		sprite.loadGraphic("assets/images/intro/lexio-logo.png");
		sprite.screenCenter();
		add(sprite);
		delayTimer = new FlxTimer();
		delayTimer.start(4, switchStateAfterDelay);
	}

	private function switchStateAfterDelay(timer:FlxTimer):Void
	{
		FlxG.switchState(new ClickerState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		timer -= elapsed;
		if (timer <= 0)
		{
			timer = 4;
			if (!direction)
			{
				color = FlxColor.fromHSB(0, 0, 0);
			}
			FlxG.camera.fade(color, 2, direction, null, true);
			direction = !direction;
		}
	}
}
