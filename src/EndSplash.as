package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	public class EndSplash extends Entity {
		[Embed(source = "../assets/images/blank.png")] private const bg:Class;

		private var text:TextEntity, dialog:TextEntity, ctrls:TextEntity;

		public function EndSplash() {
			graphic = new Image(bg)
			x = 0;
			y = 0;

			text = new TextEntity(100, 100, "End of President Mystery prototype", 36, 0xffffff);
			dialog = new TextEntity(100, 200, "You have escaped the hospital, but who was that mysterious\nperson sending you texts? Why aren't you the President\nanymore, and why can't you remember being President?\n\n\n(Potentially) tune in next project, for the complete saga of\n\n                                        President Mystery", 22, 0xffffff);
			ctrls = new TextEntity(270, 500, "Reload the page to restart", 22, 0xffffff);
		}

		override public function added():void
		{
			world.add(text);
			world.add(dialog);
			world.add(ctrls);
		}

		override public function removed():void
		{
			world.remove(text);
			world.remove(dialog);
			world.remove(ctrls);
		}
	}
}
