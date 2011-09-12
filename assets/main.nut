class Main
{
	obj1 = null;
	stX = 0;
	stY = 0;
	rope = null;

	function onLoad()
	{
		print("onLoad"); 
		obj1 = emo.Rectangle();
		obj1.move( 100, 200 );
		obj1.color(1, 0, 0, 1);
		obj1.setSize(50, 50);
		obj1.load();
		rope = emo.Line();
		rope.load();
		rope.hide();
	}

	function onGainedFocus()
	{
		print("onGainedFocus");
	}

	function onLostFocus()
	{
		print("onLostFocus"); 
	}

	function onDispose()
	{
		print("onDispose");
	}

	function onMotionEvent( mevent )
	{
		local x = mevent.getX();
		local y = mevent.getY();
		if( mevent.getAction() == MOTION_EVENT_ACTION_DOWN )
		{
			stX = x;
			stY = y;
		}
		else if( mevent.getAction() == MOTION_EVENT_ACTION_MOVE )
		{
			obj1.moveCenter( x, y );
			rope.show();
			rope.move( stX, stY, x, y );
		}
		else if( mevent.getAction() == MOTION_EVENT_ACTION_UP ||
				 mevent.getAction() == MOTION_EVENT_ACTION_CANCEL )
		{
			rope.hide();
		}
	}
}

function emo::onLoad()
{
	emo.Stage().load( Main() );
}
