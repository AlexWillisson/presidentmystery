package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;

	public class Button extends Entity
	{
		protected var _callback:Function;

		public function Button(callback:Function, x:int, y:int, w:int, h:int, btn:Class=null)
		{
			super(x, y);

			if (btn != null) {
				graphic = new Image(btn);
			}

			_callback = callback;
			setHitbox(w, h);
		}

		override public function update():void
		{
			if (!world) {
				return;
			}

			if (collidePoint(x, y, Input.mouseX, Input.mouseY)) {
				if (Input.mouseReleased) {
					_callback()
				}
			}
		}
	}
}
