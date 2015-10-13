#ifndef CANDRIVER_H
#define CANDRIVER_H

#include <QObject>

class CANDriver : public QObject
{
    Q_OBJECT
public:
    explicit CANDriver(QObject *parent = 0);

    Q_INVOKABLE int initialize();

signals:
    void errorOccured(const QString & errorText);

public slots:
};

#endif // CANDRIVER_H
