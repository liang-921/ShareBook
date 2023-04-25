#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "fileopendialog.h"
#include "personaluicontrol.h"
#include "pushpagecontrol.h"
#include "publishpagecontrol.h"
#include "videopagecontrol.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    qmlRegisterType<PersonalUIControl>("UIControl",1,0,"PersonalUIControl");
    qmlRegisterType<PushPageControl>("UIControl",1,0,"PushPageControl");
    qmlRegisterType<PublishPageControl>("UIControl",1,0,"PublishPageControl");
    qmlRegisterType<VideoPageControl>("UIControl", 1, 0, "VideoPageControl");
    qmlRegisterType<FileOpenDialog>("UIControl", 1, 0, "FileOpenDialog");
//    qmlRegisterType<FileSaveDialog>("MyModules", 1, 0, "FileSaveDialog");

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/UI_ShareBook/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
