#include "pushpagecontrol.h"
#include <nlohmann/json.hpp>
#include <QDebug>
#include <iostream>

using json = nlohmann::json;

PushPageControl::PushPageControl(QObject *parent):
    QObject(parent)
{

}

void PushPageControl::pushRecommendJottings()
{
    json jot_json1;
    jot_json1["avatar"]="qrc:/images/images/avatar.png";
    jot_json1["nickName"]="JongHan";
    jot_json1["content"]="We could leave the Christmas";
    json picPath1;
    picPath1["path"]="qrc:/images/images/avatar.png";
    jot_json1["picPath"]={picPath1,picPath1,picPath1};

    //https://wx2.sinaimg.cn/mw690/cf89118bgy1fpel3su4eyj20u00u0tqg.jpg
    json jot_json2;
    jot_json2["avatar"]="qrc:/images/images/avatar.png";
    jot_json2["nickName"]="Josua";
    jot_json2["content"]="This is our place, we make the rules,This is our place, we make the rulesThis is our place, we make the rules";
    json picPath2;
    picPath2["path"]="qrc:/images/images/avatar.png";
    jot_json2["picPath"]={picPath2,picPath2};

    json jot_json3;
    jot_json3["avatar"]="qrc:/images/images/avatar.png";
    jot_json3["nickName"]="S.coups";
    jot_json3["content"]="Hot Hot fighting!";
    json picPath3;
    picPath3["path"]="qrc:/images/images/avatar.png";
    jot_json3["picPath"]={picPath3,picPath3,picPath3};

    json jottings;
    jottings["jottings"]={jot_json1,jot_json2,jot_json3};

    m_recommendJottings=QString::fromStdString(jottings.dump());
    json j = json::parse(m_recommendJottings.toStdString());
//    std::cout<<j.dump(4);
}

void PushPageControl::pushConcernedJottings()
{   
    json jot_json1;
    jot_json1["avatar"]="qrc:/images/images/avatar.png";
    jot_json1["nickName"]="Baby";
    jot_json1["content"]="We could leave the Christmas";
    json picPath1;
    picPath1["path"]="qrc:/images/images/avatar.png";
    jot_json1["picPath"]={picPath1,picPath1,picPath1};

    json jot_json2;
    jot_json2["avatar"]="qrc:/images/images/avatar.png";
    jot_json2["nickName"]="Angel";
    jot_json2["content"]="This is our place, we make the rules,This is our place, we make the rulesThis is our place, we make the rules";
    json picPath2;
    picPath2["path"]="qrc:/images/images/avatar.png";
    jot_json2["picPath"]={picPath2,picPath2,picPath2};

    json jottings;
    jottings["jottings"]={jot_json1,jot_json2};

    m_concernedJottings=QString::fromStdString(jottings.dump());
}

void PushPageControl::pushLocalJottings()
{   
    json jot_json1;
    jot_json1["avatar"]="qrc:/images/images/avatar.png";
    jot_json1["nickName"]="Baby";
    jot_json1["content"]="We could leave the Christmas";
    json picPath1;
    picPath1["path"]="qrc:/images/images/avatar.png";
    jot_json1["picPath"]={picPath1,picPath1,picPath1};

    json jot_json2;
    jot_json2["avatar"]="qrc:/images/images/avatar.png";
    jot_json2["nickName"]="Angel";
    jot_json2["content"]="This is our place, we make the rules";
    json picPath2;
    picPath2["path"]="qrc:/images/images/avatar.png";
    jot_json2["picPath"]={picPath2,picPath2,picPath2};

    json jottings;
    jottings["jottings"]={jot_json1,jot_json2};


    m_localJottings=QString::fromStdString(jottings.dump());
}

void PushPageControl::pushVideos()
{
    json jot_json1;
    jot_json1["avatar"]="qrc:/images/images/avatar.png";
    jot_json1["nickName"]="Baby";
    jot_json1["content"]="We could leave the Christmas";
    jot_json1["path"] = "http://192.168.38.249:8081/1/playlist.m3u8";

    json jot_json2;
    jot_json2["avatar"]="qrc:/images/images/avatar.png";
    jot_json2["nickName"]="Angel";
    jot_json2["content"]="This is our place, we make the rules";
    jot_json2["path"] = "http://192.168.38.249:8081/2/playlist.m3u8";

    json jot_json3;
    jot_json3["avatar"]="qrc:/images/images/avatar.png";
    jot_json3["nickName"]="Cindy";
    jot_json3["content"]="very good!";
    jot_json3["path"] = "http://192.168.38.249:8081/3/playlist.m3u8";

    json videosInfo;
    videosInfo["videos"] = {jot_json1,jot_json2,jot_json3};

    std::cout<<"\n"<<videosInfo.dump(4);
    m_videos = QString::fromStdString(videosInfo.dump());
    json j = json::parse(m_videos.toStdString());

}

void PushPageControl::receiveOneJotting(QString jotting_id)
{
    json jotting;
    jotting["avatar"]="qrc:/images/images/avatar.png";
    jotting["netizenName"]="NULL";
    jotting["content"]="Hello";
    jotting["likeCount"]="0";
    jotting["collectCount"]="0";
    jotting["commentCount"]="0";
    jotting["time"]="0000-00-00 00:00";

    json picPath;
    picPath["path"]="qrc:/images/images/avatar.png";
    jotting["picPath"]={picPath,picPath,picPath};

    json comment_1;
    comment_1["netizenName"]="Joey";
    comment_1["pic"]="qrc:/images/images/avatar.png";
    comment_1["content"]="very good!";
    comment_1["time"]="2022-06-01 22:12";
    json comment_2;
    comment_2["netizenName"]="Kacy";
    comment_2["pic"]="qrc:/images/images/avatar.png";
    comment_2["content"]="I like it!";
    comment_2["time"]="2022-06-01 14:12";
    json comment_3;
    comment_3["netizenName"]="Aacy";
    comment_3["pic"]="qrc:/images/images/avatar.png";
    comment_3["content"]="I like it!";
    comment_3["time"]="2022-06-01 14:12";
    json comment_4;
    comment_4["netizenName"]="Bacy";
    comment_4["pic"]="qrc:/images/images/avatar.png";
    comment_4["content"]=",I like it!I ";
    comment_4["time"]="2022-06-01 14:12";
    json comment_5;
    comment_5["netizenName"]="Cacy";
    comment_5["pic"]="qrc:/images/images/avatar.png";
    comment_5["content"]="I like it!";
    comment_5["time"]="2022-06-01 14:12";
    json comment_6;
    comment_6["netizenName"]="Dacy";
    comment_6["pic"]="qrc:/images/images/avatar.png";
    comment_6["content"]="I like it!";
    comment_6["time"]="2022-06-01 14:12";
    json comment_7;
    comment_7["netizenName"]="Eacy";
    comment_7["pic"]="qrc:/images/images/avatar.png";
    comment_7["content"]="I like it!";
    comment_7["time"]="2022-06-01 14:12";
    jotting["comment"]={comment_1,comment_2,comment_3,comment_4,comment_5,comment_6,comment_7};

    m_jotting=QString::fromStdString(jotting.dump());
}

void PushPageControl::setRecommendJottings(const QString &recommendJottings)
{
    m_recommendJottings=recommendJottings;
}

QString PushPageControl::getRecommendJottings() const
{
    return m_recommendJottings;
}

void PushPageControl::setConcernedJottings(const QString &concernedJottings)
{
    m_concernedJottings=concernedJottings;
}

QString PushPageControl::getConcernedJottings() const
{
    return m_concernedJottings;
}

void PushPageControl::setLocalJottings(const QString &localJottings)
{
    m_localJottings=localJottings;
}

QString PushPageControl::getLocalJottings() const
{
    return m_localJottings;
}

void PushPageControl::setJotting(const QString &jotting)
{
    m_jotting=jotting;
}

QString PushPageControl::getJotting() const
{
    return m_jotting;
}

void PushPageControl::setVideos(const QString &videos)
{
    m_videos = videos;
}

QString PushPageControl::getVideos() const
{
    return m_videos;
}

