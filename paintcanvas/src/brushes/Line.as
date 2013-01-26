package brushes
{
	import elements.Layer;
	
	import flash.geom.Point;
	
	import util.GraphicsUtil;

	public class Line extends Brush implements IBrush
	{
		public function Line()
		{
			super();
		}
		
		override public function redraw():void
		{
			if(strokes == null || strokes.length == 0) return;			
			
			for each(var stroke:BrushStroke in strokes)
			{				
				currentStroke = stroke;
				
				// Add the sprite to the layer
				if(layer == null) continue;				
				
				layer.addChild(currentStroke.sprite);
				
				if(stroke.points == null || stroke.points.length == 0)	continue;				
				currentStroke.sprite.graphics.lineStyle(stroke.size, stroke.color, stroke.alpha);
				currentStroke.sprite.graphics.moveTo((stroke.points[0] as Point).x, (stroke.points[1] as Point).y);	
				
				// Draw the points
				for each(var point:Point in stroke.points){
					currentStroke.sprite.graphics.lineTo(point.x, point.y);
				}					
			}
		}
		
		public function mouseDown(p:Point):void
		{
			currentStroke = new BrushStroke();
			currentStroke.points.push(p);
			layer.addChild(currentStroke.sprite);
			
			currentStroke.sprite.graphics.lineStyle(size,color,alpha);
			currentStroke.sprite.graphics.moveTo(p.x,p.y);
		}
		
		public function mouseMove(p:Point):void
		{
			var cp:Point = currentStroke.points[0];
			
			currentStroke.sprite.graphics.clear();
			currentStroke.sprite.graphics.lineStyle(size,color,alpha);
			currentStroke.sprite.graphics.moveTo(cp.x, cp.y);
			currentStroke.sprite.graphics.lineTo(p.x, p.y);
		}
		
		public function mouseUp(p:Point):void
		{
			var cp:Point = currentStroke.points[0];
			
			currentStroke.sprite.graphics.clear();
			currentStroke.sprite.graphics.lineStyle(size,color,alpha);
			currentStroke.sprite.graphics.moveTo(cp.x, cp.y);
			currentStroke.sprite.graphics.lineTo(p.x, p.y);
			
			currentStroke.points.push(p);
			
			currentStroke.color = color;
			currentStroke.size = size;
			currentStroke.alpha = alpha;
			
			strokes.push(currentStroke);
			currentStroke = null;
		}
		
		public function finalize():void
		{
		}
		
		override public function getType():String
		{
			return GraphicsUtil.BRUSH_LINE;
		}		
	}
}