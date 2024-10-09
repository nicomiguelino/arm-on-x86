#include <QApplication>
#include <QMainWindow>
#include <QWebEngineView>
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

    setCentralWidget(view);
}

int main(int argc, char * argv[])
{
    QApplication app(argc, argv);

    QUrl url = QUrl("http://www.google.com/ncr");

    MainWindow *browser = new MainWindow(url);
    browser->resize(1024, 768);
    browser->show();

    return app.exec();
}

#include "main.moc"
