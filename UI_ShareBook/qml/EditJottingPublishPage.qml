import QtQuick 2.0
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick
import Qt5Compat.GraphicalEffects

Item {
    id:personalPage
    anchors.fill: parent

    readonly property int rootWidth: personalPage.width
    readonly property int rootHeight: personalPage.height

    Rectangle{
        id:topRec
        width:rootWidth
        height:rootWidth*0.12
        anchors.left: parent.left

        anchors.top: parent.top
        anchors.topMargin: rootWidth*0.02

        Button{
            id:backButton
            width: rootWidth*0.06
            height: rootWidth*0.06
            anchors.left: parent.left
            anchors.leftMargin: rootWidth*0.02
            anchors.verticalCenter: parent.verticalCenter
            Image {
                id: backImg
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                sourceSize: Qt.size(30, 30)
                source:"qrc:/images/images/backbutton.png"
            }

            flat: true
            icon.color: "transparent"
            onClicked: {
                loader.source=pushPage_loader
                bottom_button.visible = true
            }
        }


        Button{
            id: concern_button
            anchors.left: backButton.right
            anchors.leftMargin:  rootWidth*0.8
            anchors.right: parent.right
            anchors.rightMargin: rootWidth*0.02
            width: rootWidth*0.06
            height: rootWidth*0.06
            flat: true
            icon.color: "transparent"
            anchors.verticalCenter: parent.verticalCenter
            Image {
                id: tishiImg
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                sourceSize: Qt.size(30, 30)
                source:"qrc:/images/images/tishi.png"
            }
            onClicked: {
                console.log("提示被点击！")
            }
        }


    }


    TextEdit{
        id:edit
        width: rootWidth
        height:rootWidth/2
        anchors.top: topRec.bottom
        anchors.topMargin: rootWidth*0.02
        text:"这一刻的想法..."
    }


    Component{
        id:imgDelegate
        Rectangle{
            width: 100
            height:100
            Image{
                anchors.fill: parent
                source: "qrc:/images/images/head.png"
            }
        }
    }


    GridView{
        id: picListView
        width: rootWidth
        anchors.top: edit.bottom
        anchors.topMargin: rootWidth*0.02
        anchors.left: parent.left
        anchors.leftMargin: rootWidth*0.02
        anchors.horizontalCenter: parent.horizontalCenter
    //            anchors.verticalCenter: parent.verticalCenter

        clip: true
        flow: GridView.FlowLeftToRight
        cellWidth: 120
        cellHeight: 120
        model: 9
        delegate:imgDelegate
    }

}

