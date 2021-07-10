// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef CHUCKRUM_QT_CHUCKRUMADDRESSVALIDATOR_H
#define CHUCKRUM_QT_CHUCKRUMADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class ChuckrumAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit ChuckrumAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Chuckrum address widget validator, checks for a valid chuckrum address.
 */
class ChuckrumAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit ChuckrumAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // CHUCKRUM_QT_CHUCKRUMADDRESSVALIDATOR_H
