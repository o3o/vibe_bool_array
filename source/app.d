module app;

import vibe.d;

struct Data {
   string name;
   int age;
}
struct Doc {
   string name;
   int size;
   bool ro;
}
struct Dir {
   string name;
   Doc[] docs;
}


class SampleService {
   // get /settings
   void getSettings() {
      logInfo("GET SET");
      import std.string;
      string[] x;
      foreach (i; 0 .. 3) {
         x ~= "%s".format(i);
      }
      render!("settings.dt", x);
   }

   // POST /settings
   void postSettings(string[] x) {
      logInfo("POST SET %s", x);
      foreach (i, v; x) {
         logInfo("x[%s]=%s", i, v);
      }
      redirect("./settings");
   }
// get /conf
   void getConf() {
      logInfo("GET conf");
      import std.string;
      Data conf0 = Data("o", 53);
      Data conf1 = Data("r", 13);
      Data[] conf = [conf0, conf1];

      render!("conf.dt", conf);
   }

   // POST /conf
   void postConf(Data[] conf) {
      logInfo("POST conf %s", conf);
      redirect("./conf");
   }

   // get /dir
   void getDir() {
      logInfo("GET dir");
      import std.string;
      Dir dir = Dir("prova");
      dir.docs ~= Doc("aa", 16, true);
      dir.docs ~= Doc("bb", 32, false);
      render!("dir.dt", dir);
   }

   // POST /dir
   void postDir(Dir dir) {
      logInfo("POST dir %s", dir);
      redirect("./dir");
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
