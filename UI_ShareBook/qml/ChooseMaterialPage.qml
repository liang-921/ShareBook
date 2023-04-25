import QtQuick 2.0
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia 5.8
import QtCore
import UIControl 1.0

Item {
    id:chooseMaterialPage

    readonly property int rootWidth: chooseMaterialPage.width
    readonly property int rootHeight: chooseMaterialPage.height
    property var selectMaterialData: []
    property int materialCount: 0

    FileOpenDialog {
        id: openFile
        title: "Open file"
        nameFilters: ["Images (*.png *.jpg *.jpeg)", /*"Documents (*.doc *.docx)"*/, "Videos (*.mp4)","All files (*)"]
        selectMultiple:  true
        onAccepted: {
//            outputOpenFile.text = "File selected: " + openFile.fileUrl
            var data = {"path":"qrc:/images/images/addPic.png"};
            filesModel.append()
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
        Item {
            id: control

            implicitWidth: 160
            implicitHeight: 160

            property real from: 0 //最小值
            property real to: 100 //最大值
            property real value: 0 //当前值
            property real percent: (value-from)/(to-from) //百分比[0,1]
            //
            property int canvasMargin: 3
            property int canvasWidth: width < height ? width : height
            property int canvasRadius: canvasWidth / 2 - canvasMargin
            property int lineWidth: 16
            property int lineBorder: 6
            property color bgColor: "#0486FF"
            property color valueColor: "#0486FF"
            //
            property real _valueAngle: Math.PI/2+Math.PI*2*percent
            on_ValueAngleChanged: canvas.requestPaint()
            //
            property real speed: 0.1
            property real offset: 0

            Canvas {
                id: canvas
                width: canvasWidth
                height: canvasWidth
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.clearRect(0, 0, canvasWidth, canvasWidth);
                    ctx.lineCap = "round";

                    drawBg(ctx);
                    drawValue(ctx);
                }

                //context.arc(x,y,r,sAngle,eAngle,counterclockwise);
                //x:圆的中心的x坐标。
                //y:圆的中心的y坐标。
                //r:圆的半径。
                //sAngle:起始角，以弧度计。（弧的圆形的三点钟位置是0度）。
                //eAngle:结束角，以弧度计。
                //counterclockwise:可选参数。False=顺时针，true=逆时针。
                function drawBg(ctx)
                {
                    var color_offset = offset>Math.PI?(1-(offset-Math.PI)/Math.PI):(offset/Math.PI);

                    ctx.beginPath();
                    ctx.arc(canvasWidth/2, canvasWidth/2, canvasRadius-lineWidth/2-lineBorder, 0, 2*Math.PI);
                    ctx.lineWidth = lineWidth+lineBorder*2;
                    ctx.strokeStyle = Qt.lighter(bgColor, 1.7+0.2*color_offset);
                    ctx.stroke();

                    ctx.beginPath();
                    ctx.arc(canvasWidth/2, canvasWidth/2, canvasRadius-lineWidth/2-lineBorder, 0, 2*Math.PI);
                    ctx.lineWidth = lineWidth;
                    ctx.strokeStyle = Qt.lighter(bgColor, 1.6+0.2*color_offset);
                    ctx.stroke();
                }

                function drawValue(ctx)
                {
                    //ctx.save();
                    //带阴影效果时cpu占用明显增高
                    //ctx.shadowColor= valueColor;
                    //ctx.shadowBlur= lineWidth/4;
                    ctx.beginPath();
                    ctx.arc(canvasWidth/2, canvasWidth/2, canvasRadius-lineWidth/2-lineBorder, Math.PI/2, _valueAngle, false);
                    ctx.lineWidth = lineWidth;
                    ctx.strokeStyle = valueColor;
                    ctx.stroke();
                    //ctx.restore();
                }

                Text {
                    id: txt
                    anchors.centerIn: parent
                    font.family: "Microsoft YaHei"
                    font.pixelSize: (canvasWidth-lineWidth)/6;
                    font.bold: true
                    color: valueColor
                    text: qsTr("%1 %").arg(control.percent.toFixed(2)*100);
                }
            }

            //用定时器刷新
            Timer {
                id:timer
                running: visible
                repeat: true
                interval: 35
                onTriggered:{
                    //波浪移动
                    offset += speed;
                    offset %= Math.PI*2;
                    canvas.requestPaint();
                }
            }
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
                color:"red"
            }
            font{
                pixelSize: 20
            }
            text: "发布笔记"
            onClicked: {
//                publishFinishText.text = "发布成功！"
                publishFinish.open()
                timer.start()
            }
        }


    }




//    Column {
//        spacing: 20

//        Button {
//            text: "Open File"
//            onClicked: { openFile.open(); }
//        }
//        Text { id: outputOpenFile }

//        Image {
//            id: img1
//            width: 200
//            height: 200
//        }

//        Image{
//            id:img2
//            width: 200
//            height:200
//        }

//        TextEdit{
//            id: content
//            text:"请输入文字"
//        }

//        Button{
//            text: qsTr("发布笔记")
//            onClicked: {
//                openFile.publishJotting(content.text)
//            }
//        }
//    }


    /*
    function resortMaterial(cancel_text){
        selectMaterialData.splice(parseInt(cancel_text)-1,1)
        var count=0
        for(var i=0;i<materialData.length;i++){
            if(count===materialCount) break;
            if(materialData[i].order!==""){
                ++count
                if(parseInt(materialData[i].order)>parseInt(cancel_text)){
                    materialData[i].order=""+(parseInt(materialData[i].order)-1)
                }
            }
        }
        materialsListView.model=materialData
        materialsListView.update()
    }

    function changePrimeStyle(){
        if(materialCount>0){
            material_count_border.color="white"
            material_count_border.border.color="black"
            material_count_border.border.width=1
        }else{
            material_count_border.color="grey"
            material_count_border.border.color="#ffffff"
            material_count_border.border.width=0
        }
    }

    Button{
        id:backButton
        icon.source: "qrc:/images/images/backbutton.png"
        icon.width: rootWidth*0.1
        icon.height: rootWidth*0.1
        width: icon.width
        height: icon.height
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: rootWidth*0.02
        flat: true
        onClicked: {
            loader.source=pushPage_loader
        }
    }

    Text{
        id:netizen_name
        text:qsTr("选择素材")
        anchors.top:parent.top
        anchors.topMargin: rootWidth*0.02
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 30
        font.bold: true
    }

    Rectangle{
        id:material_count_border
        radius: 45
//        color: "grey"
        width: rootWidth*0.15
        height: rootHeight*0.04
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: rootWidth*0.03
        Text {
            id:material_count
            anchors.centerIn: parent
            text: qsTr("Finish")
        }
        TapHandler{
            onTapped: {
                if(materialCount>0){
                    loader.setSource(publishPage_loader,{"materialPath":selectMaterialData})
                }else{
                    toast.show("Please choose materials")
                }
            }
        }
        Component.onCompleted: {
            changePrimeStyle()
        }
    }

    Rectangle{
        id:seperator_line_1
        width: parent.width
        height: 1
        color: "#000000"
        anchors.top: netizen_name.bottom
        anchors.topMargin: parent.width*0.05
    }

    Row{
        id:banner
        spacing: parent.width*0.25
        anchors.top: seperator_line_1.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        ColumnLayout{
            id:all
            Text{
                font.italic: true
                font.bold: true
                font.pixelSize: 30
                Layout.alignment: Qt.AlignHCenter
                text: qsTr("全部")
            }
            Rectangle{
                id:rect_all
                width: 30
                height: 5
                radius: 5
                color: "#000000"
                visible: true
                Layout.alignment: Qt.AlignHCenter
            }
            TapHandler{
                onTapped: {
                    rect_all.visible=true
                    rect_photo.visible=false
                    rect_video.visible=false
                }
            }
        }
        ColumnLayout{
            id:photo
            Text{
                font.italic: true
                font.bold: true
                font.pixelSize: 30
                Layout.alignment: Qt.AlignHCenter
                text: qsTr("照片")
            }
            Rectangle{
                id:rect_photo
                width: 30
                height: 5
                radius: 5
                color: "#000000"
                visible: false
                Layout.alignment: Qt.AlignHCenter
            }
            TapHandler{
                onTapped: {
                    rect_all.visible=false
                    rect_photo.visible=true
                    rect_video.visible=false
                }
            }
        }
        ColumnLayout{
            id:video
            Text{
                font.italic: true
                font.bold: true
                font.pixelSize: 30
                Layout.alignment: Qt.AlignHCenter
                text: qsTr("视频")
            }
            Rectangle{
                id:rect_video
                width: 30
                height: 5
                radius: 5
                color: "#000000"
                visible:false
                Layout.alignment: Qt.AlignHCenter
            }
            TapHandler{
                onTapped: {
                    rect_all.visible=false
                    rect_photo.visible=false
                    rect_video.visible=true
                }
            }
        }
    }

    Rectangle{
        id:seperator_line_2
        width: parent.width
        height: 1
        color: "#000000"
        anchors.top: banner.bottom
        anchors.topMargin: parent.width*0.02
    }

    ScrollView{
        width:rootWidth
        height: rootHeight*0.2+materialsListView.height
        anchors.top: seperator_line_2.bottom
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.topMargin: rootWidth*0.02
        anchors.leftMargin: rootWidth*0.03
        anchors.bottomMargin: rootWidth*0.02
        Component{
            id:materialComponent
            Rectangle{
                id: jot
                width:rootWidth*0.3
                height: width
                border.color: "#000000"
                border.width:1
                radius: 5
                Image{
                    width:parent.width
                    height: parent.height
                    source: materialData[index].path
                    Rectangle{
                        radius: 90
                        width: parent.width*0.2
                        height: width
                        border.width: 1
                        border.color: "grey"
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.margins: parent.width*0.02
                        Text{
                            id:num_material
                            anchors.centerIn: parent
                            text: qsTr(materialData[index].order)
                        }
                    }
                }

                TapHandler{
                    onTapped: {
                        if(!materialData[index].isSelected){
                            if(materialCount<9){
                                materialData[index].isSelected=true
                                materialData[index].order=""+(++materialCount)
                                num_material.text=qsTr(""+materialCount)
                                selectMaterialData.push({"path":materialData[index].path})
                            }else{
                                toast.show("Can't choose anymore")
                            }
                        }else{
                            --materialCount
                            materialData[index].isSelected=false
                            materialData[index].order=""
                            resortMaterial(num_material.text)
                            num_material.text=qsTr("")
                        }
                        changePrimeStyle()
                    }
                }
            }
        }

        GridView {
            id: materialsListView
            width: rootWidth
            height: rootHeight
            cellWidth: rootWidth*0.32
            cellHeight: cellWidth
            model: materialData
            delegate: materialComponent
            clip: true
        }
    }

    */
}
