import {
    onDocumentUpdated,
    Change,
    FirestoreEvent
  } from "firebase-functions/v2/firestore";
  
  exports.updateuser = onDocumentUpdated("users/{userId}", (event) => {
      // Get an object representing the document
      // e.g. {'name': 'Marie', 'age': 66}
      const newValue = event.data.after.data();
  
      // access a particular field as you would any JS property
      const name = newValue.name;
  
      // perform more operations ...
  });