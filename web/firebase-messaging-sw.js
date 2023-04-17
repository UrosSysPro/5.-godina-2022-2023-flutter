importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyCnbN-thopCWaWMy3BvT7QJP-FnwoVp4v0",
  authDomain: "firesotretest-f953c.firebaseapp.com",
  databaseURL: "...",
  projectId: "firesotretest-f953c.firebaseapp.com",
  storageBucket: "firesotretest-f953c.appspot.com",
  messagingSenderId: "485958768252",
  appId: "firesotretest-f953c",
});

const messaging = firebase.messaging();
// console.log("loaded java script");

// console.log(firebase);
// // Optional:
// messaging.onBackgroundMessage((message) => {
//   console.log("onBackgroundMessage", message);
// });
