// SPDX-License-Identifier: GPL-3.0-or-later
#include "AppSettings.h"
#include "TrayController.h"

#include <QApplication>
#include <QDir>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QStandardPaths>
#include <QSystemTrayIcon>
#include <QDebug>
#include <QIcon>
#include <QtWebEngineQuick/qtwebenginequickglobal.h>

int main(int argc, char *argv[])
{
    QtWebEngineQuick::initialize();
    QApplication app(argc, argv);
    QCoreApplication::setOrganizationName(QStringLiteral("Barnak"));
    QCoreApplication::setApplicationName(QStringLiteral("EQ-RSS Reader"));
    QCoreApplication::setApplicationVersion(QStringLiteral("1.0.0"));
    QApplication::setQuitOnLastWindowClosed(false);
    QApplication::setWindowIcon(QIcon(QStringLiteral(":/eq-rssnews.svg")));
    QIcon::setThemeSearchPaths({QStringLiteral(":/icons")});
    QIcon::setThemeName(QStringLiteral("eq"));

    const QString dataPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir().mkpath(dataPath + QStringLiteral("/Databases"));

    AppSettings settings;
    TrayController tray;
    QQmlApplicationEngine engine;
    engine.setOfflineStoragePath(dataPath + QStringLiteral("/Databases"));
    engine.rootContext()->setContextProperty(QStringLiteral("appSettings"), &settings);
    engine.rootContext()->setContextProperty(QStringLiteral("trayController"), &tray);

    const QUrl mainUrl(QStringLiteral("qrc:/qt/qml/EQRSS/Main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [&tray, mainUrl](QObject *object, const QUrl &url) {
        if (!object && url == mainUrl) {
            QCoreApplication::exit(-1);
            return;
        }
        if (auto *window = qobject_cast<QQuickWindow *>(object)) {
            tray.setWindow(window);
            window->show();
        }
    }, Qt::QueuedConnection);

    engine.load(mainUrl);
    if (engine.rootObjects().isEmpty())
        return -1;

    if (!QSystemTrayIcon::isSystemTrayAvailable())
        qWarning() << "Windows system tray is not currently available.";

    return app.exec();
}
