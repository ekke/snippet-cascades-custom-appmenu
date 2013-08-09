import bb.cascades 1.0

/*
 * (C) 2013 ekke (Ekkehard Gentz, http://ekkes-corner.org)
 * License: Apache 2
 * 
 */

Page {
    id: thirdPage
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
            attachedObjects: [
                LayoutUpdateHandler {
                    onLayoutFrameChanged: {
                        if (! navigationPane.appMenuActive && layoutFrame.height > 0) {
                            console.debug("current Height: " + contentContainer.currentHeight)
                            contentContainer.currentHeight = layoutFrame.height
                        }
                    }
                }
            ]
            Label {
                text: "content in navpane\nP A G E 3\non top of sheet"
                multiline: true
                textStyle.fontSize: FontSize.XXLarge
            }
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
        } // end content Container
    } // end outer container
    function enableAppMenu() {
        navigationPane.peekEnabled = false
        outerContainer.insert(0, navigationPane.appMenuContainer)
        //        titleBar.visibility = ChromeVisibility.Hidden
        actionBarVisibility = ChromeVisibility.Hidden
        contentContainer.preferredHeight = Infinity
    }
    function disableAppMenu() {
        //        titleBar.visibility = ChromeVisibility.Default
        actionBarVisibility = ChromeVisibility.Default
        contentContainer.preferredHeight = contentContainer.currentHeight
        outerContainer.remove(navigationPane.appMenuContainer)
        // remove doesnt delete, destroy() doesnt work, setParent() doesnt work
        // so let C++ do this 
        // http://supportforums.blackberry.com/t5/Cascades-Development/what-happen-to-the-control-removed-from-the-container-it-will-be/m-p/2484101#M27503
        app.deleteObject(navigationPane.appMenuContainer)
        navigationPane.peekEnabled = true
    }
    onCreationCompleted: {
        //
    }
} // end third page
