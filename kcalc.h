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

#ifndef KCALC_H_
#define KCALC_H_

#include <QObject>
#include "kcalc_core.h"
#include "kcalcdisplay.h"

class KCalculator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text_ WRITE setText READ text NOTIFY changedText)


    public:
    explicit KCalculator(QObject *parent = nullptr);

        enum UpdateFlag {
        UPDATE_FROM_CORE    = 1,
        UPDATE_STORE_RESULT = 2
    };

    Q_DECLARE_FLAGS(UpdateFlags, UpdateFlag)
    Q_INVOKABLE void slotPlusclicked();
    Q_INVOKABLE void slotMinusclicked();
    Q_INVOKABLE void slotDivisionclicked();
    Q_INVOKABLE void slotMultiplicationclicked();
    Q_INVOKABLE void slotEqualclicked();
    Q_INVOKABLE void slotClearclicked();
    Q_INVOKABLE void slotAllClearclicked();
    Q_INVOKABLE void slotPlusMinusclicked();
    Q_INVOKABLE void slotPeriodclicked();
    Q_INVOKABLE void enterDigit(int data);
    void updateDisplay(UpdateFlags flags);
    QString text() const;
    void setText(const QString &string);

    signals:
        void changedText();


private:
    CalcEngine core;
    KCalcDisplay calc_display;
    QString text_;

};
#endif
