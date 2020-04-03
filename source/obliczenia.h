#ifndef OBLICZENIA_H
#define OBLICZENIA_H

#include <QObject>

class Obliczenia : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int plec_ READ plec_ WRITE setPlec_ NOTIFY plec_Changed)
    Q_PROPERTY(int waga_ READ waga_ WRITE setWaga_ NOTIFY waga_Changed)
    Q_PROPERTY(int wzrost_ READ wzrost_ WRITE setWzrost_ NOTIFY wzrost_Changed)
    Q_PROPERTY(int wiek_ READ wiek_ WRITE setWiek_ NOTIFY wiek_Changed)
    Q_PROPERTY(int aktywnosc_ READ aktywnosc_ WRITE setAktywnosc_ NOTIFY aktywnosc_Changed)
    Q_PROPERTY(int plan_ READ plan_ WRITE setPlan_ NOTIFY plan_Changed)

private:
    int plec;
    int waga;
    int wzrost;
    int wiek;
    int aktywnosc;
    int plan;


public:
    explicit Obliczenia(QObject *parent = nullptr);

    int plec_();
    void setPlec_(int my_plec);

    int waga_();
    void setWaga_(int my_waga);

    int wzrost_();
    void setWzrost_(int my_wzrost);

    int wiek_();
    void setWiek_(int my_wiek);

    int aktywnosc_();
    void setAktywnosc_(int my_aktywsnosc);

    int plan_();
    void setPlan_(int my_plan);

    Q_INVOKABLE QList<int> licz();

signals:
    void plec_Changed();
    void waga_Changed();
    void wzrost_Changed();
    void wiek_Changed();
    void aktywnosc_Changed();
    void plan_Changed();
public slots:
};


#endif // OBLICZENIA_H

