// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyD14sshHitIKoHNrHmo9YA6w78b2BhOYP0",
  authDomain: "foodwise-32afa.firebaseapp.com",
  projectId: "foodwise-32afa",
  storageBucket: "foodwise-32afa.appspot.com",
  messagingSenderId: "184013061272",
  appId: "1:184013061272:web:5dd27476c316cf186fa4ed",
  measurementId: "G-ZDSVJZBX6W"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);