#ifndef PERSONALUICONTROL_H
#define PERSONALUICONTROL_H

#include "qimage.h"
#include <QObject>

class PersonalUIControl:public QObject
{
    Q_OBJECT
    //昵称
    Q_PROPERTY(QString nickName READ getNickName WRITE setNickName NOTIFY nickNameChanged)

    Q_PROPERTY(QString picPath READ getPicPath WRITE setPicPath NOTIFY picPathChanged)

    //个签
    Q_PROPERTY(QString sign READ getSign WRITE setSign NOTIFY signChanged)
    //头像
    Q_PROPERTY(QString avatar READ getavatar WRITE setavatar NOTIFY avatarChanged)
    //笔记
    Q_PROPERTY(QString jottings READ getJottings WRITE setJottings NOTIFY jottingsChanged)
    //关注的人
    Q_PROPERTY(QString interest READ getInterest WRITE setInterest NOTIFY interestChanged)
    //粉丝
    Q_PROPERTY(QString fans READ getFans WRITE setFans NOTIFY fansChanged)
    //笔记数
    Q_PROPERTY(QString jottingCount READ getJottingCount WRITE setJottingCount NOTIFY jottingCountChanged)
    //关注数量
    Q_PROPERTY(QString interestCount READ getInterestCount WRITE setInterestCount NOTIFY interestCountChanged)
    //粉丝数量
    Q_PROPERTY(QString fanCount READ getFanCount WRITE setFanCount NOTIFY fanCountChanged)
public:
    explicit PersonalUIControl(QObject *parent = nullptr);

    void setNickName(const QString &nickName);
    QString getNickName()const;

    void setSign(const QString &sign);
    QString getSign()const;

    void setavatar(const QString &avatar);
    QString getavatar()const;

    void setJottings(const QString &jottings);
    QString getJottings()const;


    void setPicPath(const QString &picPath);
    QString getPicPath()const;

    void setInterest(const QString &interest);
    QString getInterest()const;

    void setFans(const QString &fans);
    QString getFans()const;

    void setJottingCount(const QString &jottingCount);
    QString getJottingCount()const;

    void setInterestCount(const QString &interestCount);
    QString getInterestCount()const;

    void setFanCount(const QString &fanCount);
    QString getFanCount()const;

    Q_INVOKABLE void initData();
    Q_INVOKABLE void initRelationData();
signals:
    void nickNameChanged(const QString nickName);
    void signChanged(const QString sign);
    void avatarChanged(const QString avatar);
    void jottingsChanged(const QString jottings);
    void interestChanged(const QString interest);
    void fansChanged(const QString fans);
    void jottingCountChanged(const QString jottingCount);
    void interestCountChanged(const QString interestCount);
    void fanCountChanged(const QString fansCount);
    void picPathChanged(const QString picPath);
    void requestPersonalRelationData();

//public slots:
//    void initData();

private:
    QString m_nickName;
    QString m_sign;
    QString m_avatar;
    QString m_jottings;
    QString m_picPath;
    QString m_interest = " ";
    QString m_fans = " ";
    QString m_jotting_count;
    QString m_interest_count;
    QString m_fan_count;
};

#endif // PERSONALUICONTROL_H
