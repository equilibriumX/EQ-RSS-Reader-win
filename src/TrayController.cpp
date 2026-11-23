// SPDX-License-Identifier: GPL-3.0-or-later

#include "TrayController.h"

#include <QAction>
#include <QApplication>
#include <QCoreApplication>
#include <QMenu>
#include <QQuickWindow>
#include <QIcon>

TrayController::TrayController(QObject *parent)
    : QObject(parent),
      m_tray(QIcon(QStringLiteral(":/eq-rssnews.svg")), this)
{
    m_tray.setToolTip(QStringLiteral("EQ-RSS Reader"));

    // Create tray context menu.
    // The menu is managed explicitly by TrayController.
    m_menu = new QMenu;

    auto *openAction = m_menu->addAction(
        QStringLiteral("Open EQ-RSS Reader")
    );

    connect(openAction, &QAction::triggered,
            this, &TrayController::showWindow);

    m_menu->addSeparator();

    auto *exitAction = m_menu->addAction(
        QStringLiteral("Exit")
    );

    connect(exitAction, &QAction::triggered,
            this, &TrayController::quitApplication);

    m_tray.setContextMenu(m_menu);

    // Handle tray icon activation.
    connect(&m_tray, &QSystemTrayIcon::activated,
            this,
            [this](QSystemTrayIcon::ActivationReason reason) {

        if (reason == QSystemTrayIcon::Trigger ||
            reason == QSystemTrayIcon::DoubleClick) {
            toggleWindow();
        }
    });

    m_tray.show();
}

TrayController::~TrayController()
{
    // Detach the menu before destroying it.
    m_tray.setContextMenu(nullptr);

    m_tray.hide();

    delete m_menu;
    m_menu = nullptr;
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
