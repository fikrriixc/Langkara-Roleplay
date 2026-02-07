//-----------[ Admin Commands Alias ]--------------
CMD:admin(playerid, params[]) return callcmd::admins(playerid, params);
CMD:helpers(playerid, params[]) return callcmd::admins(playerid, params);
CMD:helper(playerid, params[]) return callcmd::admins(playerid, params);
CMD:staff(playerid, params[]) return callcmd::admins(playerid, params);

//Admin Level 6
CMD:makeadminlevel(playerid, params[]) return callcmd::setadminlevel(playerid, params);
CMD:setcoin(playerid, params[]) return callcmd::setgold(playerid, params);
CMD:givecoin(playerid, params[]) return callcmd::givegold(playerid, params);

// Admin Level 5
CMD:makehelperlevel(playerid, params[]) return callcmd::sethelperlevel(playerid, params);
CMD:setaname(playerid, params[]) return callcmd::setadminname(playerid, params);
CMD:setcash(playerid, params[]) return callcmd::setmoney(playerid, params);
CMD:givecash(playerid, params[]) return callcmd::givemoney(playerid, params);
CMD:setbmoney(playerid, params[]) return callcmd::setbankmoney(playerid, params);
CMD:setbankcash(playerid, params[]) return callcmd::setbankmoney(playerid, params);
CMD:setbcash(playerid, params[]) return callcmd::setbankmoney(playerid, params);
CMD:givebmoney(playerid, params[]) return callcmd::givebankmoney(playerid, params);
CMD:givebankcash(playerid, params[]) return callcmd::givebankmoney(playerid, params);
CMD:givebcash(playerid, params[]) return callcmd::givebankmoney(playerid, params);

//Admin Level 4
CMD:settempvip(playerid, params[]) return callcmd::setvip(playerid, params);
CMD:makedonator(playerid, params[]) return callcmd::setvip(playerid, params);
CMD:setdonator(playerid, params[]) return callcmd::setvip(playerid, params);
CMD:setpremium(playerid, params[]) return callcmd::setvip(playerid, params);
CMD:finemoney(playerid, params[]) return callcmd::takemoney(playerid, params);
CMD:takecash(playerid, params[]) return callcmd::takemoney(playerid, params);
CMD:finecash(playerid, params[]) return callcmd::takemoney(playerid, params);
CMD:finegold(playerid, params[]) return callcmd::takegold(playerid, params);
CMD:takecoin(playerid, params[]) return callcmd::takegold(playerid, params);
CMD:finecoin(playerid, params[]) return callcmd::takegold(playerid, params);
CMD:makefaction(playerid, params[]) return callcmd::setfaction(playerid, params);
CMD:makeleader(playerid, params[]) return callcmd::setleader(playerid, params);
CMD:givegun(playerid, params[]) return callcmd::giveweap(playerid, params);

//Admin Level 3
CMD:ipban(playerid, params[]) return callcmd::banip(playerid, params);
CMD:bannedip(playerid, params[]) return callcmd::banip(playerid, params);
CMD:ipunban(playerid, params[]) return callcmd::unbanip(playerid, params);
CMD:unbannedip(playerid, params[]) return callcmd::unbanip(playerid, params);

//Admin Level 2
CMD:fixveh(playerid, params[]) return callcmd::afix(playerid, params);
CMD:repairveh(playerid, params[]) return callcmd::afix(playerid, params);
CMD:arepair(playerid, params[]) return callcmd::afix(playerid, params);
CMD:sethealth(playerid, params[]) return callcmd::sethp(playerid, params);
CMD:setheal(playerid, params[]) return callcmd::sethp(playerid, params);
CMD:setarmour(playerid, params[]) return callcmd::setam(playerid, params);
CMD:setarmor(playerid, params[]) return callcmd::setam(playerid, params);

//Admin Level 1
CMD:ahelp(playerid) return callcmd::acmds(playerid);
CMD:ah(playerid) return callcmd::acmds(playerid);
CMD:hhelp(playerid) return callcmd::hcmds(playerid);
CMD:hh(playerid) return callcmd::hcmds(playerid);
CMD:ainv(playerid, params[]) return callcmd::ainventory(playerid, params);
CMD:aitem(playerid, params[]) return callcmd::ainventory(playerid, params);
CMD:aitems(playerid, params[]) return callcmd::ainventory(playerid, params);
CMD:check(playerid, params[]) return callcmd::astats(playerid, params);
CMD:daveh(playerid, params[]) return callcmd::destroyadmveh(playerid, params);
CMD:destroyveh(playerid, params[]) return callcmd::destroyadmveh(playerid, params);

