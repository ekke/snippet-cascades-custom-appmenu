import bb.cascades 1.0

/*
 * (C) 2013 ekke (Ekkehard Gentz, http://ekkes-corner.org)
 * License: Apache 2
 * 
 */
Container {
    // signal if an action from app menu was tapped on
    signal helpMenu
    signal settingsMenu
    signal action1Menu
    signal action2Menu
    signal action3Menu
    id: appMenuContainer
    // configure app menu
    property bool helpVisible: false
    property bool settingsVisible: false
    property bool action1Visible: false
    property bool action2Visible: false
    property bool action3Visible: false
    // images and label text of help and settings are fixed
    // same as in origin app menu
    property alias action1LabelText: action1Label.text
    property alias action1ImageSource: action1Image.defaultImageSource
    property alias action2LabelText: action2Label.text
    property alias action2ImageSource: action2Image.defaultImageSource
    property alias action3LabelText: action3Label.text
    property alias action3ImageSource: action3Image.defaultImageSource
    // always black
    background: Color.Black
    preferredWidth: Infinity
    topPadding: 20
    bottomPadding: 10
    // the most important property
    // used to detect if appMenu is in use
    visible: false
    layout: StackLayout {
        orientation: LayoutOrientation.LeftToRight
    }
    // all 5 Containers are needed: each with spacequota 1
    // to have the space reserved, even if some Actions aren't used
    //
    // each action reacts on clicking on the ImageButton
    // or tapping outside the image somewhere on the container
    Container {
        id: helpAction
        enabled: helpVisible
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        layoutProperties: StackLayoutProperties {
            spaceQuota: 1
        }
        gestureHandlers: [
            TapHandler {
                onTapped: {
                    helpMenu()
                }
            }
        ]
        ImageButton {
            visible: helpVisible
            defaultImageSource: "asset:///images/help.png"
            bottomMargin: 0
            minHeight: 81
            maxHeight: 81
            minWidth: 81
            maxWidth: 81
            horizontalAlignment: HorizontalAlignment.Center
            onClicked: {
                helpMenu()
            }
        }
        Label {
            text: qsTr("Help")
            visible: helpVisible
            textStyle.fontSize: FontSize.XXSmall
            textStyle.color: Color.White
            topMargin: 0
            horizontalAlignment: HorizontalAlignment.Center
        }
    } // end helpAction
    Container {
        id: action1
        enabled: action1Visible
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        layoutProperties: StackLayoutProperties {
            spaceQuota: 1
        }
        gestureHandlers: [
            TapHandler {
                onTapped: {
                    action1Menu()
                }
            }
        ]
        ImageButton {
            id: action1Image
            visible: action1Visible
            defaultImageSource: "asset:///images/settings.png"
            bottomMargin: 0
            minHeight: 81
            maxHeight: 81
            minWidth: 81
            maxWidth: 81
            horizontalAlignment: HorizontalAlignment.Center
            onClicked: {
                action1Menu()
            }
        }
        Label {
            id: action1Label
            visible: action1Visible
            text: "Action1"
            textStyle.fontSize: FontSize.XXSmall
            textStyle.color: Color.White
            topMargin: 0
            horizontalAlignment: HorizontalAlignment.Center
        }
    } // end action1
    Container {
        id: action2
        enabled: action2Visible
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        layoutProperties: StackLayoutProperties {
            spaceQuota: 1
        }
        gestureHandlers: [
            TapHandler {
                onTapped: {
                    action2Menu()
                }
            }
        ]
        ImageButton {
            id: action2Image
            visible: action2Visible
            defaultImageSource: "asset:///images/settings.png"
            bottomMargin: 0
            minHeight: 81
            maxHeight: 81
            minWidth: 81
            maxWidth: 81
            horizontalAlignment: HorizontalAlignment.Center
            onClicked: {
                action2Menu()
            }
        }
        Label {
            id: action2Label
            visible: action2Visible
            text: "Action2"
            textStyle.fontSize: FontSize.XXSmall
            textStyle.color: Color.White
            topMargin: 0
            horizontalAlignment: HorizontalAlignment.Center
        }
    } // end action2
    Container {
        id: action3
        enabled: action3Visible
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        layoutProperties: StackLayoutProperties {
            spaceQuota: 1
        }
        gestureHandlers: [
            TapHandler {
                onTapped: {
                    action3Menu()
                }
            }
        ]
        ImageButton {
            id: action3Image
            visible: action3Visible
            defaultImageSource: "asset:///images/settings.png"
            bottomMargin: 0
            minHeight: 81
            maxHeight: 81
            minWidth: 81
            maxWidth: 81
            horizontalAlignment: HorizontalAlignment.Center
            onClicked: {
                action3Menu()
            }
        }
        Label {
            id: action3Label
            visible: action3Visible
            text: "Action3"
            textStyle.fontSize: FontSize.XXSmall
            textStyle.color: Color.White
            topMargin: 0
            horizontalAlignment: HorizontalAlignment.Center
        }
    }    // end action1
    Container {
        id: settingsAction
        enabled: settingsVisible
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        layoutProperties: StackLayoutProperties {
            spaceQuota: 1
        }
        gestureHandlers: [
            TapHandler {
                onTapped: {
                    settingsMenu()
                }
            }
        ]
        ImageButton {
            visible: settingsVisible
            defaultImageSource: "asset:///images/settings.png"
            bottomMargin: 0
            minHeight: 81
            maxHeight: 81
            minWidth: 81
            maxWidth: 81
            horizontalAlignment: HorizontalAlignment.Center
            onClicked: {
                settingsMenu()
            }
        }
        Label {
            visible: settingsVisible
            text: qsTr("Settings")
            textStyle.fontSize: FontSize.XXSmall
            textStyle.color: Color.White
            topMargin: 0
            horizontalAlignment: HorizontalAlignment.Center
        }
    } // end settingsAction

}
