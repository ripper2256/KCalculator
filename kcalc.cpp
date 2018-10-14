/*
Copyright (C) 2001 - 2013 Evan Teran
                          evan.teran@gmail.com

Copyright (C) 2006        Michel Marti
                          mma@objectxp.com

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
#include <QLocale>
#include "kcalc.h"
#include "kcalcdisplay.h"

KCalculator::KCalculator() {
    
}

void KCalculator::slotPlusclicked() {
	core.enterOperation(calc_display.getAmount(), CalcEngine::FUNC_ADD);
 	updateDisplay(UPDATE_FROM_CORE);
}

void KCalculator::updateDisplay(UpdateFlags flags) {

	if(flags & UPDATE_FROM_CORE) {
		calc_display.updateFromCore(core, (flags & UPDATE_STORE_RESULT) != 0);
	} else {
// 		update();
	}

// 	pbShift->setChecked(false);

}

void KCalculator::slotMinusclicked() {

    core.enterOperation(calc_display.getAmount(), CalcEngine::FUNC_SUBTRACT);
    updateDisplay(UPDATE_FROM_CORE);
}

void KCalculator::slotMultiplicationclicked() {

	core.enterOperation(calc_display.getAmount(), CalcEngine::FUNC_MULTIPLY);
	updateDisplay(UPDATE_FROM_CORE);
}

void KCalculator::slotDivisionclicked() {

    core.enterOperation(calc_display.getAmount(), CalcEngine::FUNC_DIVIDE);
    updateDisplay(UPDATE_FROM_CORE);
}

void KCalculator::slotEqualclicked() {
    core.enterOperation(calc_display.getAmount(), CalcEngine::FUNC_EQUAL);
    updateDisplay(UPDATE_FROM_CORE);
}

void KCalculator::slotAllClearclicked() {

	core.Reset();
    calc_display.sendEvent(KCalcDisplay::EventReset);
	updateDisplay(UPDATE_FROM_CORE);
}

void KCalculator::slotClearclicked() {

     calc_display.sendEvent(KCalcDisplay::EventClear);
}

void KCalculator::slotPlusMinusclicked() {

	// display can only change sign, when in input mode, otherwise we
	// need the core to do this.
	if (!calc_display.sendEvent(KCalcDisplay::EventChangeSign)) {
		core.InvertSign(calc_display.getAmount());
		updateDisplay(UPDATE_FROM_CORE);
	}
}

void KCalculator::slotPeriodclicked() {

	// i know this isn't locale friendly, should be converted to appropriate
	// value at lower levels
    calc_display.newCharacter(QLocale().decimalPoint());
}
