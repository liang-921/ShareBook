//#include "boostclient.h"
#include "client.h"
#include "base64.h"
#include "imageprovider.h"

#include "personaluicontrol.h"
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>

extern ImageProvider *imageProvider;

PersonalUIControl::PersonalUIControl(QObject *parent):
    QObject(parent),m_nickName(""),m_sign("")
{

}

void PersonalUIControl::setNickName(const QString &nickName)
{
    m_nickName=nickName;
}

QString PersonalUIControl::getNickName() const
{
    return m_nickName;
}

void PersonalUIControl::setSign(const QString &sign)
{
    m_sign=sign;
    emit signChanged(m_sign);
}

QString PersonalUIControl::getSign() const
{
    return m_sign;
}

void PersonalUIControl::setavatar(const QString &avatar)
{
    m_avatar=avatar;
    emit avatarChanged(m_avatar);
}

QString PersonalUIControl::getavatar() const
{
    return m_avatar;
}


void PersonalUIControl::setJottings(const QString &jottings)
{
    m_jottings=jottings;
    emit jottingsChanged(m_jottings);
}

QString PersonalUIControl::getJottings() const
{
    return m_jottings;
}

void PersonalUIControl::setPicPath(const QString &picPath)
{
    m_picPath=picPath;
    emit picPathChanged(m_picPath);
}

QString PersonalUIControl::getPicPath() const
{
    return m_picPath;
}

void PersonalUIControl::setInterest(const QString &interest)
{
    m_interest=interest;
    emit interestChanged(m_interest);
}

QString PersonalUIControl::getInterest() const
{
    return m_interest;
}

void PersonalUIControl::setFans(const QString &fans)
{
    m_fans=fans;
    emit fansChanged(m_fans);
}

QString PersonalUIControl::getFans() const
{
    return m_fans;
}

void PersonalUIControl::setJottingCount(const QString &jottingCount)
{
    m_jotting_count=jottingCount;
    emit jottingCountChanged(m_jotting_count);
}

QString PersonalUIControl::getJottingCount() const
{
    return m_jotting_count;
}

void PersonalUIControl::setInterestCount(const QString &interestCount)
{
    m_interest_count=interestCount;
    emit interestCountChanged(m_interest_count);
}

QString PersonalUIControl::getInterestCount() const
{
    return m_interest_count;
}

void PersonalUIControl::setFanCount(const QString &fanCount)
{
    m_fan_count=fanCount;
    emit fanCountChanged(m_fan_count);
}

QString PersonalUIControl::getFanCount() const
{
    return m_fan_count;
}

QJsonValue stringToJson(const QString &str)
{
    QString context = QString("{%1}").arg(str);
    QJsonParseError err;
    QJsonDocument doc = QJsonDocument::fromJson(context.toUtf8(), &err);
    if (err.error != QJsonParseError::NoError) {
        return QJsonValue();
    }

    return doc.object();
}

QJsonObject transition(nlohmann::json js)
{
    std::string info = js.dump();
    const char *ch=info.data();

    QByteArray byte_array;
    QJsonParseError json_error;
    QJsonObject rootObj;   //最后转换出来的json 对象
    QJsonDocument parse_doucment = QJsonDocument::fromJson(byte_array.append(ch), &json_error);
    if(json_error.error == QJsonParseError::NoError) {
           if(parse_doucment.isObject())
           {
               rootObj = parse_doucment.object();
           }
    } else {
        qDebug()<<json_error.errorString();
    }
    return rootObj;
}

void PersonalUIControl::initData()
{
//    发送请求获取网名id为~~~的相关数据
    nlohmann::json message = {
        {"id","1"},
        {"request","InitPersonalInfo"}
    };
    std::string sendData = message.dump();
    Client::getInstance()->send(sendData.c_str(),sendData.length());
    std::cout<<"Client"<<"客户端初始化用户信息......"<<std::endl;
    char *receiveData = new char[100000000];

    Client::getInstance()->receive(receiveData);

    //获取到的网民基本信息 以 json形式
    nlohmann::json personInfo = nlohmann::json::parse(receiveData);
    cout<<personInfo.dump(4)<<endl;

    QJsonObject rootObj = transition(personInfo);   //最后转换出来的json 对象
    //昵称
    m_nickName = rootObj["name"].toString();
    //个签
    m_sign = rootObj["signal"].toString();
    //粉丝数量
    m_fan_count = QString::number(rootObj["fanCnt"].toInt());
    m_interest_count = QString::number(rootObj["interestCnt"].toInt());

   //获取头像信息
    std::string avatarData=base64_decode(personInfo["avatar"]);
    QPixmap newpixmap;
    newpixmap.loadFromData((unsigned char *)avatarData.data(),avatarData.length());
    imageProvider->setAvatar(newpixmap);

    QJsonArray jottingsArray = rootObj["jottings"].toArray();
    QJsonArray array;
    QHash<QString,QPixmap> firstPicHash;
    for(int i=0;i<jottingsArray.size();i++){
        QJsonObject jot_Obj = jottingsArray[i].toObject();

        string imgId = personInfo["jottings"][i]["material_firstPath"]["picId"];
        string data = base64_decode(personInfo["jottings"][i]["material_firstPath"]["picContent"]);
        QPixmap pixmap;
        pixmap.loadFromData((unsigned char *)data.data(),data.length());


        firstPicHash.insert(QString::fromStdString(imgId),pixmap);

        string picPath = "image://photos/"+ imgId;
        jot_Obj.insert("picPath",QString::fromStdString(picPath));
        jot_Obj.insert("file","qrc:/qml/qml/JotDetailPage.qml");
        array.append(QJsonValue(jot_Obj));
    }
    imageProvider->setHashPixmaps(firstPicHash);


    m_jotting_count=QString::number(array.count());
    QJsonDocument jot_doc(array);
    m_jottings=QString(jot_doc.toJson(QJsonDocument::Indented));

    //关注者信息
    qDebug()<<"关注者信息。。。。。。。。。。。。。";


    QJsonArray arrayIn;
    QHash<QString,QPixmap> interestAvatorVec;
    //没有关注者
    if(personInfo["concernedInfo"].is_null()){
        qDebug()<<"没有关注者。。。。。。。。。。。。。";
        QJsonObject interest_json1;
        interest_json1.insert("nickName","NULL");
        interest_json1.insert("signal","NULL");
        interest_json1.insert("avatarPath","NULL");
        interest_json1.insert("file","qrc:/qml/qml/PersonalPage.qml");
        arrayIn.append(QJsonValue(interest_json1));
        QJsonDocument interest_doc(arrayIn);
        m_interest=QString(interest_doc.toJson(QJsonDocument::Indented));
    }else{
        QJsonArray interestsArray = rootObj["concernedInfo"].toArray();
        qDebug()<<interestsArray.isEmpty();
        for(int i=0;i<interestsArray.size();i++){
            QJsonObject interest_Obj = interestsArray[i].toObject();
            string imgId = personInfo["concernedInfo"][i]["avatarId"];
            string avatarPath = "image://photos/"+ imgId;
            string data = base64_decode(personInfo["concernedInfo"][i]["avatar"]);
            QPixmap pixmap;
            pixmap.loadFromData((unsigned char *)data.data(),data.length());

            interestAvatorVec.insert(QString::fromStdString(imgId),pixmap);

            interest_Obj.insert("avatarPath",QString::fromStdString(avatarPath));
            interest_Obj.insert("file","qrc:/qml/qml/PersonalPage.qml");
            arrayIn.append(QJsonValue(interest_Obj));
        }
        imageProvider->setInterestHashPixmaps(interestAvatorVec);
        QJsonDocument interest_doc(arrayIn);
        m_interest=QString(interest_doc.toJson(QJsonDocument::Indented));
    }

    qDebug()<<m_interest;

    //粉丝信息
    QJsonArray fansArray = rootObj["fansInfo"].toArray();
    QJsonArray arrayFan;
    QHash<QString,QPixmap> fanAvatorVec;
    for(int i=0;i<fansArray.size();i++){
        QJsonObject fan_Obj = fansArray[i].toObject();
        string imgId = personInfo["fansInfo"][i]["avatarId"];
        string avatarPath = "image://photos/"+ imgId;
        string data = base64_decode(personInfo["fansInfo"][i]["avatar"]);
        QPixmap pixmap;
        pixmap.loadFromData((unsigned char *)data.data(),data.length());

        fanAvatorVec.insert(QString::fromStdString(imgId),pixmap);

        fan_Obj.insert("avatarPath",QString::fromStdString(avatarPath));
        fan_Obj.insert("file","qrc:/qml/qml/PersonalPage.qml");
        arrayFan.append(QJsonValue(fan_Obj));
    }
    imageProvider->setFanHashPixmaps(fanAvatorVec);
    QJsonDocument fan_doc(arrayFan);
    m_fans=QString(fan_doc.toJson(QJsonDocument::Indented));

    if(m_fans.isEmpty()){
        m_fans = "";
    }
}

void PersonalUIControl::initRelationData()
{
//    发送请求获取网名id为~~~的相关数据
    nlohmann::json message = {
        {"id","2"},
        {"request","InitRelationInfo"}
    };
    std::string sendData = message.dump();
    Client::getInstance()->send(sendData.c_str(),sendData.length());
    std::cout<<"Client"<<"客户端初始化用户关注和粉丝信息......"<<std::endl;
    char *receiveData = new char[100000000];

    Client::getInstance()->receive(receiveData);

    //获取到的网民其他信息 以 json形式
    nlohmann::json relationInfo = nlohmann::json::parse(receiveData);
    cout<<relationInfo.dump(4)<<endl;


    QJsonObject rootObj = transition(relationInfo);   //最后转换出来的json 对象
    QJsonArray interestsArray = rootObj["concernedInfo"].toArray();
    QJsonArray array;

//    QVector<QPixmap> interestAvatorVec;
//    for(int i=0;i<interestsArray.size();i++){
//        QJsonObject jot_Obj = interestsArray[i].toObject();
//        string imgId = personInfo["jottings"][i]["material_firstPath"]["picId"];
//        string data = base64_decode(personIfo["interests"][i]["avatar"]);
//        QPixmap pixmap;
//        pixmap.loadFromData((unsigned char *)data.data(),data.length());
//        interestAvatorVec.push_back(pixmap);
//        string avatarPath = "image://photos/relation"+ to_string(i);
//        jot_Obj.insert("avatarPath",QString::fromStdString(avatarPath));
//        jot_Obj.insert("file","qrc:/qml/qml/PersonalPage.qml");
//        array.append(QJsonValue(jot_Obj));
//    }
//    imageProvider->setHashPixmaps(interestAvatorVec);

    qDebug()<<"关注者解析完成!........";
    QJsonDocument jot_doc(array);
    m_interest=QString(jot_doc.toJson(QJsonDocument::Indented));


//    //关注数据
//    QJsonObject interest_json1;
//    interest_json1.insert("nickName","Alice");
//    interest_json1.insert("file","qrc:/qml/qml/PersonalPage.qml");
//    QJsonObject interest_json2;
//    interest_json2.insert("nickName","Susan");
//    interest_json2.insert("file","qrc:/qml/qml/PersonalPage.qml");
//    QJsonObject interest_json3;
//    interest_json3.insert("nickName","Mark");
//    interest_json3.insert("file","qrc:/qml/qml/PersonalPage.qml");
//    QJsonArray interest;
//    interest.append(QJsonValue(interest_json1));
//    interest.append(QJsonValue(interest_json2));
//    interest.append(QJsonValue(interest_json3));
//    m_interest_count=QString::number(interest.count());
//    QJsonDocument interest_doc(interest);
//    m_interest=QString(interest_doc.toJson(QJsonDocument::Indented));

//    qDebug()<<m_interest;

    //粉丝数据
    QJsonObject fan_json1;
    fan_json1.insert("nickName","Alice");
    fan_json1.insert("file","qrc:/qml/qml/PersonalPage.qml");
    QJsonObject fan_json2;
    fan_json2.insert("nickName","Joey");
    fan_json2.insert("file","qrc:/qml/qml/PersonalPage.qml");
    QJsonObject fan_json3;
    fan_json3.insert("nickName","Lay");
    fan_json3.insert("file","qrc:/qml/qml/PersonalPage.qml");
    QJsonArray fans;
    fans.append(QJsonValue(fan_json1));
    fans.append(QJsonValue(fan_json2));
    fans.append(QJsonValue(fan_json3));
    m_fan_count=QString::number(fans.count());
    QJsonDocument fan_doc(fans);
    m_fans=QString(fan_doc.toJson(QJsonDocument::Indented));

    delete []receiveData;

}


