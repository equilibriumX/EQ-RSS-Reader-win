// SPDX-License-Identifier: GPL-3.0-or-later
#include "TrayController.h"

#include <QAction>
#include <QApplication>
#include <QMenu>
#include <QQuickWindow>
#include <QIcon>

TrayController::TrayController(QObject *parent)
    : QObject(parent), m_tray(QIcon(QStringLiteral(":/eq-rssnews.svg")), this)
{
    m_tray.setToolTip(QStringLiteral("EQ-RSS Reader"));

    auto *menu = new QMenu;
    menu->setParent(this);
    auto *openAction = menu->addAction(QStringLiteral("Open EQ-RSS Reader"));
    connect(openAction, &QAction::triggered, this, &TrayController::showWindow);
    menu->addSeparator();
    auto *exitAction = menu->addAction(QStringLiteral("Exit"));
    connect(exitAction, &QAction::triggered, this, &TrayController::quitApplication);
    m_tray.setContextMenu(menu);

    connect(&m_tray, &QSystemTrayIcon::activated, this,
            [this](QSystemTrayIcon::ActivationReason reason) {
        if (reason == QSystemTrayIcon::Trigger || reason == QSystemTrayIcon::DoubleClick)
            toggleWindow();
    });
    m_tray.show();
}

void TrayController::setWindow(QQuickWindow *window)
{
    m_window = window;
}

void TrayController::showWindow()
{
    if (!m_window)
        return;
    m_window->show();
    m_window->raise();
    m_window->requestActivate();
}

void TrayController::hideWindow()
{
    if (m_window)
        m_window->hide();
}

void TrayController::toggleWindow()
{
    if (!m_window)
        return;
    if (m_window->isVisible())
        hideWindow();
    else
        showWindow();
}

void TrayController::quitApplication()
{
    m_tray.hide();
    QCoreApplication::quit();
}
