// SPDX-License-Identifier: GPL-3.0-or-later
#include "AppSettings.h"

#include <QCoreApplication>
#include <QDir>
#include <QSettings>

#ifdef Q_OS_WIN
static const QString kRunRegistryPath =
    QStringLiteral("HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run");
static const QString kRunValueName = QStringLiteral("EQ-RSS Reader");
#endif

AppSettings::AppSettings(QObject *parent)
    : QObject(parent), m_settings(QStringLiteral("Barnak"), QStringLiteral("EQ-RSS Reader"))
{
}

int AppSettings::refreshMinutes() const
{
    return m_settings.value(QStringLiteral("refreshMinutes"), 15).toInt();
}

void AppSettings::setRefreshMinutes(int value)
{
    value = qBound(2, value, 1440);
    if (refreshMinutes() == value)
        return;
    m_settings.setValue(QStringLiteral("refreshMinutes"), value);
    emit refreshMinutesChanged();
}

int AppSettings::wideThreshold() const
{
    return m_settings.value(QStringLiteral("wideThreshold"), 700).toInt();
}

void AppSettings::setWideThreshold(int value)
{
    value = qBound(560, value, 1200);
    if (wideThreshold() == value)
        return;
    m_settings.setValue(QStringLiteral("wideThreshold"), value);
    emit wideThresholdChanged();
}

bool AppSettings::startWithWindows() const
{
#ifdef Q_OS_WIN
    QSettings runSettings(kRunRegistryPath, QSettings::NativeFormat);
    return runSettings.contains(kRunValueName);
#else
    return false;
#endif
}

void AppSettings::setStartWithWindows(bool enabled)
{
#ifdef Q_OS_WIN
    QSettings runSettings(kRunRegistryPath, QSettings::NativeFormat);
    if (enabled) {
        const QString executable = QDir::toNativeSeparators(QCoreApplication::applicationFilePath());
        runSettings.setValue(kRunValueName, QLatin1Char('"') + executable + QLatin1Char('"'));
    } else {
        runSettings.remove(kRunValueName);
    }
    runSettings.sync();
    emit startWithWindowsChanged();
#else
    Q_UNUSED(enabled);
#endif
}
