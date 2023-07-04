import {
    onDocumentUpdated,
    Change,
    FirestoreEvent
  } from "firebase-functions/v2/firestore";

  import * as admin from 'firebase-admin';
  import * as functions from 'firebase-functions';

  export const WriteToFirestore = functions.firestore
     .document('encontristas')
     .onWrite((change, context) => {
       admin.firestore().collection('niver').doc('some').set(change);
     });


  exports.updateuser = onDocumentUpdated("users/{userId}", (event) => {
      // Get an object representing the document
      // e.g. {'name': 'Marie', 'age': 66}
      const newValue = event.data.after.data();
  
      // access a particular field as you would any JS property
      const name = newValue.name;
  
      // perform more operations ...
  });


//   const admin = require('firebase-admin');
// admin.initializeApp();

// const db = admin.firestore();

// exports.writeToFirestore = functions.firestore
//   .document('some/doc')
//   .onWrite((change, context) => {
//     db.doc('some/otherdoc').set({ ... });
//   });