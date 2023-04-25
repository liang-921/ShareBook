#include "videopagecontrol.h"

#include "nlohmann/json_fwd.hpp"
#include <iostream>
#include <ostream>
#include <nlohmann/json.hpp>

using json = nlohmann::json;

VideoPageControl::VideoPageControl(QObject *parent):
    QObject(parent)
{

}

void VideoPageControl::pushRecommendVideos()
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

void VideoPageControl::setNickName(const QString &nickName)
{
    m_nickName=nickName;
}

QString VideoPageControl::getNickName() const
{
    return m_nickName;
}


void VideoPageControl::setAvatar(const QString &avatar)
{
    m_avatar=avatar;
    emit avatarChanged(m_avatar);
}

QString VideoPageControl::getAvatar() const
{
    return m_avatar;
}

void VideoPageControl::setVideos(const QString &videos)
{
    m_videos = videos;
}

QString VideoPageControl::getVideos() const
{
    return m_videos;
}
