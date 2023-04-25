import QtQuick 2.0
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia 5.8
import QtCore
import UIControl 1.0
Item {
    id:publishPage

    readonly property int rootWidth: publishPage.width
    readonly property int rootHeight: publishPage.height
    property var selectMaterialData: []
    property int materialCount: 0

    FileOpenDialog {
        id: openFile
        title: "Open file"
        nameFilters: ["Images (*.png *.jpg *.jpeg)", /*"Documents (*.doc *.docx)"*/, "Videos (*.mp4)","All files (*)"]
        selectMultiple:  true
        onAccepted: {
//            outputOpenFile.text = "File selected: " + openFile.fileUrl
            for(var i=0;i<openFile.fileUrls.length;i++){
                var data = {"path":openFile.fileUrls[i]};
                filesModel.append(data)

            }
            picListView.model = filesModel
        }
        onRejected: outputOpenFile.text = "File selected: –"
    }

    Popup {
        id: publishFinish
        anchors.centerIn: Overlay.overlay
        Text {
            id: publishFinishText
            color: "red"
            font.bold: true
        }
    }

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


    Component{
        id:imgDelegate
        Rectangle{
            width: 120
            height:120
//            color: "red"
            Image{
//                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
                source: path
            }
        }
    }


    GridView{
        id: picListView
        width: rootWidth
        height: rootWidth/3
        anchors.top: topRec.bottom
        anchors.topMargin: rootWidth*0.02
        anchors.right: parent.right
        anchors.rightMargin: rootWidth*0.02
        anchors.left: parent.left
        anchors.leftMargin: rootWidth*0.02
        ListModel{
            id:filesModel
        }
        clip: true
        flow: GridView.FlowTopToBottom
        cellWidth: 130
        cellHeight: 130
        delegate: imgDelegate
    }

    Button {
        id:openBtn
        anchors.top: picListView.bottom
        anchors.topMargin: rootWidth*0.02
        width:60
        height:60
        background: Rectangle{
            color:"transparent"
        }
        Image {
            id: addImg
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            sourceSize: Qt.size(30, 30)
            source:"qrc:/images/images/addPic.png"
        }
        onClicked: { openFile.open(); }
    }

    Rectangle{
        id:speRec
        width: rootWidth
        height:1
        anchors.top: openBtn.bottom
        anchors.topMargin: rootWidth*0.02
        anchors.left: parent.left
        anchors.leftMargin: rootWidth*0.02
        anchors.right: parent.right
        anchors.rightMargin: rootWidth*0.02
        color: "#D3D3D3"
    }

    Rectangle{
        id:editRec
        width: rootWidth
        height:120
        anchors.top: speRec.bottom
        anchors.topMargin: rootWidth*0.02
        anchors.left: parent.left
        anchors.leftMargin: rootWidth*0.02
        anchors.right: parent.right
        anchors.rightMargin: rootWidth*0.02
        TextArea{
            id:edit
            anchors.fill: parent
            overwriteMode: true
            background: Rectangle{
                color:"transparent"
            }


            placeholderText:"这一刻的想法..."
        }

    }

    Rectangle{
        id:speRec2
        width: rootWidth
        height:1
        anchors.top: editRec.bottom
        anchors.topMargin: rootWidth*0.02
        anchors.left: parent.left
        anchors.leftMargin: rootWidth*0.02
        anchors.right: parent.right
        anchors.rightMargin: rootWidth*0.02
        color: "#D3D3D3"
    }


    Rectangle{
        id:bottomRec
        width: rootWidth
        height:60
//        anchors.top: speRec2.bottom
//        anchors.topMargin: rootWidth*0.02
        anchors.left: parent.left
        anchors.leftMargin: rootWidth*0.02
        anchors.right: parent.right
        anchors.rightMargin: rootWidth*0.02
        anchors.bottom: parent.bottom
        anchors.bottomMargin: rootWidth*0.02
//        color: "#D3D3D3"
        Button {
            id: saveBtn
            anchors.left: parent.left
            width:40
            height:40
            anchors.verticalCenter:parent.verticalCenter
            background: Rectangle{
                color: "white"
                opacity: 0.7
            }

            ColumnLayout{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: 1
                Image {
                    id: saveImg
                    width: 30
                    height: 30
                    fillMode: Image.PreserveAspectFit
                    sourceSize: Qt.size(30, 30)
                    source:"qrc:/images/images/save.png"
                }
                Text {
                    id:saveText
                    text: qsTr("存草稿")
                    Layout.alignment: Qt.AlignHCenter
                    font.pointSize: 12
                }
            }

            onClicked: {console.log("存草稿被点击啦！") }
        }

        Button{
            id:publish
            anchors.left: saveBtn.right
            anchors.leftMargin: rootWidth*0.02
            anchors.right: parent.right
            anchors.rightMargin: rootWidth*0.02
            anchors.verticalCenter:parent.verticalCenter
            width:90
            height:60
            background: Rectangle{
                radius: 30
                color: 	"#EE0000"
            }
            text: "发布笔记"
            onClicked: {
                openFile.publishJotting(edit.text)
                publishFinishText.text = "发布成功！"
                publishFinish.open()
                console.log("发布笔记点击啦！")

                loader.source=pushPage_loader
                bottom_button.visible = true
            }
            font{
                pixelSize: 20
            }
        }


    }

}
