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
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	public class Board extends Sprite {
		private var _scoreC:Counter;
		private var _levelC:Counter;
		private var _linesC:Counter;
		private var _score:uint = 0;
		private var _level:uint = 1;
		private var _lines:uint = 0;
		
		public function reset():void {
			score = 0;
			level = 1;
			lines = 0;
			removeChild(_nextPiece);
		}
		
		public function get score():uint { return _score; }
		public function set score(val:uint):void {
			_score = val;
			_scoreC.text = _score.toString();
		}
		public function get level():uint { return _level; }
		public function set level(val:uint):void {
			_level = val;
			_levelC.text = _level.toString();
		}
		public function get lines():uint { return _lines; }
		public function set lines(val:uint):void {
			_lines = val;
			level = _lines/10+1;
			_linesC.text = _lines.toString();
		}
		
		private var _nextLabel:TextField;
		private var _nextPiece:Block;
		
		public function Board() {
			_scoreC = new Counter("SCORE",_score.toString());
			_levelC = new Counter("LEVEL",_level.toString());
			_linesC = new Counter("LINES",_lines.toString());
			addChild(_scoreC);
			_levelC.y = _scoreC.textHeight;
			addChild(_levelC);
			_linesC.y = _scoreC.textHeight+_levelC.textHeight;
			addChild(_linesC);
			
			_nextLabel = new TextField();
			_nextLabel.text = "NEXT";
			_nextLabel.y = _scoreC.textHeight+_levelC.textHeight+_linesC.textHeight;
			addChild(_nextLabel);
		}
		
		public function set nextPiece(block:Block):void {
			_nextPiece = block;
			_nextPiece.draw();
			_nextPiece.y = _scoreC.textHeight+_levelC.textHeight+_linesC.textHeight+_nextLabel.textHeight+3;
			addChild(_nextPiece);
		}
		
		public function get nextPiece():Block {
			removeChild(_nextPiece);
			return _nextPiece;
		}
	}
}