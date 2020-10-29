'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "5cc4979846cb386178db27973d68a005",
"assets/assets/analytics.png": "348ee1f2abb7cf1d5afef53b5c73f45b",
"assets/assets/avatar.png": "c88fe824a1c0e5a86f19025f755160b4",
"assets/assets/aws.png": "52a4c75125b19ab8c9121958146134a6",
"assets/assets/firebase.png": "0e4792f1b38576bce30728eec593a301",
"assets/assets/flutter.png": "bc20ac3c833cdfbb9230c8a0dc483d46",
"assets/assets/FontManifest.json": "59c37979205b4b43589051e92e27cbcd",
"assets/assets/gcp.png": "b76e3a5e9cd9d2c30164ff9a87d9f8c2",
"assets/assets/github.png": "d22ee3727a7216019c3848df6eafa024",
"assets/assets/gitlab.png": "d8dd9f3a3a1275356f9e1428b144e99f",
"assets/assets/gmail.png": "abcb39546755ed70e74e6cf1c0c5b68e",
"assets/assets/GoogleSansRegular.ttf": "b5c77a6aed75cdad9489effd0d5ea411",
"assets/assets/instagram.png": "26631a4043b14dff84180bdf51c3cacb",
"assets/assets/linkedin.png": "926e2dcf5ab4220a359867614556df68",
"assets/assets/mongodb.png": "2d2b10838ac9b36f3c81949000a7649d",
"assets/assets/moon.png": "a270b8a10d1a9a52441bf5a322dd1b86",
"assets/assets/nodejs.png": "350ea377dddd525f530aa988675b82a5",
"assets/assets/twitter.png": "8f35a40403a84631c4125c4f1859c7a6",
"assets/assets/works/elleys.png": "b8ed04c8bd6863753394e42682e45131",
"assets/assets/works/flutter96.png": "aff1fb8ba9ba16a0260d71c72b1417aa",
"assets/assets/works/gw.png": "ebbd9b43c748d076047f9d4c0c6b5300",
"assets/assets/works/l2c.png": "901ced34577e145293aa3092e62a8946",
"assets/assets/works/rrk.png": "c314dda1d1802ac87b6d4ebb024692c5",
"assets/assets/works/stargate.png": "19e69013d75031213c814d5f56270050",
"assets/assets/works/trivon.png": "da32911ea0962da2a666aed11476f9ec",
"assets/assets/works/unigo.png": "57cf8dd8195de22b012ec7073a986ef2",
"assets/assets/works/unigo_admin.png": "2ec6916e41f411f7b9d2513d318c3024",
"assets/assets/works/unigo_driver.png": "e68ee584009d72c8507e122486e2db41",
"assets/FontManifest.json": "8f036bb4279e4857a966e259b818f8ae",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/NOTICES": "691a301d842caa5835ca4a9f11012e0d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b14fcf3ee94e3ace300b192e9e7c8c5d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "b31c7dd96ee74332742a376acf13eddb",
"/": "b31c7dd96ee74332742a376acf13eddb",
"main.dart.js": "78da9eac93c4720b1bce686fcff0b6ee",
"manifest.json": "a83bbbd9d23ea4d752fbcd44cdc544fa",
"version.json": "426313f2f3133c2f20415344c4a22df3"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
