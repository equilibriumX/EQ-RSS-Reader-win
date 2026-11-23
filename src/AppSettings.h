// SPDX-License-Identifier: GPL-3.0-or-later
#pragma once

#include <QObject>
#include <QSettings>

class AppSettings final : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int refreshMinutes READ refreshMinutes WRITE setRefreshMinutes NOTIFY refreshMinutesChanged)
    Q_PROPERTY(int wideThreshold READ wideThreshold WRITE setWideThreshold NOTIFY wideThresholdChanged)
    Q_PROPERTY(bool startWithWindows READ startWithWindows WRITE setStartWithWindows NOTIFY startWithWindowsChanged)

public:
    explicit AppSettings(QObject *parent = nullptr);

    int refreshMinutes() const;
    void setRefreshMinutes(int value);

    int wideThreshold() const;
    void setWideThreshold(int value);

    bool startWithWindows() const;
    void setStartWithWindows(bool enabled);

signals:
    void refreshMinutesChanged();
    void wideThresholdChanged();
    void startWithWindowsChanged();

private:
    QSettings m_settings;
};
