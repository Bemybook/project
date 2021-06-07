# project2
Technologies used were:-
->Ionic Platform(To run web application)
->Angular.js
->Cordova
->Node.js
->Visual Studio Code

METHODOLOGY

![image](https://user-images.githubusercontent.com/83057352/120181426-ac4bdd00-c22a-11eb-8404-c280682c8777.png)



Methodology used were:-
SCREEN 1: Our app name and introduction is given.
SCREEN 2: Login page. At present we had given only login for 4 users ( Amogha, srikala, swati and sakshi). Later we will be creating a Register system through Firebase Connection.
SCREEN 3 : After Login we have Finger authentication which we will be doing late

SCREEN 4: Folder page is displayed. Here we gave 2 options. Either to upload image from library or use take to take image.
SCREEN5: Text is extracted from image within seconds using Google OCR and speech is produced using Google Text to Speech API.
We had made use of GOOGLE SPEECH RECOGNITION MODULE to take voice input from the user.
As we had mentioned in the previous update that we will be working on the look and feel of the app, so we have designed the front end part of the application.

Below are few snapshots on  how the front end part of the application will look like:-

Screen 1: INTRODUCTION OF THE APP AND GOOGLE SPEECH IS ASKING USER TO TELL THE NAME
![image](https://user-images.githubusercontent.com/83057352/120181479-bff74380-c22a-11eb-921c-f6f193d69cb7.png)

Screen 2 :FOLDER SCREEN AND APP GIVING OPTION UPLOAD IMAGE FROM LIBRARY OR TAKE A PICTURE
![image](https://user-images.githubusercontent.com/83057352/120181496-c5548e00-c22a-11eb-996a-8d62d35445bc.png)

Screen 3:LOAD IMAGE FROM LIBRARY
![image](https://user-images.githubusercontent.com/83057352/120181629-f7fe8680-c22a-11eb-9e6d-e4a329592b23.png)

Screen 4 :EXTRACTED TEXT AND OUTPUTS THE VOICE 
![image](https://user-images.githubusercontent.com/83057352/120181690-0a78c000-c22b-11eb-9e04-46be727908b3.png)


_________________________________________________________________________________________________________________________________________________________________________________

so in this update whenever a new screen is displayed a small description of that particular screen is added.

we have used cordova **speech recognition plugin** to implement **Open<BOOK NAME>** command.

The Speech Recognition plugin provides many methods here:
->isRecognizeAvailable(): Checks whether a speech recognition service is available on the system.  Result of success call back is a Boolean.
->startListening(): Identifies and analyses the voice input given by the user. Result of success call back is an Array of recognized terms.
->stopListening(): Stop the recognition process. No return value.

-> We created a folder screen which contains all the book folder where in that folder images are saved as , for example : 1.jpeg , 2.jpeg.

Fig 1: Folder Screen
![image](https://user-images.githubusercontent.com/83057352/120987106-e40ed380-c79a-11eb-8c96-4acdaeac566d.png)
In the above screen, we included the one dummy folder at present.

We have at present given only one image in folder.
So after we give OPEN BOOK command , our folder is opened and 1 image in it will start to read and that page which is to read is displayed on the screen.

Fig 2: Image which is read
![image](https://user-images.githubusercontent.com/83057352/120987238-099bdd00-c79b-11eb-944c-52be14d000c6.png)

Fig 3: We have directed inserted image in base64 format.
![image](https://user-images.githubusercontent.com/83057352/120987353-22a48e00-c79b-11eb-8bd0-0dd0d9b14176.png)


We have used dap option instead of start and stop command . Later this dap option is used to invoke the bot.
Fig 4: To display the image
![image](https://user-images.githubusercontent.com/83057352/120987432-35b75e00-c79b-11eb-931c-9d47e2e32acb.png)

Fig 5: Code which shows Dab option is implemented. 
![image](https://user-images.githubusercontent.com/83057352/120987512-48319780-c79b-11eb-8b76-4a3808994533.png)









