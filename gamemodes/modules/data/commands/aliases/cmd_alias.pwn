// Player
CMD:cancel(playerid, params[]) return callcmd::deny(playerid, params);
CMD:exit(playerid, params[]) return callcmd::enter(playerid, params);
CMD:en(playerid, params[]) return callcmd::enter(playerid, params);
CMD:ex(playerid, params[]) return callcmd::enter(playerid, params);
CMD:inv(playerid, params[]) return callcmd::inventory(playerid, params);
CMD:item(playerid, params[]) return callcmd::inventory(playerid, params);
CMD:items(playerid, params[]) return callcmd::inventory(playerid, params);
CMD:mail(playerid) return callcmd::email(playerid);
CMD:savestat(playerid, params[]) return callcmd::savestats(playerid, params);
CMD:saveme(playerid, params[]) return callcmd::savestats(playerid, params);
CMD:delay(playerid) return callcmd::time(playerid);
CMD:clearchat(playerid, params[]) return callcmd::cc(playerid, params);
CMD:whisper(playerid, params[]) return callcmd::w(playerid, params);
CMD:low(playerid, params[]) return callcmd::l(playerid, params);
CMD:shout(playerid, params[]) return callcmd::s(playerid, params);
CMD:shouts(playerid, params[]) return callcmd::s(playerid, params);
CMD:vchat(playerid, params[]) return callcmd::vc(playerid, params);
CMD:vipchat(playerid, params[]) return callcmd::vc(playerid, params);

// Admin
#include "alias_admin.pwn"

// House
CMD:unlockhouse(playerid, params[]) return callcmd::lockhouse(playerid, params);
CMD:myhouses(playerid) return callcmd::myhouse(playerid);
CMD:house(playerid) return callcmd::myhouse(playerid);
CMD:houses(playerid) return callcmd::myhouse(playerid);
CMD:storage(playerid, params[]) return callcmd::hm(playerid, params);
CMD:housemenu(playerid, params[]) return callcmd::hm(playerid, params);

// Bisnis
CMD:unlockbisnis(playerid, params[]) return callcmd::lockbisnis(playerid, params);
CMD:mybisnis(playerid) return callcmd::mybis(playerid);
CMD:bisnis(playerid) return callcmd::mybis(playerid);
CMD:bis(playerid) return callcmd::mybis(playerid);
CMD:bisnismenu(playerid, params[]) return callcmd::bm(playerid, params);

// Player Vehicle
CMD:destroypv(playerid, params[]) return callcmd::deletepv(playerid, params);
CMD:dveh(playerid, params[]) return callcmd::deletepv(playerid, params);
CMD:cars(playerid, params[]) return callcmd::apv(playerid, params);
CMD:makepv(playerid, params[]) return callcmd::createpv(playerid, params);
CMD:makeveh(playerid, params[]) return callcmd::createpv(playerid, params);