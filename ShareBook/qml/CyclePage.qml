import QtQuick 2.0
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id:cyclePage
    anchors.fill: parent
    readonly property int rootWidth: cyclePage.width
    readonly property int rootHeight: cyclePage.height
//    RowLayout{
//        id:otherButtonRow
//        anchors.top: parent.top
//        anchors.topMargin:  rootWidth*0.01
////                topPadding:rootWidth*0.02
////                leftPadding : rootWidth*0.02

//        Button {
//            id: otherSelect_button
//            Layout.leftMargin: rootWidth*0.02
//            background: Rectangle{
//                color: "white"
//                opacity: 0.7
//            }

//            Image {
//                fillMode: Image.PreserveAspectFit
//                sourceSize: Qt.size(30, 30)
//                source:"qrc:/images/images/myotherselect.png"
//            }
//            onClicked: {
//            }
//        }

//        Item{
//            width:rootWidth*0.8
//            height:rootWidth*0.1
//        }

//        Button {
//            id: share_button
//            background: Rectangle{
//                color: "white"
//                opacity: 0.7
//            }

//            Image {
//                fillMode: Image.PreserveAspectFit
//                sourceSize: Qt.size(30, 30)
//                source:"qrc:/images/images/transit.png"
//            }
//            onClicked: {
//            }
//        }
//    }

//    SwipeView {
//        id: swipeView
//        anchors.fill: parent
//        horizontal: true
//        currentIndex: 0
//        Page {
//            Label {
//               text: qsTr("First page")
//               anchors.centerIn: parent
//            }
//        }
//        Page {
//            Label {
//               text: qsTr("Second page")
//               anchors.centerIn: parent
//            }
//        }
//        Page {
//            Label {
//               text: qsTr("Third page")
//               anchors.centerIn: parent
//            }
//        }
//        Page {
//            Label {
//               text: qsTr("Fourth page")
//               anchors.centerIn: parent
//            }
//        }
//        Page {
//            Label {
//               text: qsTr("Fifth page")
//               anchors.centerIn: parent
//            }
//        }
//    }

//       Rectangle{
//           id:minus
//           width:parent.width/2
//           height:100
//           anchors.left:parent.left
//           anchors.bottom:parent.bottom
//           color:"red"
//           MouseArea
//           {
//               anchors.fill:parent
//               onClicked:{
//                   if(swipeView.currentIndex>0)
//                       swipeView.currentIndex--
//               }
//           }
//       }
//       Rectangle{
//           id:plus
//           width:parent.width/2
//           height:100
//           anchors.right:parent.right
//           anchors.bottom:parent.bottom
//           color:"green"
//           MouseArea
//           {
//               anchors.fill:parent
//               onClicked:{
//                   if(swipeView.currentIndex<4)
//                       swipeView.currentIndex++
//               }
//           }
//       }


}
