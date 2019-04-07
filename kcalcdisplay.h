/*
Copyright (C) 2001 - 2013 Evan Teran
                          evan.teran@gmail.com

Copyright (C) 1996 - 2000 Bernd Johannes Wuebben
                          wuebben@kde.org

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 2 of 
the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef KCALCDISPLAY_H_
#define KCALCDISPLAY_H_

#include <QObject>
#include "knumber.h"
#include "kcalc_core.h"


#define NUM_STATUS_TEXT 4

enum NumBase {
    NB_BINARY  = 2,
    NB_OCTAL   = 8,
    NB_DECIMAL = 10,
    NB_HEX     = 16
};


class KCalcDisplay : public QObject
{

    Q_OBJECT

public:
    explicit KCalcDisplay(QObject *parent = nullptr);

    enum Event {
        EventReset, // resets display
        EventClear, // if no error reset display
        EventError,
        EventChangeSign
    };
    
    void deleteLastDigit();
    bool sendEvent(Event event);
    Q_INVOKABLE void enterDigit(int data);
    bool setAmount(const KNumber &new_amount);
    const KNumber &getAmount() const;
    void setText(const QString &string);
    QString formatDecimalNumber(QString string);
    QString groupDigits(const QString &displayString, int numDigits);
    void newCharacter(const QChar new_char);
    QString text() const;
    void updateDisplay();
    void updateFromCore(const CalcEngine &core,
                        bool store_result_in_history = false);
/*KCALC */

        enum UpdateFlag {
        UPDATE_FROM_CORE    = 1,
        UPDATE_STORE_RESULT = 2
    };
    
    Q_DECLARE_FLAGS(UpdateFlags, UpdateFlag)
    void updateDisplay(UpdateFlags flags);


Q_SIGNALS:
    void changedText(const QString &);
    void changedAmount(const KNumber &);

private:
    bool changeSign();
    QString text_;
    bool beep_;
    bool groupdigits_;
    bool twoscomplement_;
    int  binaryGrouping_;
    int  octalGrouping_;
    int  hexadecimalGrouping_;
    int  button_;
    bool lit_;
    NumBase num_base_;

    int precision_;
    int fixed_precision_; // "-1" = no fixed_precision

    QVector<KNumber> history_list_;
    int history_index_;
    
    KNumber display_amount_;
    
    bool eestate_;
    bool period_;
    bool neg_sign_;
    QString str_int_;
    QString str_int_exp_;
    QString str_status_[NUM_STATUS_TEXT];

    /* KCALC*/
    CalcEngine core;
};

#endif // KCALCDISPLAY_H
