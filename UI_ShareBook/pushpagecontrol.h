#ifndef PUSHPAGECONTROL_H
#define PUSHPAGECONTROL_H

#include <QObject>

class PushPageControl:public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString recommendJottings READ getRecommendJottings WRITE setRecommendJottings NOTIFY recommendJottingsChanged)
    Q_PROPERTY(QString concernedJottings READ getConcernedJottings WRITE setConcernedJottings NOTIFY concernedJottingsChanged)
    Q_PROPERTY(QString localJottings READ getLocalJottings WRITE setLocalJottings NOTIFY localJottingsChanged)
    Q_PROPERTY(QString jotting READ getJotting WRITE setJotting NOTIFY jottingChanged)
    Q_PROPERTY(QString videos READ getVideos WRITE setVideos NOTIFY videosChanged)

public:
    explicit PushPageControl(QObject *parent=nullptr);

    Q_INVOKABLE void pushRecommendJottings();
    Q_INVOKABLE void pushConcernedJottings();
    Q_INVOKABLE void pushLocalJottings();
    Q_INVOKABLE void pushVideos();


    Q_INVOKABLE void receiveOneJotting(QString jotting_id);

    void setRecommendJottings(const QString &recommendJottings);
    QString getRecommendJottings()const;

    void setConcernedJottings(const QString &concernedJottings);
    QString getConcernedJottings()const;

    void setLocalJottings(const QString &localJottings);
    QString getLocalJottings()const;

    void setJotting(const QString &jotting);
    QString getJotting()const;

    void setVideos(const QString &videos);
    QString getVideos()const;

signals:
    void recommendJottingsChanged(const QString recommendJottings);
    void concernedJottingsChanged(const QString concernedJottings);
    void localJottingsChanged(const QString localJottings);
    void jottingChanged(const QString jotting);
    void videosChanged(const QString videos);

private:
    QString m_recommendJottings;
    QString m_concernedJottings;
    QString m_localJottings;
    QString m_jotting;
    QString m_videos;
};

#endif // PUSHPAGECONTROL_H
