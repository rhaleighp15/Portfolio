'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "db727c5e8ae526aa7d5d8a2cff8745d6",
"assets/AssetManifest.bin.json": "477fd3f0fa073bef044a1dd536d3de6b",
"assets/assets/certs/ccna_intro_networks.png": "a611a681c3c4bd5703439367d3e7031a",
"assets/assets/certs/it_specialist_html_css.png": "d8330e05a983957fcda13ec680244665",
"assets/assets/certs/nextgenph_delegate.png": "58473b6f6cc5cacf4fd8f214503412a1",
"assets/assets/certs/unesco_hackathon_delegate.png": "46a5505dcd555a30696b9fd82f9c5efa",
"assets/assets/cv/paradero_cv.pdf": "3e22483c5ef22552f857212f9b1d6677",
"assets/assets/epass/epass_1.png": "963a819a81eda070fed33c5206af807b",
"assets/assets/epass/epass_2.png": "5f775d011715226f606fd546b66e780a",
"assets/assets/epass/epass_3.png": "d909dd62b1444c611e2f3f559adda606",
"assets/assets/epass/epass_4.png": "f5f308fbfd5cb52d71e9820bfcbee481",
"assets/assets/epass/epass_5.png": "38e7b8a5ee322e5017d01c39c21a1c30",
"assets/assets/epass/epass_6.png": "e72e62412c68e018be1cd3da705b9354",
"assets/assets/epass/epass_7.png": "57f9a81d3f94c1a2d1e5d0f85783d189",
"assets/assets/epass/epass_8.png": "8bdc26e9920f4a66a6ed1dc55d01b023",
"assets/assets/epass/epass_9.png": "359007e51c52f591925a9d34df10c8bb",
"assets/assets/matharlika/matharlika_1.png": "96f6673471204c22c721018091f3d5cb",
"assets/assets/matharlika/matharlika_10.png": "19b4650a6cf262f92169a28988628e81",
"assets/assets/matharlika/matharlika_11.png": "3827772ff4f1fa78f16704b00c8aa935",
"assets/assets/matharlika/matharlika_12.png": "3a3a4e751c6f5fe55ca4301479c6c30a",
"assets/assets/matharlika/matharlika_13.png": "4f59d2938afcd6c3529550890404500a",
"assets/assets/matharlika/matharlika_14.png": "f81e459318e6c2c6137904fb6b7cf14b",
"assets/assets/matharlika/matharlika_2.png": "bfd364cedcc6368732a52fbf1cbc98f8",
"assets/assets/matharlika/matharlika_3.png": "32d7a6b8986a0eb604dadba9ebf2f20f",
"assets/assets/matharlika/matharlika_4.png": "0942560ec79c80a09bbf6a420088d024",
"assets/assets/matharlika/matharlika_5.png": "b50b87bbc686c391f7348214cc8e820f",
"assets/assets/matharlika/matharlika_6.png": "b5e2a8d7ce8120c866eec366d0702bb5",
"assets/assets/matharlika/matharlika_7.png": "d4a751d9b6572edae3403a78bbd38d29",
"assets/assets/matharlika/matharlika_8.png": "48ae5ffa707e355a891b3a2b5fb44952",
"assets/assets/matharlika/matharlika_9.png": "1abb959a7e6e288fabf7f1020dcdd61d",
"assets/assets/ninjahands/1.png": "64a6b992500edb0dfe00382776a3ca5b",
"assets/assets/ninjahands/10.png": "fdb35e849dd784db43c7a264bc559dcc",
"assets/assets/ninjahands/11.png": "4f5ebb4bdc29e13a57e3072406b1dee0",
"assets/assets/ninjahands/12.png": "d79603737da71670e75390f2e813953f",
"assets/assets/ninjahands/13.png": "b83f750e7ca20e5999ec9f62aa33d3c0",
"assets/assets/ninjahands/2.png": "2a3e2694a79ff5edda53321c41aff852",
"assets/assets/ninjahands/3.png": "7558e467ab09f3899fe2853733134593",
"assets/assets/ninjahands/4.png": "7cfb5b2a576fb45466411c43cf7883fd",
"assets/assets/ninjahands/5.png": "208405f2c4d11ba02c50011cf8c07c99",
"assets/assets/ninjahands/6.png": "f05648ce4fbfdb418cab2b97f39e6c8c",
"assets/assets/ninjahands/7.png": "c20a992fa570b0b095cc1708639def89",
"assets/assets/ninjahands/8.png": "c32ab613b8159b5c8bcdbbf045af122f",
"assets/assets/ninjahands/9.png": "3674cbccd5b7e652ef50bd0a3eadba4f",
"assets/assets/pawcentral/pawcentral_1.png": "451c4d268f4d9bd04e1a163a757fde16",
"assets/assets/pawcentral/pawcentral_10.png": "8f6ae9e3e638aedbade057b3e7b51e05",
"assets/assets/pawcentral/pawcentral_11.png": "e25064b948dff474f9cef30f092d00cd",
"assets/assets/pawcentral/pawcentral_12.png": "bee878fb38f9f9f04e0fd08a8fc76f2f",
"assets/assets/pawcentral/pawcentral_13.png": "a7c452d1ba54b22b33e982a31f7e8cff",
"assets/assets/pawcentral/pawcentral_14.png": "42bd4c79f4e108de8f58352b8f66599f",
"assets/assets/pawcentral/pawcentral_15.png": "26b4ba506d75a621e879fa5f445deee6",
"assets/assets/pawcentral/pawcentral_16.png": "7a15a2286ecfd3de341981ab60f1847c",
"assets/assets/pawcentral/pawcentral_2.png": "a59344e53d59e45ba17c7daa5e1ce83f",
"assets/assets/pawcentral/pawcentral_3.png": "c6527d0694077bb4b5c4d1e5ef14f5b0",
"assets/assets/pawcentral/pawcentral_4.png": "227be80e773ffc6f33c93e94ec3fe9ec",
"assets/assets/pawcentral/pawcentral_5.png": "b56a6396fc4dce5fde641bbc41b12383",
"assets/assets/pawcentral/pawcentral_6.png": "b3cd192867f6ede23b08489c2c0c4a5f",
"assets/assets/pawcentral/pawcentral_7.png": "1323dc288c434739c8ae30a7491487ee",
"assets/assets/pawcentral/pawcentral_8.png": "d5d889db49b5c84d31f472173eb4d59f",
"assets/assets/pawcentral/pawcentral_9.png": "ab7a2c6eccb86ee34e995d6ecbbf2b1d",
"assets/assets/pizzame/pizzame_1.png": "56ac7546c7fea1e61be0e4870f5d3320",
"assets/assets/pizzame/pizzame_10.png": "fd2c8a89c77832bd810aa73dcbb7e650",
"assets/assets/pizzame/pizzame_11.png": "e7d638b0c19dfda7d23f77d45b87fb5e",
"assets/assets/pizzame/pizzame_2.png": "7cd74c3e45453886060e832206babfa0",
"assets/assets/pizzame/pizzame_3.png": "7b18afca2830f28ee763659f68a3bfd2",
"assets/assets/pizzame/pizzame_4.png": "eb134629e3d7f29e3fcaecd89085d307",
"assets/assets/pizzame/pizzame_5.png": "7d74785d118486a827d58310be743a82",
"assets/assets/pizzame/pizzame_6.png": "c26fbf84c0c463bab81a830d7c22d2dc",
"assets/assets/pizzame/pizzame_7.png": "2dd1333f7b5a5849c852f3bf9076532a",
"assets/assets/pizzame/pizzame_8.png": "054084d2784fcd17a68f2a6a76f4c8e9",
"assets/assets/pizzame/pizzame_9.png": "dbbce939324d2bbbe1ea3193b982ba51",
"assets/assets/profile/drawing.png": "06ade5cd1500806cfaa98015eaed04ff",
"assets/assets/profile/rhaleighp.png": "7ad0fec084e4645174df5cb0e5f684f1",
"assets/assets/pubmats/pubmat_1.png": "4644ae7e5fa949d5142fc24d6c7846ac",
"assets/assets/pubmats/pubmat_10.png": "bb30b1e7358e0f7c7c8ee6af98e4b448",
"assets/assets/pubmats/pubmat_11.png": "9fd73e6f21b58c8f97e4b6bf22ede584",
"assets/assets/pubmats/pubmat_12.png": "f2b5e401efc76bd295799b62dd774e51",
"assets/assets/pubmats/pubmat_2.png": "4f93de7e876f99dc2945610ad4e09733",
"assets/assets/pubmats/pubmat_3.png": "5df944faaa7325997179a6c095e56ff2",
"assets/assets/pubmats/pubmat_4.png": "bb3087bf9ff1772fa1f7ef301edb6dff",
"assets/assets/pubmats/pubmat_5.png": "0213de9f94ba769f1010788cd58c5ead",
"assets/assets/pubmats/pubmat_6.png": "ceb368c8a528ee674edc1f460e19dc2c",
"assets/assets/pubmats/pubmat_7.png": "7122ec0145f84894d622976b3ac6d8d0",
"assets/assets/pubmats/pubmat_8.png": "de18f4d4224161dbfc6dd51186b7962a",
"assets/assets/pubmats/pubmat_9.png": "4b42ed60357979056a23a5f05d8dc676",
"assets/assets/resforce/resforce_1.png": "c81c83fd78033282790be135e1748d9a",
"assets/assets/resforce/resforce_2.png": "50a727c7da645c15b0c3c75736bb2b70",
"assets/assets/resforce/resforce_3.png": "4be88e02e44ee9c52dc455a8bf4b06dd",
"assets/assets/resforce/resforce_4.png": "27777a064bdca09a0d7e3b8f5bcc26b3",
"assets/assets/resforce/resforce_5.png": "3d018ec8e22ce1c14ec5438192a73997",
"assets/assets/resforce/resforce_6.png": "2e709b42888e35e58796ad27aebeb601",
"assets/assets/resforce/resforce_7.png": "033016fdc25c61bd2a62698dcdef7231",
"assets/assets/resforce/resforce_8.png": "c3c1466ce1b60f883678a9b68e5b7954",
"assets/assets/stockup/stockup_1.png": "e6839635a8e97ce9370213d863f75b43",
"assets/assets/stockup/stockup_10.png": "0fa93bbafc1989c9bcd5fa910d5649c9",
"assets/assets/stockup/stockup_11.png": "940eb4cbe6459da004d46a56dbd7597c",
"assets/assets/stockup/stockup_12.png": "ba9ae8964de99d25aba7647b1b5b62bc",
"assets/assets/stockup/stockup_13.png": "1490f83cd1df1744fe3232e5b9fedfab",
"assets/assets/stockup/stockup_14.png": "7fc71487b9b9fb7a03b906d3b6e9b228",
"assets/assets/stockup/stockup_15.png": "4948f72c94fad52a31c228d1c8ad7bd3",
"assets/assets/stockup/stockup_16.png": "7820a11d3e45d9409b2b12e2bcbf961c",
"assets/assets/stockup/stockup_17.png": "7b4fbdf202458a03c4a162fcb230e4a0",
"assets/assets/stockup/stockup_18.png": "d83914b84d16f52ebd8ada9391022ec3",
"assets/assets/stockup/stockup_19.png": "3e10eceae5ec9c493fc8f48e85276769",
"assets/assets/stockup/stockup_2.png": "469d00d8d53ff6a9ce5cd2bd6f816100",
"assets/assets/stockup/stockup_3.png": "3d93bf51b3ee3c7df378f3f1ff4e0a78",
"assets/assets/stockup/stockup_4.png": "5dd68dcd670103e1e1c4fe2f51217e40",
"assets/assets/stockup/stockup_5.png": "5de283d29d695317d2208a0e28aead4e",
"assets/assets/stockup/stockup_6.png": "5105e57b5a0331821f747691398d021d",
"assets/assets/stockup/stockup_7.png": "31354d712ff7d1e6f8eba962848ef06e",
"assets/assets/stockup/stockup_8.png": "d05d2319ec951a8c9eb1b482ccea77b7",
"assets/assets/stockup/stockup_9.png": "edfe56d3280860f55a808880c7cb0706",
"assets/cv/paradero_cv.pdf": "3e22483c5ef22552f857212f9b1d6677",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "0c17877bc00ef20a525494e684400c56",
"assets/NOTICES": "79860d033c019419b6731ec3ac2110e3",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "e852e555d2b402d17f20ac729324eb41",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "44d8236458bd5ea98c36e5bf17b01263",
"/": "44d8236458bd5ea98c36e5bf17b01263",
"main.dart.js": "f35a2e528cfa3ac449e3298b0ec3f303",
"manifest.json": "b568e81ed2edef8c1ab77d058a004098",
"version.json": "2ad6aedf7b81abec9ee93965a71e77a0"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
  for (var resourceKey of Object.keys(RESOURCES)) {
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
