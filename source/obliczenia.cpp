#include "obliczenia.h"
#include <QDebug>

Obliczenia::Obliczenia(QObject *parent) : QObject(parent)
{
    /*
    plec = 0;
    waga = 0;
    wzrost = 0;
    wiek = 0;
    aktywnosc = 0;
    plan = 0;
    */
}

int Obliczenia::plec_()
{
    return plec;
}

void Obliczenia::setPlec_(int my_plec)
{
    plec = my_plec;
    emit plec_Changed();
}

int Obliczenia::waga_()
{
    return waga;
}

void Obliczenia::setWaga_(int my_waga)
{
    waga = my_waga;
    emit waga_Changed();
}

int Obliczenia::wzrost_()
{
    return wzrost;
}

void Obliczenia::setWzrost_(int my_wzrost)
{
    wzrost = my_wzrost;
    emit wzrost_Changed();
}

int Obliczenia::wiek_()
{
    return wiek;
}

void Obliczenia::setWiek_(int my_wiek)
{
    wiek = my_wiek;
    emit wiek_Changed();
}

int Obliczenia::aktywnosc_()
{
    return aktywnosc;
}

void Obliczenia::setAktywnosc_(int my_aktywsnosc)
{
    aktywnosc = my_aktywsnosc;
    emit aktywnosc_Changed();
}

int Obliczenia::plan_()
{
    return plan;
}

void Obliczenia::setPlan_(int my_plan)
{
    plan = my_plan;
    emit plan_Changed();
}


QList <int> Obliczenia::licz()
{
    QList <int> myList;
    int BMR = 0;
    int CPM = 0;
    int tluszcze_kcal =0;
    int wegle_kcal  =0;
    int bialko_gr = 0;
    int bialko_kcal = 0;
    if(plec == 0){
        BMR = int(655 + (9.6*waga) + (1.8*wzrost) - (4.7*wiek));
    }
    else{
       BMR = int(66 + 13.7*waga + 5*wzrost - 6.76*wiek);
    }

    if(aktywnosc == 0)
        CPM = int(1.2 * BMR);
    else if(aktywnosc == 1)
        CPM = int (1.4 * BMR);
    else if (aktywnosc == 2)
        CPM = int (1.55 * BMR);
    else if (aktywnosc == 3)
        CPM = int (1.7 * BMR);
    else if (aktywnosc == 4) {
        CPM = int (1.9 * BMR);
    }
    else{
        CPM = 0;
    }

    if(plan == 0)
        CPM = CPM +300;
    else if(plan == 2)
        CPM = CPM - 300;
    else{
        CPM = CPM;
    }

    if(plan == 0 || plan == 1 ){
        bialko_gr = waga * 2;
        bialko_kcal = bialko_gr * 4;
        tluszcze_kcal = int(0.25 * CPM);
        wegle_kcal = CPM - bialko_kcal - tluszcze_kcal;
     }
    else{
        bialko_gr = int(waga *2.2);
        bialko_kcal = bialko_gr * 4;
        tluszcze_kcal = int(0.2 * CPM);
        wegle_kcal = CPM - bialko_kcal - tluszcze_kcal;
    }
    myList.append(BMR);
    myList.append(CPM);
    myList.append(bialko_kcal);
    myList.append(tluszcze_kcal);
    myList.append(wegle_kcal);

    return myList;
}

