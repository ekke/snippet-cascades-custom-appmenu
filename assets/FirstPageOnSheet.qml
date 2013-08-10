import bb.cascades 1.0

/*
 * (C) 2013 ekke (Ekkehard Gentz, http://ekkes-corner.org)
 * License: Apache 2
 * 
 */

Page {
    id: myPageOnSheet
    titleBar: TitleBar {
        id: titleBar
        title: qsTr("Sheet with Appmenu")
        visibility: ChromeVisibility.Default
    }
    keyListeners: [
        // only to demonstrate what to do if using KeyListeners
        KeyListener {
            onKeyReleased: {
                if (navigationPane.appMenuActive) {
                    // we have to check here because enabled is ignored
                    return
                }
                if (event.keycap == 113) { // 'q'
                    closeAction.triggered()
                }
            }
        }
    ]
    actions: [
        ActionItem {
            id: closeAction
            title: "close"
            imageSource: "asset:///images/home.png"
            enabled: ! navigationPane.appMenuActive
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                navigationPane.close()
            }
            // demonstrates use of shortcuts
            shortcuts: [
                // we don't need an extra check or enable shortcut - inherits from Actionitem
                Shortcut {
                    key: 'c'
                }
            ]
        },
        ActionItem {
            title: "two"
            imageSource: "asset:///images/two.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                navigationPane.pushPageTwo()
            }
        }
    ]
    Container {
        id: outerContainer
        preferredWidth: Infinity
        // here to inject the AppMenuContainer
        Container {
            id: contentContainer
            preferredWidth: Infinity
            property int currentHeight
            enabled: ! navigationPane.appMenuActive
            background: navigationPane.appMenuActive && ! navigationPane.isDark() ? navigationPane.appMenuActiveColor : Color.Transparent
            opacity: navigationPane.appMenuActive && navigationPane.isDark() ? 0.2 : 1
            // need this LayoutUpdateHandler and TapHandler
            attachedObjects: [
                LayoutUpdateHandler {
                    onLayoutFrameChanged: {
                        if (! navigationPane.appMenuActive) {
                            console.debug("current Height: " + contentContainer.currentHeight)
                            contentContainer.currentHeight = layoutFrame.height
                        }
                    }
                }
            ]
            gestureHandlers: [
                TapHandler {
                    id: appMenuTapHandler
                    onTapped: {
                        if (navigationPane.appMenuActive) {
                            navigationPane.closeAppMenu()
                        }
                    }
                }
            ]
            // now normal content
            Label {
                text: "This is content from FIRST Page\nNavPane on Sheet\nAppMenu Support:)\n(Swipe Down)"
                multiline: true
                textStyle.fontSize: FontSize.XXLarge
            }
            Label {
                text: "something more..."
            }
        } // end contentContainer
    } // end outer container
    function enableAppMenu() {
        console.debug("enable app menu on ONE")
        outerContainer.insert(0, navigationPane.appMenuContainer)
        titleBar.visibility = ChromeVisibility.Hidden
        actionBarVisibility = ChromeVisibility.Hidden
        contentContainer.preferredHeight = Infinity
    }
    function disableAppMenu() {
        console.debug("disable app menu on ONE")
        titleBar.visibility = ChromeVisibility.Default
        actionBarVisibility = ChromeVisibility.Default
        contentContainer.preferredHeight = contentContainer.currentHeight
        outerContainer.remove(navigationPane.appMenuContainer)
        // remove doesnt delete, destroy() doesnt work, setParent() doesnt work
        // so let C++ do this 
        // http://supportforums.blackberry.com/t5/Cascades-Development/what-happen-to-the-control-removed-from-the-container-it-will-be/m-p/2484101#M27503
        app.deleteObject(navigationPane.appMenuContainer)
    }
    onCreationCompleted: {
        //
    }
}// end myPageOnSheet
