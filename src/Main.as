package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;

	public class Main extends Engine
	{
		public function Main()
		{
			//Changed to 592 because 600 has 8 pixels too much. This doesn't seem to have fixed anything, however.
			//Will need to figure out how to fix that later.
			super(800, 592, 60, false);
			FP.world = new StartWorld();
		}

		override public function init():void
		{
			trace("FlashPunk has started successfully!");
		}
		

	}
}