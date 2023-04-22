importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyCnbN-thopCWaWMy3BvT7QJP-FnwoVp4v0",
  authDomain: "firesotretest-f953c.firebaseapp.com",
  // databaseURL: "https://firesotretest-f953c-default-rtdb.firebaseio.com",
  databaseURL: "https://firesotretest-f953c-default-rtdb.europe-west1.firebasedatabase.app",
  projectId: "firesotretest-f953c",
  storageBucket: "firesotretest-f953c.appspot.com",
  messagingSenderId: "485958768252",
  appId: "1:485958768252:web:df96e556bb9d12ab695bf9"
});

const messaging = firebase.messaging();



console.log("loaded java script");

// console.log(firebase);
// // Optional:
// messaging.onBackgroundMessage((message) => {
//   console.log("onBackgroundMessage", message);
// });

// // Import the functions you need from the SDKs you need
// import { initializeApp } from "firebase/app";
// // TODO: Add SDKs for Firebase products that you want to use
// // https://firebase.google.com/docs/web/setup#available-libraries

// // Your web app's Firebase configuration
// const firebaseConfig = {
//   apiKey: "AIzaSyCnbN-thopCWaWMy3BvT7QJP-FnwoVp4v0",
//   authDomain: "firesotretest-f953c.firebaseapp.com",
//   databaseURL: "https://firesotretest-f953c-default-rtdb.europe-west1.firebasedatabase.app",
//   projectId: "firesotretest-f953c",
//   storageBucket: "firesotretest-f953c.appspot.com",
//   messagingSenderId: "485958768252",
//   appId: "1:485958768252:web:df96e556bb9d12ab695bf9"
// };

// // Initialize Firebase
// const app = initializeApp(firebaseConfig);
