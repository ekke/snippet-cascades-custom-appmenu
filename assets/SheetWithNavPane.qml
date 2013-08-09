import bb.cascades 1.0

/*
 * (C) 2013 ekke (Ekkehard Gentz, http://ekkes-corner.org)
 * License: Apache 2
 * 
 */

Sheet {
    id: mySheet
    onOpened: {
        content = navigationPaneComponent.createObject(mySheet)
    } 
    onClosed: {
        // do some disconnect etc
        navigationPane.cleanup()
        content.deleteLater()
      }
    content: {
    }
    attachedObjects: [
        ComponentDefinition {
            id: navigationPaneComponent
            NavPaneOnSheet {
                id: navigationPane
                onClose: {
                    mySheet.close()
                }
            }
        }
    ]
    
} // end sheet
