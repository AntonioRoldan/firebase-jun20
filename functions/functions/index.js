const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.helloWorld = functions.https.onRequest((request, response) => {
    response.send("Hello from Firebase Keepcoders!");
});


exports.newMessage = functions.database.ref('/messages/{discussionId}/{messageId}').onWrite((event, context) => {

    const discussionId = context.params.discussionId;
    const messageId = context.params.messageId;

    const message = event.after.val();

    if(!message){
        return;
    }

    var value = message.type == "image" ? "It's an image!" : message.value;

    const payload = {
        notification: {
            title: message.displayName,
            body: message.value
        }
    }

    const sendMessagePromise = admin.messaging().sendToTopic("ALL", payload);

    const setNewMessagePromise = admin.database().ref(`/discussion/${discussionId}/lastMessage`).set(value);

    return Promise.all([sendMessagePromise,setNewMessagePromise])

});
