import QtQuick 2.0

Rectangle{
    property alias tekst: mytext.text
    id: rec_button_1
    width: 180
    height: 40
    border.color: "steelblue"
    border.width: 3

    Text{
        id: mytext
        text: "DOMYSLNY"
        font.bold: true
        font.pointSize: 8
        color: "black"
        anchors.centerIn: parent
    }
}
