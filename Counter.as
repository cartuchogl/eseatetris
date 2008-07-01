/*
This file is part of EseaTetris.

EseaTetris is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

EseaTetris is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with EseaTetris.  If not, see <http://www.gnu.org/licenses/>.
*/
package {
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class Counter extends Sprite {
		private var _label:TextField;
		private var _text:TextField;
		
		public function Counter(label:String,text:String="0") {
			_label = new TextField();
			_label.text = label;
			_text = new TextField();
			_text.text = text;
			addChild(_label);
			_text.y = _label.textHeight;
			addChild(_text);
		}
		
		public function set text(txt:String):void {
			_text.text = txt;
		}
		
		public function get textHeight():Number {
			return _label.textHeight+_text.textHeight;
		}
	}
}