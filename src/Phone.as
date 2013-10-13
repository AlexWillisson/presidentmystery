package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	public class Phone extends Entity {
		[Embed(source = "../assets/images/phone.png")] private const phone:Class;
		public function Phone() {
			graphic = new Image(phone)
			x = 0;
			y = 0;
		}
	}
}
