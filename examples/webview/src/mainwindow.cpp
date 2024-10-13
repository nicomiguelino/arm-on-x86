#include <QUrl>
#include <QWebEngineSettings>

#include "mainwindow.h"

MainWindow::MainWindow(const QUrl& url)
{
    view = new QWebEngineView(this);
    view->load(url);

    view->settings()->setAttribute(QWebEngineSettings::ShowScrollBars, false);

    setCentralWidget(view);
}
