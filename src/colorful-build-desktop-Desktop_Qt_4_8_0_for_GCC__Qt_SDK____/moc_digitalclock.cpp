/****************************************************************************
** Meta object code from reading C++ file 'digitalclock.h'
**
** Created: Fri Apr 6 22:19:22 2012
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../colorful/digitalclock.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'digitalclock.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_DigitalClock[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      14,   13,   13,   13, 0x0a,

 // methods: signature, parameters, type, tag, flags
      36,   13,   28,   13, 0x02,
      46,   13,   28,   13, 0x02,
      57,   13,   28,   13, 0x02,
      67,   13,   28,   13, 0x02,
      77,   13,   28,   13, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_DigitalClock[] = {
    "DigitalClock\0\0timerUpDate()\0QString\0"
    "getYear()\0getMonth()\0getDate()\0getTime()\0"
    "getWeek()\0"
};

void DigitalClock::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        DigitalClock *_t = static_cast<DigitalClock *>(_o);
        switch (_id) {
        case 0: _t->timerUpDate(); break;
        case 1: { QString _r = _t->getYear();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 2: { QString _r = _t->getMonth();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 3: { QString _r = _t->getDate();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 4: { QString _r = _t->getTime();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 5: { QString _r = _t->getWeek();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObjectExtraData DigitalClock::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject DigitalClock::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_DigitalClock,
      qt_meta_data_DigitalClock, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &DigitalClock::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *DigitalClock::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *DigitalClock::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_DigitalClock))
        return static_cast<void*>(const_cast< DigitalClock*>(this));
    return QObject::qt_metacast(_clname);
}

int DigitalClock::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
