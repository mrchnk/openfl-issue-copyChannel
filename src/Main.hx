import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.display.BitmapDataChannel;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.geom.Point;

class Main extends Sprite {

  private var zero:Point;
  private var colorRect:Rectangle;
  private var alphaRect:Rectangle;
  private var bmpWidth:Int;
  private var bmpHeight:Int;

  public function new () {
    super ();

    stage.color = 0x00ff00;

    var data = Assets.getBitmapData("assets/sprite.jpg");

    bmpWidth = Std.int(data.width / 2);
    bmpHeight = data.height;
    zero = new Point();
    colorRect = new Rectangle(0, 0, bmpWidth, bmpHeight);
    alphaRect = new Rectangle(bmpWidth, 0, bmpWidth, bmpHeight);

    var merged = mergeAlpha1(data);

    var bmp = new Bitmap(merged);
    bmp.x = stage.stageWidth/2 - bmpWidth/2;
    bmp.y = stage.stageHeight/2 - bmpHeight/2;
    addChild(bmp);
  }

  /**
  * Is not working
  */
  private function mergeAlpha1(data:BitmapData) {
    var merged = new BitmapData(bmpWidth, bmpHeight, true, 0);
    merged.copyPixels(data, colorRect, zero);
    merged.copyChannel(data, alphaRect, zero,
      BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
    return merged;
  }

  /**
  * Is not working
  */
  private function mergeAlpha2(data:BitmapData) {
    var merged = new BitmapData(bmpWidth, bmpHeight, true, 0);
    merged.copyChannel(data, colorRect, zero,
      BitmapDataChannel.RED, BitmapDataChannel.RED);
    merged.copyChannel(data, colorRect, zero,
      BitmapDataChannel.GREEN, BitmapDataChannel.GREEN);
    merged.copyChannel(data, colorRect, zero,
      BitmapDataChannel.BLUE, BitmapDataChannel.BLUE);
    merged.copyChannel(data, alphaRect, zero,
      BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
    return merged;
  }

  /**
  * Workaraund with separated alpha bitmap
  */
  private function mergeAlpha3(data:BitmapData) {
    var merged = new BitmapData(bmpWidth, bmpHeight, true, 0);
    merged.copyPixels(data, colorRect, zero);

    var alpha = new BitmapData(bmpWidth, bmpHeight, false, 0);
    alpha.copyPixels(data, alphaRect, zero);

    merged.copyChannel(alpha, alpha.rect, zero,
      BitmapDataChannel.RED, BitmapDataChannel.ALPHA);

    alpha.dispose();
    return merged;
  }

  /**
  * Workaraund with changed source bitmap
  */
  private function mergeAlpha4(data:BitmapData) {
    var merged = new BitmapData(bmpWidth, bmpHeight, true, 0);
    merged.copyPixels(data, colorRect, zero);
    data.copyPixels(data, alphaRect, zero);
    merged.copyChannel(data, colorRect, zero,
      BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
    return merged;
  }

}
