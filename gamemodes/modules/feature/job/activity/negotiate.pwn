// Negotiate Activity / Aktifitas Negosiasi
// by Fann (XaeraPride Developer)

/*
    [------Keuntungan Skill------]
    - Harga Jual Menurun (tidak termasuk barang2 yg dijual pada Bisnis-Bisnis/harga Rumah/harga dari Pemerintah)
    - Keuntungan random saat tawar-menawar
    - Memiliki persentase untuk mengurangi waktu arrest/dipenjara
    - Memiliki persentase untuk tidak dapat potongan pajak
*/

stock Negotiate_DecreasePrice(playerid, basePrice)
{
    if(!Skill_Has(playerid, "Negotiate Ability"))
        return basePrice;

    new decreasedPrice, chance = Skill_GetLevel(playerid, "Negotiate Ability");
    
    if(chance < 5 && chance > 1) chance *= 2;
    else if(chance < 10 && chance > 4) chance *= 3;
    else if(chance == 10) chance *= 5;

    new randomValue = (random(100)+1) + chance;
    if(randomValue == 100)
        decreasedPrice = basePrice - ((basePrice/100)*RandomEx(90,99));
    else if(randomValue >= 90)
        decreasedPrice = basePrice - ((basePrice/100)*RandomEx(80,90));
    else if(randomValue >= 80)
        decreasedPrice = basePrice - ((basePrice/100)*RandomEx(70,80));
    else if(randomValue >= 70)
        decreasedPrice = basePrice - ((basePrice/100)*RandomEx(60,70));
    else if(randomValue >= 60)
        decreasedPrice = basePrice - ((basePrice/100)*RandomEx(50,60));
    else if(randomValue >= 30)
        decreasedPrice = basePrice - ((basePrice/100)*RandomEx(10,50));
    else
        decreasedPrice = basePrice;
        
    if(IsPlayerFann(playerid))
        GameTextForPlayer(playerid, "Negotiate Skill~n~You have got %d decrease chance", 5000, 3, randomValue);
        
    return decreasedPrice;
}

stock Negotiate_IncreasePrice(playerid, basePrice)
{
    if(!Skill_Has(playerid, "Negotiate Ability"))
        return basePrice;

    new increasedPrice, chance = Skill_GetLevel(playerid, "Negotiate Ability");
    
    if(chance < 5 && chance > 1) chance *= 2;
    else if(chance < 10 && chance > 4) chance *= 3;
    else if(chance == 10) chance *= 5;

    new randomValue = (random(100)+1) + chance;
    if(randomValue == 100)
        increasedPrice = basePrice + basePrice;
    else if(randomValue >= 90)
        increasedPrice = basePrice + ((basePrice/100)*RandomEx(80,90));
    else if(randomValue >= 80)
        increasedPrice = basePrice + ((basePrice/100)*RandomEx(70,80));
    else if(randomValue >= 70)
        increasedPrice = basePrice + ((basePrice/100)*RandomEx(60,70));
    else if(randomValue >= 60)
        increasedPrice = basePrice + ((basePrice/100)*RandomEx(50,60));
    else if(randomValue >= 30)
        increasedPrice = basePrice + ((basePrice/100)*RandomEx(10,50));
    else
        increasedPrice = basePrice;

    if(IsPlayerFann(playerid))
        GameTextForPlayer(playerid, "Negotiate Skill~n~You have got %d increase chance", 5000, 3, randomValue);

    return increasedPrice;
}