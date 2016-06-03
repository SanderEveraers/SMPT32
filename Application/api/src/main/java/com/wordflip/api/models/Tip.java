package com.wordflip.api.models;

/**
 * Created by robvangastel on 03/06/16.
 */
public class Tip {

    public String getTip(int speed, int correctie, int consistent, int difference_hours) {
        if(consistent == 0) {
            //0 betekend consistent aan het leren geweest minder dan 1 dag ertussen
            //hoeveel hoger dan 0 betekend dat hij dagen heeft overgeslagen
        }

        if(speed == 0) {
            //Negatieve snelheid betekend dat hij snel is geweest
            //Hoe dichterbij 0 betekend normale snelheid
            //Hoeveel hoger dan 0 betekend langzaam over de woorden
        }

        if(correctie == 0) {
            //Negatieve snelheid betekend dat hij weinig fouten had
            //Hoe dichterbij 0 betekend een normaal aantal fouten
            //Hoeveel hoger dan 0 betekend veel fouten in het leren
        }

        if(difference_hours > 12) {
            //als dit getal groter is dan 12 betekend dat hij gemiddelt 12 uur verschilt in
            //zijn leermomenten
        }

        return "Tip string";
    }
}
