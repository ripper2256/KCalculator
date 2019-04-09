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

#include "kcalcdisplay.h"
#include "knumber.h"
#include <knotification.h>
#include <QString>
#include <QApplication>
#include <QClipboard>

#include <QDebug>

KCalcDisplay::KCalcDisplay(QObject *parent) :
    QObject(parent), beep_(false), 
		groupdigits_(true), twoscomplement_(true), button_(0), lit_(false),
		num_base_(NB_DECIMAL), precision_(9), fixed_precision_(-1), history_index_(0), display_amount_(0)
		
{
}

QString KCalcDisplay::text() const {
    return text_;
}

bool KCalcDisplay::setAmount(const KNumber &new_amount) {

	QString display_str;

	str_int_ = QLatin1String("0");
	str_int_exp_.clear();
	period_   = false;
	neg_sign_ = false;
	eestate_  = false;

	if ((num_base_ != NB_DECIMAL) && (new_amount.type() != KNumber::TYPE_ERROR)) {
		display_amount_ = new_amount.integerPart();
	
		if (twoscomplement_) {
			// treat number as 64-bit unsigned
			const quint64 tmp_workaround = display_amount_.toUint64();
			display_str = QString::number(tmp_workaround, num_base_).toUpper();
		} else {
			// QString::number treats non-decimal as unsigned
			qint64 tmp_workaround = display_amount_.toInt64();
			const bool neg = tmp_workaround < 0;
			if (neg) {
				tmp_workaround = qAbs(tmp_workaround);
			}
			
			display_str = QString::number(tmp_workaround, num_base_).toUpper();
			if (neg) {
				display_str.prepend(QLocale().negativeSign());
			}
		}
	} else {
		// num_base_ == NB_DECIMAL || new_amount.type() == KNumber::TYPE_ERROR
		display_amount_ = new_amount;
		display_str = display_amount_.toQString(fixed_precision_, fixed_precision_);
	}

	setText(display_str);
	emit changedAmount(display_amount_);
	return true;
}


void KCalcDisplay::enterDigit(int data) {

	switch (data) {
	case 0: newCharacter(QLatin1Char('0')); break;
	case 1: newCharacter(QLatin1Char('1')); break;
	case 2: newCharacter(QLatin1Char('2')); break;
	case 3: newCharacter(QLatin1Char('3')); break;
	case 4: newCharacter(QLatin1Char('4')); break;
	case 5: newCharacter(QLatin1Char('5')); break;
	case 6: newCharacter(QLatin1Char('6')); break;
	case 7: newCharacter(QLatin1Char('7')); break;
	case 8: newCharacter(QLatin1Char('8')); break;
	case 9: newCharacter(QLatin1Char('9')); break;
	case 0xa: newCharacter(QLatin1Char('A')); break;
	case 0xb: newCharacter(QLatin1Char('B')); break;
	case 0xc: newCharacter(QLatin1Char('C')); break;
	case 0xd: newCharacter(QLatin1Char('D')); break;
	case 0xe: newCharacter(QLatin1Char('E')); break;
	case 0xf: newCharacter(QLatin1Char('F')); break;
	default:
		Q_ASSERT(0);
		break;
	}
}

void KCalcDisplay::newCharacter(const QChar new_char) {
	// test if character is valid
	switch (new_char.toLatin1()) {
	case 'e':
		// EE can be set only once and in decimal mode
		if (num_base_ != NB_DECIMAL || eestate_) {
			if (beep_) {
				KNotification::beep();
			}
			return;
		}
		eestate_ = true;
		break;

	case 'F':
	case 'E':
	case 'D':
	case 'C':
	case 'B':
	case 'A':
		if (num_base_ == NB_DECIMAL) {
			if (beep_) {
				KNotification::beep();
			}
			return;
		}
		// no break
	case '9':
	case '8':
		if (num_base_ == NB_OCTAL) {
			if (beep_) {
				KNotification::beep();
			}
			return;
		}
		// no break
	case '7':
	case '6':
	case '5':
	case '4':
	case '3':
	case '2':
		if (num_base_ == NB_BINARY) {
			if (beep_) {
				KNotification::beep();
			}
			return;
		}
		// no break
	case '1':
	case '0':
		break;

	default:
		if(new_char == QLocale().decimalPoint()) {
			// Period can be set only once and only in decimal
			// mode, also not in EE-mode
			if (num_base_ != NB_DECIMAL || period_ || eestate_) {
				if (beep_) {
					KNotification::beep();
				}
				return;
			}
			period_ = true;
		} else {
			if (beep_) {
				KNotification::beep();
			}
			return;
		}
	}

	// change exponent or mantissa
	if (eestate_) {
		// ignore '.' before 'e'. turn e.g. '123.e' into '123e'
		if (new_char == QLatin1Char('e') && str_int_.endsWith(QLocale().decimalPoint())) {
			str_int_.chop(1);
			period_ = false;
		}

		// 'e' only starts ee_mode, leaves strings unchanged
		// do not add '0' if at start of exp
		if (new_char != QLatin1Char('e')  && !(str_int_exp_.isNull() && new_char == QLatin1Char('0'))) {
			str_int_exp_.append(new_char);
		}
	} else {
		// handle first character
		if (str_int_ == QLatin1String("0")) {
			switch (new_char.toLatin1()) {
			case 'e':
				// display "0e" not just "e"
				// "0e" does not make sense either, but...
				str_int_.append(new_char);
				break;
			default:
				if(new_char == QLocale().decimalPoint()) {
					// display "0." not just "."
					str_int_.append(new_char);
				} else {
					// no leading '0's
					str_int_[0] = new_char;
				}
			}
		} else {
			str_int_.append(new_char);
		}
	}

 	updateDisplay();
}

const KNumber &KCalcDisplay::getAmount() const {
	return display_amount_;
}

void KCalcDisplay::setText(const QString &string)
{
    // note that "C" locale is being used internally
    text_ = string;
    
	// don't mess with special numbers
    const bool special = (string.contains(QLatin1String("nan")) || string.contains(QLatin1String("inf")));
	
	// The decimal mode needs special treatment for two reasons, because: a) it uses KGlobal::locale() to get a localized 
	// format and b) it has possible numbers after the decimal place. Neither applies to Binary, Hexadecimal or Octal.
	
	if ((groupdigits_ || num_base_ == NB_DECIMAL) && !special){
		switch (num_base_) {
		case NB_DECIMAL:
			text_ = formatDecimalNumber(text_);
			break;
			
		case NB_BINARY:
			text_ = groupDigits(text_, binaryGrouping_);
			break;
		
		case NB_OCTAL:
			text_ = groupDigits(text_, octalGrouping_);
			break;
			
		case NB_HEX:
			text_ = groupDigits(text_, hexadecimalGrouping_);
			break;
		}
    } else if(special) {
#if 0
		// TODO: enable this code, it replaces the "inf" with an actual infinity
		//       symbol, but what should be put into the clip board when they copy?
		if(string.contains(QLatin1String("inf"))) {
			text_.replace("inf", QChar(0x221e));
		}
#endif
	}
//     update();
    emit changedText(text_);
}

QString KCalcDisplay::formatDecimalNumber(QString string)
{
	QLocale locale;

	string.replace(QLatin1Char('.'), locale.decimalPoint());

	if (groupdigits_ && !(locale.numberOptions() & QLocale::OmitGroupSeparator)) {
		// find position after last digit
		int pos = string.indexOf(locale.decimalPoint());
		if (pos < 0) {
			// do not group digits after the exponent part
			const int expPos = string.indexOf(QLatin1Char('e'));
			if (expPos > 0) {
				pos = expPos;
			} else {
				pos = string.length();
			}
		}

		// find first digit to not group leading spaces or signs
		int firstDigitPos = 0;
		for (int i = 0; i < string.length(); ++i) {
			if (string.at(i).isDigit()) {
				firstDigitPos = i;
				break;
			}
		}

		const QChar groupSeparator = locale.groupSeparator();
		const int groupSize = 3;

		string.reserve(string.length() + (pos - 1) / groupSize);
		while ((pos -= groupSize) > firstDigitPos) {
			string.insert(pos, groupSeparator);
		}
	}

	string.replace(QLatin1Char('-'), locale.negativeSign());
	string.replace(QLatin1Char('+'), locale.positiveSign());

	unsigned short zero = locale.zeroDigit().unicode();
	for (int i = 0; i < string.length(); ++i) {
		if (string.at(i).isDigit()) {
			string[i] = QChar(zero + string.at(i).digitValue());
		}
	}

	return string;
}

void KCalcDisplay::deleteLastDigit() {

	// Only partially implemented !!
	if (eestate_) {
		if (str_int_exp_.isNull()) {
			eestate_ = false;
		} else {
			const int length = str_int_exp_.length();
			if (length > 1) {
				str_int_exp_.chop(1);
			} else {
				str_int_exp_ = QLatin1String((const char *)nullptr);
			}
		}
	} else {
		const int length = str_int_.length();
		if (length > 1) {
			if (str_int_[length-1] == QLocale().decimalPoint()) {
				period_ = false;
			}
			str_int_.chop(1);
		} else {
			Q_ASSERT(!period_);
			str_int_[0] = QLatin1Char('0');
		}
	}

	updateDisplay();
}


QString KCalcDisplay::groupDigits(const QString &displayString, int numDigits) {

	QString tmpDisplayString;
	const int stringLength = displayString.length();

	for (int i = stringLength; i > 0 ; i--){
		if(i % numDigits == 0 && i != stringLength) {
			tmpDisplayString = tmpDisplayString + ' ';
		}

		tmpDisplayString = tmpDisplayString + displayString[stringLength - i];
	}

	return tmpDisplayString;
}

void KCalcDisplay::updateDisplay() {

	// Put sign in front.
	QString tmp_string;
	if (neg_sign_) {
		tmp_string = QLatin1Char('-') + str_int_;
	} else {
		tmp_string = str_int_;
	}

	bool ok;

	switch (num_base_) {
	case NB_BINARY:
		Q_ASSERT(!period_ && !eestate_);
		setText(tmp_string);
		display_amount_ = KNumber(str_int_.toULongLong(&ok, 2));
		if (neg_sign_) {
			display_amount_ = -display_amount_;
		}
		break;

	case NB_OCTAL:
		Q_ASSERT(!period_ && !eestate_);
		setText(tmp_string);
		display_amount_ = KNumber(str_int_.toULongLong(&ok, 8));
		if (neg_sign_) {
			display_amount_ = -display_amount_;
		}
		break;

	case NB_HEX:
		Q_ASSERT(!period_ && !eestate_);
		setText(tmp_string);
		display_amount_ = KNumber(str_int_.toULongLong(&ok, 16));
		if (neg_sign_) {
			display_amount_ = -display_amount_;
		}
		break;

	case NB_DECIMAL:
		if (!eestate_) {
			setText(tmp_string);
			display_amount_ = KNumber(tmp_string);
		} else {
			if (str_int_exp_.isNull()) {
				// add 'e0' to display but not to conversion
				display_amount_ = KNumber(tmp_string);
				setText(tmp_string + QLatin1String("e0"));
			} else {
				tmp_string +=  QLatin1Char('e') + str_int_exp_;
				setText(tmp_string);
				display_amount_ = KNumber(tmp_string);
			}
		}
		break;

	default:
		Q_ASSERT(0);
	}

	//emit changedAmount(display_amount_);
}

void KCalcDisplay::updateFromCore(const CalcEngine &core, bool store_result_in_history) {

	bool tmp_error;
	const KNumber &output = core.lastOutput(tmp_error);

#if 0
	// TODO: do we really need explicit error tracking?
	// isn't the type of the KNumber good enough?
	// I think it is and that this error tracking is cruft
	// left over from a LONG time ago...
	if(output.type() == KNumber::TYPE_ERROR) {
#else
	if (tmp_error) {
#endif
		sendEvent(EventError);
	}
	
	if (setAmount(output) && store_result_in_history && (output != KNumber::Zero)) {
		// add this latest value to our history
		history_list_.insert(history_list_.begin(), output);
		history_index_ = 0;
	}
}

bool KCalcDisplay::sendEvent(Event event) {

	switch (event) {
	case EventClear:
	case EventReset:
		display_amount_ = KNumber::Zero;
		str_int_ = QLatin1String("0");
		str_int_exp_.clear();

		eestate_ = false;
		period_ = false;
		neg_sign_ = false;

		updateDisplay();

		return true;
	
	case EventChangeSign:
		return changeSign();
	
	case EventError:
		updateDisplay();
		return true;
		
	default:
		return false;
	}
}

bool KCalcDisplay::changeSign() {

	//stupid way, to see if in input_mode or display_mode
	if (str_int_ == QLatin1String("0")) {
		return false;
	}

	if (eestate_) {
		if (!str_int_exp_.isNull()) {
			if (str_int_exp_[0] != QLatin1Char('-')) {
				str_int_exp_.prepend(QLatin1Char('-'));
			} else {
				str_int_exp_.remove(QLatin1Char('-'));
			}
		}
	} else {
		neg_sign_ = !neg_sign_;
	}

	updateDisplay();
	return true;
}

void KCalcDisplay::slotCut() {

    slotCopy();
    sendEvent(EventReset);
}

void KCalcDisplay::slotCopy() {

	QString txt = text_;

	switch(num_base_) {
	case NB_HEX:
		txt.prepend(QLatin1String("0x"));
		txt.remove(QLatin1Char(' '));
		break;
	case NB_BINARY:
		txt.prepend(QLatin1String("0b"));
		txt.remove(QLatin1Char(' '));
		break;
	case NB_OCTAL:
		txt.prepend(QLatin1String("0"));
		txt.remove(QLatin1Char(' '));
		break;
	case NB_DECIMAL:
		txt.remove(QLocale().groupSeparator());
		break;
	}

	(QApplication::clipboard())->setText(txt, QClipboard::Clipboard);
	(QApplication::clipboard())->setText(txt, QClipboard::Selection);
}

//------------------------------------------------------------------------------
// Name: slotPaste
// Desc: 
//------------------------------------------------------------------------------
void KCalcDisplay::slotPaste(bool bClipboard) {

	QString tmp_str = (QApplication::clipboard())->text(bClipboard ? QClipboard::Clipboard : QClipboard::Selection);

	if (tmp_str.isNull()) {
		if (beep_) {
			KNotification::beep();
		}
		return;
	}

	NumBase tmp_num_base = num_base_;

	// fix up string
	tmp_str = tmp_str.trimmed();
	
	if (groupdigits_) {
		tmp_str.remove(QLocale().groupSeparator());
	}
	
	tmp_str = tmp_str.toLower();

	// determine base
	if (tmp_str.startsWith(QLatin1String("0x"))) {
		tmp_num_base = NB_HEX;
		tmp_str.remove(0, 2);
	} else if (tmp_str.startsWith(QLatin1String("0b"))) {
		tmp_num_base = NB_BINARY;
		tmp_str.remove(0, 2);
	} else if (tmp_str.startsWith(QLatin1String("0"))) {
		// we don't want this to trigger on "0.xxxxxx" cases
		if(tmp_str.length() < 2 || QString(tmp_str[1]) != KNumber::decimalSeparator()) {
			tmp_num_base = NB_OCTAL;
			tmp_str.remove(0, 1);
		}
	}

	if (tmp_num_base != NB_DECIMAL) {
		bool was_ok;
		const qint64 tmp_result = tmp_str.toULongLong(&was_ok, tmp_num_base);

		if (!was_ok) {
			setAmount(KNumber::NaN);
			if (beep_) {
				KNotification::beep();
			}
			return;
		}
		setAmount(KNumber(tmp_result));
	} else {
		setAmount(KNumber(tmp_str));
		if (beep_ && display_amount_ == KNumber::NaN) {
			KNotification::beep();
		}
	}
}


/** Start: KCalculator */


void KCalcDisplay::updateDisplay(UpdateFlags flags) {

	if(flags & UPDATE_FROM_CORE) {
		updateFromCore(core, (flags & UPDATE_STORE_RESULT) != 0);
	} else {
// 		update();
	}

// 	pbShift->setChecked(false);

}
