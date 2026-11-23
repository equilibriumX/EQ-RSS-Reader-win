// SPDX-License-Identifier: GPL-3.0-or-later
#pragma once

#include <QObject>
#include <QPointer>
#include <QSystemTrayIcon>

class QQuickWindow;
class QMenu;

class TrayController final : public QObject
{
    Q_OBJECT
public:
    explicit TrayController(QObject *parent = nullptr);
    void setWindow(QQuickWindow *window);

    Q_INVOKABLE void showWindow();
    Q_INVOKABLE void hideWindow();
    Q_INVOKABLE void toggleWindow();
    Q_INVOKABLE void quitApplication();

private:
    QPointer<QQuickWindow> m_window;
    QSystemTrayIcon m_tray;
};
