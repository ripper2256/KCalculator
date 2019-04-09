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
    Q_INVOKABLE void slotPercentclicked();
    Q_INVOKABLE void slotBackspaceclicked();
    Q_INVOKABLE void slotMemStoreclicked();
    Q_INVOKABLE void enterDigit(int data);
    Q_INVOKABLE void slotMemClearclicked();
    Q_INVOKABLE void slotMemRecallclicked();
    Q_INVOKABLE void slotParenCloseclicked();
    Q_INVOKABLE void slotParenOpenclicked();
    Q_INVOKABLE void slotMemPlusMinusclicked();
    Q_INVOKABLE void slotShifttoggled(bool myboolean);
    Q_INVOKABLE void copy();
    Q_INVOKABLE void cut();
    Q_INVOKABLE void paste();
    void updateDisplay(UpdateFlags flags);
    QString text() const;
    void setText(const QString &string);
/*
    Q_SIGNALS:
    void switchMode(ButtonModeFlags, bool);
  */  
    signals:
        void changedText();
protected Q_SLOTS:
    void EnterEqual();

private:
    
    enum StatusField {
        ShiftField = 0,
        BaseField,
        AngleField,
        MemField
    };
	
    enum AngleMode {
        DegMode = 0,
        RadMode,
        GradMode
    };
    
	enum BaseMode {
        BinMode = 2,
        OctMode = 8,
        DecMode = 10,
        HexMode = 16
    };

    bool shift_mode_;
    bool hyp_mode_;
    CalcEngine core;
    KCalcDisplay calc_display;
    QString text_;
    KNumber memory_num_;

};

Q_DECLARE_OPERATORS_FOR_FLAGS(KCalculator::UpdateFlags)
#endif
