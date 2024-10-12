#include <QApplication>
#include <QMainWindow>
#include <QWebEngineView>
#include <QWebEngineSettings>
#include <QUrl>

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(const QUrl& url);

private:
    QWebEngineView *view;
};

MainWindow::MainWindow(const QUrl& url)
{
    view = new QWebEngineView(this);
    view->load(url);

    view->settings()->setAttribute(QWebEngineSettings::ShowScrollBars, false);

    setCentralWidget(view);
}

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

#include "main.moc"
