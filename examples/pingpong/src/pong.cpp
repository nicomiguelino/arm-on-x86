// Copyright (C) 2016 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "ping-common.h"

#include <QObject>
#include <QCoreApplication>
#include <QDBusConnection>
#include <QDBusError>

#include <iostream>
#include <fstream>
#include <QDateTime>

class Pong : public QObject
{
    Q_OBJECT
public slots:
    QString ping(const QString &arg);
};

QString Pong::ping(const QString &arg)
{
    QString message = QString("ping(\"%1\") got called").arg(arg);
    qDebug("%s", qPrintable(message));
    return message;
}

int main(int argc, char **argv)
{
    QCoreApplication app(argc, argv);


    qInstallMessageHandler([](QtMsgType type, const QMessageLogContext &context, const QString &msg) {
        std::ofstream logFile("/tmp/main.log", std::ios_base::app);
        QString finalMessage = QString("[%1] %2\n").arg(QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss")).arg(msg);

        // Output 1: To console
        std::cerr << finalMessage.toStdString();

        // Output 2: To log file
        if (logFile.is_open()) {
            logFile << finalMessage.toStdString();
            logFile.close();
        } else {
            std::cerr << "Failed to open log file." << std::endl;
        }
    });

    auto connection = QDBusConnection::sessionBus();

    if (!connection.isConnected()) {
        qWarning("Cannot connect to the D-Bus session bus.\n"
                 "To start it, run:\n"
                 "\teval `dbus-launch --auto-syntax`\n");
        return 1;
    }

    if (!connection.registerService(SERVICE_NAME)) {
        qWarning("%s\n", qPrintable(connection.lastError().message()));
        exit(1);
    }

    Pong pong;
    connection.registerObject("/", &pong, QDBusConnection::ExportAllSlots);

    qDebug() << "PONG IS READY";

    return app.exec();
}

#include "pong.moc"
