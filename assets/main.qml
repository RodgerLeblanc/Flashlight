/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.2

// Need to import the next line as Camera rely on bb/cascades/multimedia
// You can see this in this doc : https://developer.blackberry.com/native/reference/cascades/bb__cascades__multimedia__camera.html
import bb.cascades.multimedia 1.2

Page {
    Container {
        // I set the layout to DockLayout to be able to center the button in the screen
        // You don't need to focus on this right now, you'll learn the difference between
        // different layouts later on.
        layout: DockLayout {}
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        
        Container {
            // I set the visible value to false so that we don't see the camera
            // You can try to set it to true if you want to see what will happen
            visible: false            
            
            // This is the Camera object. The flashlight rely on the camera, so you
            // need to start the camera to be able to use the flashlight.
            // In fact, we're setting the camera in video mode with flash enabled.
            Camera {
                // Name of the camera object
                id: myCamera
                
                // When the app is started, open the camera
                onCreationCompleted: {
                    myCamera.open()
                }
                
                // When the camera is opened, specify the shooting mode, flash mode and start 
                // the viewfinder
                onCameraOpened: {
                    cameraSettings.cameraMode = CameraMode.Video //sets camera mode to video
                    cameraSettings.flashMode = CameraFlashMode.Off
                    myCamera.applySettings(cameraSettings)
                    myCamera.startViewfinder()
                }     
                
                // This is where the cameraSettings are stored, we need to attach
                // it to the camera object
                attachedObjects: [
                    CameraSettings {
                        // Name of the cameraSettings to access it
                        id: cameraSettings
                    }
                ]
            }
        }
        
        Button {
            // Centering the button
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            
            // Text shown in the button
            text: "Flashlight ON/OFF"
            
            /* 
             * This is what happens when the button is clicked:
             * - Retrieve the previous cameraSettings
             * - Change the flash mode
             * - Apply new cameraSettings
             */
            onClicked: {
                myCamera.getSettings(cameraSettings)
                if (cameraSettings.flashMode == CameraFlashMode.Light)
                    cameraSettings.flashMode = CameraFlashMode.Off
                else 
                    cameraSettings.flashMode = CameraFlashMode.Light //sets flash mode to light
                myCamera.applySettings(cameraSettings)
            }
        }
    }
}
