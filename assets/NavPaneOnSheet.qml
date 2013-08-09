import bb.cascades 1.0

/*
 * (C) 2013 ekke (Ekkehard Gentz, http://ekkes-corner.org)
 * License: Apache 2
 * 
 */

NavigationPane {
    signal close
    property AppMenuContainer appMenuContainer
    property bool appMenuActive: false
    property variant appMenuActiveColor: Color.create("#ff7f7f7f")
    property Page2 secondPage
    property Page3 thirdPage
    id: navigationPane
    attachedObjects: [
        ComponentDefinition {
            id: appMenuContainerComponent
            // on top of a Sheet Appmenu doesn't work
            // so we use a custom AppMenu
            AppMenuContainer {
                visible: appMenuActive
                helpVisible: true
                settingsVisible: true
                action1Visible: true
                action1ImageSource: "asset:///images/faq.png"
                action1LabelText: qsTr("FAQ")
            }
        },
        ComponentDefinition {
            id: secondPageComponent
            Page2 {
            }
        },
        ComponentDefinition {
            id: thirdPageComponent
            Page3 {
            }
        },
        ComponentDefinition {
            id: helpPageComponent
            HelpPage {
            }
        },
        ComponentDefinition {
            id: settingsPageComponent
            SettingsPage {
            }
        },
        ComponentDefinition {
            id: faqPageComponent
            FaqPage {
            }
        }
    ]
    // if you want to use shortcuts:
    // only enabled if AppMenu is swiped down
    shortcuts: [
        Shortcut {
            enabled: navigationPane.appMenuActive
            key: 'h'
            onTriggered: {
                navigationPane.onHelpMenu()
            }
        }
    ]
    // if you support external keyboards
    // and want to use KeyListeners,
    // here's HowTo do this
    keyListeners: [
        KeyListener {
            id: appMenuKeyListener
            onKeyReleased: {
                if (navigationPane.appMenuActive) {
                    if (event.keycap == 115) { // 's'
                        navigationPane.onSettingsMenu()
                        return
                    }
                } else {
                    if (event.key == 27) { // ESC to go BACK
                        if(navigationPane.top != navigationPane.firstPage){
                            navigationPane.pop()
                        }
                        return
                    }
                }
                if (event.key == 199) { // F10 on Bluetooth to simulate swipe down
                    navigationPane.onSwipeDown()
                    return
                }
            }
        }
    ]
    // FIRST PAGE
    FirstPageOnSheet {
        id: myPageOnSheet
    }
    // NAV PANE FUNCTIONS
    onPopTransitionEnded: {
        if (page == secondPage) {
            secondPage.destroy()
            return
        }
        if (page == thirdPage) {
            thirdPage.destroy()
            return
        }
        // nothing special with the pages pushed from App menu
        page.destroy()
    }
    function pushPageTwo() {
        secondPage = secondPageComponent.createObject(navigationPane)
        push(secondPage)
    }
    function pushPageThree() {
        if (thirdPage) {
            console.debug("UUUUH 3 is there")
        }
        thirdPage = thirdPageComponent.createObject(navigationPane)
        push(thirdPage)
    }
    // A  P  P    M  E  N  U
    // ACTIONS
    function onHelpMenu() {
        console.debug("HELP")
        closeAppMenu()
        // do the HELP
        push(helpPageComponent.createObject(navigationPane))
    }
    function onSettingsMenu() {
        console.debug("SETTINGS")
        closeAppMenu()
        // do the Settings
        push(settingsPageComponent.createObject(navigationPane))
    }
    function onFaqMenu() {
        console.debug("FAQ")
        closeAppMenu()
        // do the FAQ
        push(faqPageComponent.createObject(navigationPane))
    }
    // connection delayed - not in onCreation
    // maybe never used
    function connectAppMenu() {
        appMenuContainer.helpMenu.connect(onHelpMenu)
        appMenuContainer.settingsMenu.connect(onSettingsMenu)
        appMenuContainer.action1Menu.connect(onFaqMenu)
    }
    function disconnectAppmenu() {
        appMenuContainer.helpMenu.disconnect(onHelpMenu)
        appMenuContainer.settingsMenu.disconnect(onSettingsMenu)
        appMenuContainer.action1Menu.disconnect(onFaqMenu)
    }
    // CLOSE APP MENU
    function resetAppMenuParent() {
        navigationPane.attachedObjects.length
    }
    function closeAppMenu() {
        appMenuActive = false
        disconnectAppmenu()
        if (navigationPane.top == myPageOnSheet) {
            myPageOnSheet.disableAppMenu()
            return
        }
        if (navigationPane.top == secondPage) {
            secondPage.disableAppMenu()
            return
        }
        if (navigationPane.top == thirdPage) {
            thirdPage.disableAppMenu()
            return
        }
    }
    // OPEN APP MENU
    function onSwipeDown() {
        console.debug("S W I P E   DOWN")
        if (navigationPane.top == myPageOnSheet) {
            console.debug("Page ONE")
            if (! appMenuActive) {
                appMenuActive = true
                appMenuContainer = appMenuContainerComponent.createObject()
                connectAppMenu()
                myPageOnSheet.enableAppMenu()
            } else {
                closeAppMenu()
            }
            return
        }
        if (navigationPane.top == secondPage) {
            if (! appMenuActive) {
                appMenuActive = true
                appMenuContainer = appMenuContainerComponent.createObject()
                connectAppMenu()
                secondPage.enableAppMenu()
            } else {
                closeAppMenu()
            }
            return
        }
        if (navigationPane.top == thirdPage) {
            if (! appMenuActive) {
                appMenuActive = true
                appMenuContainer = appMenuContainerComponent.createObject()
                connectAppMenu()
                thirdPage.enableAppMenu()
            } else {
                closeAppMenu()
            }
            return
        }
    }
    // different behaviour of app menu for Dark vs Bright
    function isDark() {
        return Application.themeSupport.theme.colorTheme.style == VisualStyle.Dark
    }
    // some cleanup
    function cleanup() {
        console.debug("clean up navpane on sheet")
        Application.swipeDown.disconnect(onSwipeDown)
    }
    onCreationCompleted: {
        // we want to know when user swipes down to open Appmenu
        Application.swipeDown.connect(onSwipeDown)
    }
}// end navigationPane (on top of Sheet)
