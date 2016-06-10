package com.wordflip.api.controllers;


import com.wordflip.api.SqlCreator;
import com.wordflip.api.models.*;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import org.joda.time.Days;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by robvangastel on 27/05/16.
 */

@RestController
@RequestMapping("/{userId}/tip")
public class TipController {

	private SqlCreator creator = new SqlCreator();

	@RequestMapping(value = "/practice", method = RequestMethod.GET)
    public ResponseEntity<List<Practice>> allPractices(@PathVariable String userId) {

        creator = new SqlCreator();
        validateUser(userId);
        List<Practice> practices = creator.getPractices(userId);
        return new ResponseEntity<List<Practice>>(practices, HttpStatus.OK);
    }

	@RequestMapping(value = "rating", method = RequestMethod.GET)
	public ResponseEntity<List<Toets>> getToetsRating(@PathVariable String userId) {
		creator = new SqlCreator();
		validateUser(userId);

		List<Practice> ratings = creator.getToetsPractices(userId);
		

		return new ResponseEntity<List<Toets>>(ratings, HttpStatus.OK);
	}

    @RequestMapping( method = RequestMethod.GET)
    public String tip(@PathVariable String userId) {

        creator = new SqlCreator();
        validateUser(userId);
        List<Practice> practices = creator.getPractices(userId);
	    List<Practice> practicesOther = creator.getOtherPractices(userId);

        int speed = 0;
	    int speedOther = 1;
        int correctie = 0;
	    int correctieOther = 1;
        int consistent = 0;
        int consistent_dayParts = 0;

	    for(int i = 0; i < practicesOther.size(); i++) {
		    speedOther += practicesOther.get(i).compareSpeed();
		    correctieOther += practicesOther.get(i).compareCorrect();
	    }

        for(int i = 0; i < practices.size(); i++) {
            speed += practices.get(i).compareSpeed();
            correctie += practices.get(i).compareCorrect();

            if(i+1 >= practices.size()) {
                break;
            }
            if(practices.get(i).compareDates(practices.get(i+1)) > 2) {
                consistent++;
            }
            consistent_dayParts += practices.get(i).compareDayParts(practices.get(i+1));
        }

        return new Tip().getTip(speed, correctie, consistent, (consistent_dayParts/practices.size()), practices.size(), speedOther, correctieOther);
    }

    @RequestMapping(method = RequestMethod.POST)
    public void addPractice(@PathVariable String userId,
                            @RequestParam(value="toets_id", defaultValue="1") String toets_id,
                            @RequestParam(value="amount", defaultValue="8") int amount,
                            @RequestParam(value="mistakes", defaultValue="0") int mistakes,
                            @RequestParam(value="duration", defaultValue="120") int duration,
                            @RequestParam(value="planned", defaultValue="false") boolean planned) throws ParseException {

        creator = new SqlCreator();
        validateUser(userId);
        creator.addPractice(new Practice(duration, amount, mistakes, planned), userId, toets_id);
    }


	//welke dag van de tijd geleerd en aantal
	@RequestMapping(value = "/times", method = RequestMethod.GET)
	public ResponseEntity<List<DayPart>> getMoments(@PathVariable String userId) throws ParseException {
		creator = new SqlCreator();
		validateUser(userId);

		List<DayPart> dayParts = getDayParts(creator.getPractices(userId));
		return new ResponseEntity<>(dayParts, HttpStatus.OK);

	}

	//momenten geleerd volgens de de app met aantal wel en niet
	@RequestMapping(value = "/moments", method = RequestMethod.GET)
	public Moment getTimes(@PathVariable String userId) throws ParseException {
		creator = new SqlCreator();
		validateUser(userId);

		List<Practice> practices = creator.getPractices(userId);

		Moment m = new Moment(practices.size(), 0);

		for(Practice p: practices) {
			if(p.isPlanned()) {
				m.appendPlanned(1);
			}
		}
		return m;
	}

	//Snelheid van de geleerde woordjes met aantal binnen welke snelheid
	@RequestMapping(value = "/speed", method = RequestMethod.GET)
	public ResponseEntity<List<Word>>  getSubjects(@PathVariable String userId) throws ParseException {
		creator = new SqlCreator();
		validateUser(userId);

		List<Word> Speed = getAmountWords(creator.getPractices(userId));
		return new ResponseEntity<>(Speed, HttpStatus.OK);
	}

	//Aantal leermomenten voor elke woorden met aantal
	@RequestMapping(value = "/subject", method = RequestMethod.GET)
	public ResponseEntity<List<Subject>> getSpeed(@PathVariable String userId) throws ParseException {
		creator = new SqlCreator();
		validateUser(userId);

		List<Subject> subjects = creator.getSubjectCount(userId);
		return new ResponseEntity<>(subjects, HttpStatus.OK);
	}


    private void validateUser(String userId) {
        creator = new SqlCreator();
        if(!creator.validateUser(userId)) {
            throw new UserNotFoundException(userId);
        }
    }

	public List<DayPart> getDayParts(List<Practice> practices) {

		List<DayPart> dayParts = new ArrayList<DayPart>();

		DayPart ochtend = new DayPart(0,"'s ochtends");
		DayPart middag = new DayPart(0,"'s middags");
		DayPart avond = new DayPart(0,"'s avonds");
		DayPart nacht = new DayPart(0,"'s nachts");

		for (Practice p : practices) {
			if (p.getHourOfDay() <= 5 || p.getHourOfDay() >= 12) {
				ochtend.appendAmount(1);
			} else if (p.getHourOfDay() >= 12 || p.getHourOfDay() <= 18) {
				middag.appendAmount(1);
			} else if (p.getHourOfDay() >= 18 || p.getHourOfDay() <= 24) {
				avond.appendAmount(1);
			} else if (p.getHourOfDay() >= 0 || p.getHourOfDay() <= 5) {
				nacht.appendAmount(1);
			}
		}
		dayParts.add(ochtend);
		dayParts.add(middag);
		dayParts.add(avond);
		dayParts.add(nacht);
		return dayParts;
	}

	public List<Word> getAmountWords(List<Practice> practices) {

		List<Word> speed = new ArrayList<Word>();

		Word sloom = new Word(0,"< 1 minuut");
		Word matig = new Word(0,"> 1 minuut");
		Word snel = new Word(0,"> 2 minuten");

		for (Practice p : practices) {
			if (p.compareSpeed() == -1) {
				snel.appendAmount(1);
			} else if (p.compareSpeed() == 0) {
				matig.appendAmount(1);
			} else if (p.compareSpeed() == 1) {
				sloom.appendAmount(1);
			}
		}
		speed.add(sloom);
		speed.add(matig);
		speed.add(snel);

		return speed;
	}
}

@ResponseStatus(HttpStatus.NOT_FOUND)
class UserNotFoundException extends RuntimeException {

    public UserNotFoundException(String userId) {
        super("could not find user '" + userId + "'.");
    }
}
