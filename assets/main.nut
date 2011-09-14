emo.Runtime.import("physics.nut");

class Main
{
	obj1 = null;
	stX = 0;
	stY = 0;
	rope = null;
	ground = null;
	stage = null;
	event = null;
	physics = null;
	gravity = null;
	world = null;
	ballFixture = null;
	ballDef = null;
	gravity = null;

	function onLoad()
	{
		print("onLoad"); 
//		emo.Runtime().setOptions(OPT_ORIENTATION_LANDSCAPE);

		stage = emo.Stage();
		event = emo.Event();
		physics = emo.Physics();
		gravity = emo.Vec2(0, 10);
		world = emo.physics.World( gravity, true) ;

		obj1 = emo.Rectangle();
		obj1.move( 100, 40 );
		obj1.color(1, 0, 0, 1);
		obj1.setSize(50, 50);
		obj1.load();

		rope = emo.Line();
		rope.load();
		rope.hide();


		ground = emo.Rectangle();
		ground.setSize( 800, 10 );
		ground.move( 0, 750 );
		physics.createStaticSprite( world, ground );
		ground.load();

		ballFixture = emo.physics.FixtureDef();
		ballFixture.density  = 1.0;
		ballFixture.friction = 0.3;
		ballFixture.restitution = 0.2;

		// the balls won't sleep
		ballDef = emo.physics.BodyDef();
		ballDef.allowSleep = false;

		AddBox( 50, 50 );
		event.enableOnDrawCallback( 1000.0 / 60.0 );
	}

	function AddBox( x, y )
	{
		local sprite = emo.Rectangle();
		sprite.setSize( 20, 20 );
		sprite.load();
		sprite.move( x, y );
//		sprites.append( sprite );

		physics.createDynamicSprite
		(
			world, sprite, ballFixture, ballDef
		);
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

	function onDrawFrame( dt )
	{
		world.step( dt / 1000.0, 5, 2 );
		world.clearForces();
	}
}

function emo::onLoad()
{
	emo.Stage().load( Main() );
}
