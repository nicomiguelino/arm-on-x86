#pragma once

#include <QMainWindow>
#include <QWebEngineView>

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(const QUrl& url);

private:
    QWebEngineView *view;
};
