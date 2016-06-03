package com.wordflip.api.models;

/**
 * Created by robvangastel on 03/06/16.
 */
public class Tip {

    public String getTip(int speed, int correctie, int consistent, int difference_hours) {

        //correctie
        //Negatieve snelheid betekend dat hij weinig fouten had
        //Hoe dichterbij 0 betekend een normaal aantal fouten
        //Hoeveel hoger dan 0 betekend veel fouten in het leren

        //speed
        //Negatieve snelheid betekend dat hij snel is geweest
        //Hoe dichterbij 0 betekend normale snelheid
        //Hoeveel hoger dan 0 betekend langzaam over de woorden

        //difference_hours
        //als dit getal groter is dan 12 betekend dat hij gemiddelt 12 uur verschilt in
        //zijn leermomenten

        //consistent
        //0 betekend consistent aan het leren geweest minder dan 1 dag ertussen
        //hoeveel hoger dan 0 betekend dat hij dagen heeft overgeslagen

        if (consistent == 0) {

            //Je leert elke dag goed bezig
            if (difference_hours > 12) {

                //Probeer een moment te kiezen om aan je leren te werken
            } else {
                if (speed < 0 || correctie < 0) {
                    //Meer woordjes leren
                    //Je bent goed opweg woordjes leren gaan vloeiend
                }

                if (speed > 0 || correctie > 0) {
                    //Minder woordjes leren?
                    //Probeer je tijd te nemen bij het leren van je woordjes
                }
            }

        } else if (consistent > 2) {

            //Sla minder dagen over & kies een moment om eraan te leren
        } else {

            //Kies een moment na het eten om je woordjes te leren.
        }
        return "Tip string";
    }
}
