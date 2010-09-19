#ifndef _TEST_APP
#define _TEST_APP


/**
 * @author	Diederick Huijbers <diederick@apollomedia.nl>
 *
 * This example just shows you the linker and search settings
 * you need to use when you want to run libmicrohttpd and ofxHTTPServer
 * on windows.
 */

#include "ofMain.h"
#include "ofxHTTPServer.h"

class testApp : public ofBaseApp{

	public:
		void setup();
		void update();
		void draw();

		void keyPressed  (int key);
		void keyReleased(int key);
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased(int x, int y, int button);
		void windowResized(int w, int h);

		ofxHTTPServer* http;

};

#endif
