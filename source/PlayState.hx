package;

import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();
		FlxG.mouse.useSystemCursor = true;
		FlxG.switchState(new IntroState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
