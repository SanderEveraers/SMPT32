package com.wordflip.api.models;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

/**
 * Created by robvangastel on 03/06/16.
 */

//besteed aandacht aan vakken meer/minder
public class Tip {

    List<String> con_pos = Arrays.asList("Je leert elke dag houd dit vol!",
            "Je hebt een goede start houd dit vol.", "Ga zo door je hebt nog geen dag laten vallen!");

    List<String> con_neg = Arrays.asList("Probeer een vast moment te kiezen om elke dag een paar woordjes te leren.",
            "Probeer bijvoorbeeld na het eten 2 minuten de tijd te nemen om woordjes te leren.",
            "Probeer elke dag een aantal woordjes te leren.");

    List<String> diff_neg = Arrays.asList("Probeer vast te oefenen na het tandenpoetsen.",
            "Probeert vast te oefenen na het ovondeten.",
            "Oefen wat woordjes vast in je tussenuren.");

    List<String> diff_pos = Arrays.asList("Blijf het volhouden om elke dag 1 moment te hebben om woordjes te leren.",
            "Als je dit zo volhoudt kost het 1 week om je Engels toets te leren.",
            "Houd dit vol om op zijn minst 1 vast moment van de dag te leren.");

    List<String> speed_pos = Arrays.asList("Het leren van woordjes gaat vloeiend, hou dit vol!",
            "Ga zo door, blijf elke dag woordjes leren.",
            "Je bent goed bezig, blijf elke dag zo door gaan.");

    List<String> speed_neg = Arrays.asList("Probeer 2 minuutjes van je dag te nemen om je woordjes te leren.",
            "Probeer rustig de tijd te nemen tijdens het leren van de woordjes.",
            "Probeer te leren met muziek om er makkelijker door heen te komen.");

    public TipVanDeDag getTip(int speed, int correctie, int consistent, int difference_hours, int practices) {

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

        List<String> tips = new ArrayList<>();
        Random rdm = new Random();

        if(practices > 2) {
            if (consistent == 0 || consistent == 1) {
                //Je leert elke dag goed bezig
                tips.add(con_pos.get(rdm.nextInt(3)));

                if (difference_hours < 4) {

                    tips.add(diff_pos.get(rdm.nextInt(3)));
                    //Probeer een moment te kiezen om aan je leren te werken
                    if (speed < 0 || correctie < 0) {
                        //Meer woordjes leren
                        //Je bent goed opweg woordjes leren gaan vloeiend
                        tips.add(speed_pos.get(rdm.nextInt(3)));
                    }

                    if (speed > 0 || correctie > 0) {
                        //Minder woordjes leren?
                        //Probeer je tijd te nemen bij het leren van je woordjes
                        tips.add(speed_neg.get(rdm.nextInt(3)));
                    }
                } else {
                    tips.add(diff_neg.get(rdm.nextInt(3)));
                    if (speed < 0 || correctie < 0) {
                        //Meer woordjes leren
                        //Je bent goed opweg woordjes leren gaan vloeiend
                        tips.add(speed_pos.get(rdm.nextInt(3)));
                    }

                    if (speed > 0 || correctie > 0) {
                        //Minder woordjes leren?
                        //Probeer je tijd te nemen bij het leren van je woordjes
                        tips.add(speed_neg.get(rdm.nextInt(3)));

                    }
                }

            } else if (consistent >= 2) {

                tips.add(con_neg.get(rdm.nextInt(3)));
                //Sla minder dagen over & kies een moment om eraan te leren
                if (speed < 0 || correctie < 0) {
                    tips.add(speed_pos.get(rdm.nextInt(3)));
                    //Meer woordjes leren
                    //Je bent goed opweg woordjes leren gaan vloeiend
                }

                if (speed > 0 || correctie > 0) {
                    //Minder woordjes leren?
                    //Probeer je tijd te nemen bij het leren van je woordjes
                    tips.add(speed_neg.get(rdm.nextInt(3)));
                }
            }
        } else {
            tips.add(con_neg.get(rdm.nextInt(3)));
        }
        return new TipVanDeDag(tips.get(rdm.nextInt(tips.size())));
    }
}
