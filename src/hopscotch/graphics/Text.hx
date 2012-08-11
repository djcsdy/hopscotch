package hopscotch.graphics;

import flash.geom.Rectangle;
import flash.text.TextFormatAlign;
import flash.text.TextFormatAlign;
import hopscotch.Static;
import flash.geom.ColorTransform;
import flash.text.TextFormat;
import hopscotch.errors.IllegalOperationError;
import flash.text.TextField;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.display.BitmapData;
import hopscotch.engine.ScreenSize;

class Text implements IGraphic {
    // Add this fudge value to measured text dimensions, because TextField.textWidth and TextField.textHeight
    // are notoriously broken.
    private static inline var TEXT_DIMENSIONS_FUDGE = 4;

    public var active:Bool;
    public var visible:Bool;

    public var x:Float;
    public var y:Float;
    public var width:Float;
    public var height:Float;

    public var text:String;

    public var fontFace:FontFace;
    public var fontSize:Float;

    public var color:UInt;
    public var alpha:Float;

    public var align:TextFormatAlign;

    public var wordWrap:Bool;
    public var autoSize:Bool;

    public var originX:Float;
    public var originY:Float;

    public var angle:Float;
    public var scale:Float;

    var textFormat:TextFormat;
    var textField:TextField;

    public function new() {
        active = false;
        visible = true;

        x = 0;
        y = 0;
        width = 0;
        height = 0;

        text = "";

        fontFace = FontFace.sans;
        fontSize = 16;
        color = 0x000000;
        alpha = 1;

        wordWrap = false;
        autoSize = true;

        originX = 0;
        originY = 0;

        angle = 0;
        scale = 1;

        textFormat = new TextFormat();
        textFormat.font = fontFace.name;
        textFormat.size = fontSize;

        textField = new TextField();
    }

    public function measure(outSize:Point) {
        updateTextField();

        outSize.x = textField.width;
        outSize.y = textField.height;
    }

    public function measureText(outSize:Point) {
        updateTextField();

        outSize.x = textField.textWidth + TEXT_DIMENSIONS_FUDGE;
        outSize.y = textField.textHeight + TEXT_DIMENSIONS_FUDGE;
    }

    public function centerOrigin() {
        measureText(Static.point);
        originX = Static.point.x * 0.5;
        originY = Static.point.y * 0.5;
    }

    public function beginGraphic(frame:Int) {
    }

    public function endGraphic():Void {
    }

    public function updateGraphic(frame:Int, screenSize:ScreenSize) {
    }

    public function render(target:BitmapData, position:Point, camera:Matrix) {
        updateTextField();

        Static.matrix.a = Static.matrix.d = 1;
        Static.matrix.b = Static.matrix.c = 0;
        Static.matrix.tx = -originX;
        Static.matrix.ty = -originY;

        Static.matrix.rotate(angle);
        Static.matrix.scale(scale, scale);
        Static.matrix.tx += position.x + x;
        Static.matrix.ty += position.y + y;
        Static.matrix.concat(camera);

        var rect:Rectangle = null;

        if (angle == 0 && scale == 1) {
            Static.rect.x = Math.floor(Static.matrix.tx);
            Static.rect.y = Math.floor(Static.matrix.ty);
            Static.rect.width = Math.ceil(textField.width + 1);
            Static.rect.height = Math.ceil(textField.height + 1);

            rect = Static.rect;
        }

        var colorTransform:ColorTransform = null;
        if (alpha < 1) {
            colorTransform = Static.colorTransform;
            colorTransform.redMultiplier = 1;
            colorTransform.greenMultiplier = 1;
            colorTransform.blueMultiplier = 1;
            colorTransform.redOffset = 0;
            colorTransform.greenOffset = 0;
            colorTransform.blueOffset = 0;
            colorTransform.alphaMultiplier = alpha;
            colorTransform.alphaOffset = 0;
        }

        target.draw(textField, Static.matrix, colorTransform, null, rect, true);
    }

    function updateTextField() {
        if (fontFace == null) {
            throw new IllegalOperationError("fontFace must not be null");
        }

        var updated = false;

        if (textField.embedFonts != fontFace.embedded) {
            textField.embedFonts = fontFace.embedded;
            updated = true;
        }

        if (textFormat.font != fontFace.name) {
            textFormat.font = fontFace.name;
            updated = true;
        }

        if (textFormat.size != fontSize) {
            textFormat.size = fontSize;
            updated = true;
        }

        if (textFormat.color != color) {
            textFormat.color = color;
            updated = true;
        }

        if (textFormat.align != align) {
            textFormat.align = align;
            updated = true;
        }

        if (textField.text != text) {
            textField.text = text;
            updated = true;
        }

        if (textField.wordWrap != wordWrap) {
            textField.wordWrap = wordWrap;
            updated = true;
        }

        if (updated) {
            textField.setTextFormat(textFormat);
        }

        if (autoSize) {
            if (wordWrap) {
                updated = updated || textField.width != width;
            }

            if (updated) {
                if (wordWrap) {
                    textField.width = width;
                    textField.height = textField.textHeight + TEXT_DIMENSIONS_FUDGE;
                } else {
                    textField.width = textField.textWidth + TEXT_DIMENSIONS_FUDGE;
                    textField.height = textField.textHeight + TEXT_DIMENSIONS_FUDGE;
                }
            }
        } else {
            if (textField.width != width) {
                textField.width = width;
            }

            if (textField.height != height) {
                textField.height = height;
            }
        }
    }
}
