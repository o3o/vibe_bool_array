module app;

import vibe.d;

class SampleService {
	// "GET /"
	@path("/") void getHome() {
		render!("home.dt");
	}

	// POST /settings
	void postSettings(string[] x) {
	/*void postSettings(bool[] x) {*/
      foreach (i, v; x) {
         logInfo("x[%s]=%s", i, v);
      }
      redirect("./");
	}
}

shared static this() {
	auto router = new URLRouter;
	router.registerWebInterface(new SampleService);
	router.get("*", serveStaticFiles("public/"));

	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["::1", "127.0.0.1"];
   settings.accessLogToConsole = true;
	listenHTTP(settings, router);

	logInfo("Please open http://127.0.0.1:8080/ in your browser.");
}
