#include <QApplication>

#include "mainwindow.h"

int main(int argc, char * argv[])
{
    QApplication app(argc, argv);

    QString url_string = qgetenv("BROWSER_URL");
    QUrl url = url_string.isEmpty() ? QUrl("https://example.com") : QUrl(url_string);

    MainWindow *browser = new MainWindow(url);
    browser->resize(1920, 1080);
    browser->show();

    return app.exec();
}
