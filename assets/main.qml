import bb.cascades 1.0

/*
 * (C) 2013 ekke (Ekkehard Gentz, http://ekkes-corner.org)
 * License: Apache 2
 * 
 * This snippet-like application demonstrates
 * HowTo create your own custom ApplicationMenu
 * 
 * I tried to create an AppMenu looking similar 
 * to the built-in app menu. there are only two smal
 * cosmetic things different:
 * a) swipe-up doesn't close the Appmenu
 * b) on Pages with TitleBar I hide the TitleBar while shoing the Appmenu
 * 
 * Touch and Keyboaurd Devices are supported
 * Dark and Bright Themes are supported
 * 
 * Why should you do this ?
 * Jere are three scenarios:
 * 
 * 1. If using a NavigationPane on top of a Sheet,
 * the built-in AppMenu doesn't work,
 * so you have to use a custom AppMenu
 * 
 * 2. If using an external keyboard and you want to use
 * KeyListeners for Swipe-Down,
 * the built-in AppMenu won't work
 * 
 * 3. If you want some other controls then only ActionItems
 * inside your Appmenu, you have to build a custom appMenu
 * Warning: this can break the BB10 UI Design Guidelines
 * 
 * have fun !
 * 
 * ekke
 * BlackBerry Elite
 * 
 */

// This NavigationPane simulates a 'normal' application
// But there's a situation wher you Open a Sheet
// and on top of this Sheet you want to use an AppMenu
NavigationPane {
    id: root
    // classic Appmenu used in normal application
    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {
            onTriggered: {
                // we have to disable the built-in Menu to avoid swipe-down from Appmenu Actions
                Application.setMenuEnabled(false)
                root.push(helpPageComponent.createObject(root))
            }
        }
    }
    attachedObjects: [
        // sheet is small: only some logic and component definition of NavPane
        // so we dont use a ComponentDefinition here
        SheetWithNavPane {
            id: mySheet
        },
        ComponentDefinition {
            id: helpPageComponent
            HelpPage {
            }
        }
    ]
    Page {
        id: myPageOnRoot
        actions: [
            ActionItem {
                title: qsTr("Open Sheet")
                imageSource: "asset:///images/go.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    mySheet.open()
                }
            }
        ]
        Container {
            Label {
                text: qsTr("only a placeholder\nsimulates a complete application") + Retranslate.onLocaleOrLanguageChanged
                multiline: true 
                textStyle.base: SystemDefaults.TextStyles.BigText
            }
        }
    }
    onPopTransitionEnded: {
        // the only pushed Page in this sample is a Page pushed from AppMenu
        // so if coming back, we re-enable the built-in AppMenu
        Application.setMenuEnabled(true)
        page.destroy()
    }
    onCreationCompleted: {
        //
    }
}
