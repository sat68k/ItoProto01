class Bg
{
	stage = emo.Stage();
	physics = null;
	world = null;
	wall = [];

	//===================================================
	// load
	//===================================================
	function load()
	{
		world = ::work.world;
		physics = ::work.physics;

		for(local i=0; i<4; i++)
		{
			wall.append( emo.Rectangle() );
		}
		wall[0].setSize(stage.getWindowWidth(), 10);
		wall[1].setSize(stage.getWindowWidth(), 10);
		wall[2].setSize(10, stage.getWindowHeight());
		wall[3].setSize(10, stage.getWindowHeight());
		wall[0].move(0, 0);
		wall[1].move(0, stage.getWindowHeight() - wall[1].getHeight());
		wall[2].move(0, 0);
		wall[3].move(stage.getWindowWidth() - wall[3].getWidth(), 0);
		for(local i=0; i<4; i++)
		{
			wall[i].load();
			physics.createStaticSprite( world, wall[i] );
		}
	}


	//===================================================
	// dispose
	//===================================================
	function dispose()
	{
	}
}

