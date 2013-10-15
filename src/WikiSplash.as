package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class WikiSplash extends Entity {
		[Embed(source = "../assets/images/blank.png")] private const bg:Class;

		private var text:TextEntity, ctrls:TextEntity;
		private var _callback:Function;
		private var wiki:WikiPage;

		public function WikiSplash(wikiPage:WikiPage) {
			graphic = new Image(bg)
			x = 0;
			y = 0;

			wiki = wikiPage;
			text = new TextEntity(50, 150, "Could this be real? It must be a prank, one of your friends must\nhave engraved 'US President' on your phone. You search the\ninternet for your name.", 22, 0xffffff);

			ctrls = new TextEntity(300, 400, "Press space to continue", 18, 0xffffff);
		}

		override public function update():void
		{
			if (Input.released(Key.SPACE)) {
				world.add(wiki);
				world.remove(this);
			}
		}

		override public function added():void
		{
			world.add(text);
			world.add(ctrls);
		}

		override public function removed():void
		{
			world.remove(text);
			world.remove(ctrls);
		}
	}
}
