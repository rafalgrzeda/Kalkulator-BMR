import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtCharts 2.2

Window {
    id: window
    visible: true
    width: 500
    maximumWidth: 500
    height: 600
    title: qsTr("Kalkulator zapotrzebowania kalorycznego")
    property variant array: [0,0,0,0,0]
    ScrollView{
        contentHeight: 1300
        height: window.height
        anchors.fill: parent
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        Rectangle{
            id: banner
            y:10
            width: frame.width
            height: 80
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                text: "Kalkulator BMR"
                anchors.centerIn: parent
                font.bold: true
                font.pointSize: 15
            }
        }

        Frame{
            id: frame
            width: 400
            anchors.top: banner.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            Column{
                anchors.fill: parent
                spacing: 8
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    RadioButton{
                        id: mezczyzna
                        checked: true
                        text: "Mężczyzna"

                    }
                    RadioButton{
                        id: kobieta
                        text: "Kobieta"
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle{
                        height: waga.height
                        width: 70
                        Text{
                            anchors.centerIn: parent
                            text: "Waga:"
                            font.bold: true
                            font.pixelSize: 15
                        }
                    }
                    TextField{
                        id: waga
                        placeholderText: "Waga [kg]"
                    }

                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle{
                        height: wzrost.height
                        width: 70
                        Text{
                            anchors.centerIn: parent
                            text: "Wzrost:"
                            font.bold: true
                            font.pixelSize: 15
                        }
                    }
                    TextField{
                        id: wzrost
                        placeholderText: "Wzrost [cm]"
                    }

                }

                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle{
                        height: wiek.height
                        width: 70
                        Text{
                            anchors.centerIn: parent
                            text: "Wiek:"
                            font.bold: true
                            font.pixelSize: 15
                        }
                    }
                    TextField{
                        id: wiek
                        placeholderText: "Wiek [lata]"
                    }

                }

                Text{
                    text: " Twoja aktywność fizyczna:"
                    font.bold: true
                    font.pixelSize: 15
                }

                ComboBox{
                    id: aktywnosc
                    width: frame.width - 20
                    model: ["Znikoma (brak ćwiczeń, praca siedząca)",
                        "Bardzo mała ( ćwiczenia raz na tydzień, praca lekka)",
                        "Umiarkowana (ćwiczenia 2 razy w tygodniu)",
                        "Duża (dość ciężki trening kilka razy w tygodniu)",
                        "Bardzo duża (przynajmniej 4 ciężkie treningi, praca fizyczna)"
                    ]
                }
                Text{
                    text: " Planuje:"
                    font.bold: true
                    font.pixelSize: 15
                }
                ComboBox{
                    id: plan
                    width: frame.width - 20
                    model: ["Chce przytyć",
                        "Chce utrzymać wagę",
                        "Chce schudnąć",
                    ]
                }
                MyButton{
                    width: 150
                    anchors.horizontalCenter: parent.horizontalCenter
                    tekst: "Oblicz"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if((waga.text >= 20 && waga.text <=250 ) && (wzrost.text >= 50 && wzrost.text <=2700 ) && (wiek.text >= 5 && wiek.text <=150 )){
                                obliczenia.waga_ = parseInt(waga.text);
                                obliczenia.wzrost_ = parseInt(wzrost.text)
                                obliczenia.wiek_ = parseInt(wiek.text)
                                if(mezczyzna.checked)
                                    obliczenia.plec_ = 1;
                                if(kobieta.checked)
                                    obliczenia.plec_ = 0;
                                obliczenia.aktywnosc_ = aktywnosc.currentIndex;
                                obliczenia.plan_ = plan.currentIndex;
                                array = obliczenia.licz();
                                frame2.visible = true;
                                rec.visible = true;
                            }
                            else{
                                console.log("Nieprawidłowe dane ")
                            }
                        }
                    }
                }
            }
        }
        Rectangle{
            id: rec
            visible: false
            width: frame.width
            height: 80
            anchors.top: frame.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                text: "Wyniki"
                anchors.centerIn: parent
                font.bold: true
                color: "steelblue"
                font.pointSize: 18
            }
        }
        Frame{
            id: frame2
            anchors.top: rec.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
            Column{
                spacing: 5
                Text{
                    text: "Twoja podstawowa przemiana materii wynosi:"
                    font.pointSize: 13
                }
                Text{
                    text: array[0] + " kcal"
                    font.pointSize: 20
                    color: "steelblue"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text{
                    text: "Aby zrealizować swój cel musisz dostarczyć: "
                    font.pointSize: 13
                }
                Text{
                    text: array[1] + " kcal"
                    font.pointSize: 20
                    color: "steelblue"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                ChartView {
                    id:mychart
                    title: "Podział makroskładników"
                    width: 400
                    height: 400
                    antialiasing: true
                    PieSeries {
                        id: pieSeries
                        PieSlice { label: "Białko " + Math.round((array[2]/(array[2]+array[3]+array[4]))*100)+"%"; value: array[2];      labelVisible: true; labelPosition: PieSlice.LabelInsideNormal; labelColor: "white"}
                        PieSlice { label: "Tłuszcze "  + Math.round((array[3]/(array[2]+array[3]+array[4]))*100)+"%"; value: array[3];   labelVisible: true; labelPosition: PieSlice.LabelInsideNormal; labelColor: "white"}
                        PieSlice { label: "Węglowodany "  + Math.round((array[4]/(array[2]+array[3]+array[4]))*100)+"%"; value: array[4];labelVisible: true; labelPosition: PieSlice.LabelInsideNormal; labelColor: "white"}
                    }
                }
                Row{
                    anchors.horizontalCenter: mychart.horizontalCenter
                    Text{
                        text: "Białko: "
                        font.pointSize: 14
                        font.bold: true
                        color: "steelblue"
                    }
                    Text{
                        text: array[2] + " kcal = "+ array[2]/4 + " g"
                        font.pointSize: 14
                    }
                }
                Row{
                    anchors.horizontalCenter: mychart.horizontalCenter
                    Text{
                        text: "Tłuszcze: "
                        font.pointSize: 14
                        font.bold: true
                        color: "steelblue"
                    }
                    Text{
                        text: array[3] + " kcal = "+ array[3]/4 + " g"
                        font.pointSize: 14
                    }
                }
                Row{
                    anchors.horizontalCenter: mychart.horizontalCenter
                    Text{
                        text: "Węglowodany: "
                        font.pointSize: 14
                        font.bold: true
                        color: "steelblue"
                    }
                    Text{
                        text: array[4] + " kcal = "+ array[4]/8 + " g"
                        font.pointSize: 14
                    }
                }
            }
        }
    }
}

