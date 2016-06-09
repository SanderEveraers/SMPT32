package com.wordflip.api.controllers;


import com.wordflip.api.SqlCreator;
import com.wordflip.api.models.Practice;

import com.wordflip.api.models.Tip;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import org.joda.time.Days;

import java.text.ParseException;
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

    @RequestMapping( method = RequestMethod.GET)
    public String tip(@PathVariable String userId) {

        creator = new SqlCreator();
        validateUser(userId);
        List<Practice> practices = creator.getPractices(userId);

        int speed = 0;
        int correctie = 0;
        int consistent = 0;
        int consistent_dayParts = 0;

        //int others = 0;

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

        return new Tip().getTip(speed, correctie, consistent, (consistent_dayParts/practices.size()), practices.size());
    }

    @RequestMapping(method = RequestMethod.POST)
    public void addPractice(@PathVariable String userId,
                            @RequestParam(value="toets_id", defaultValue="1") String toets_id,
                      @RequestParam(value="amount", defaultValue="8") int amount,
                      @RequestParam(value="mistakes", defaultValue="0") int mistakes,
                      @RequestParam(value="duration", defaultValue="120") int duration) throws ParseException {

        creator = new SqlCreator();
        validateUser(userId);
        creator.addPractice(new Practice(duration, amount, mistakes), userId, toets_id);
    }

	//momenten geleerd volgens de de app met aantal wel en niet
	@RequestMapping(value = "/moments", method = RequestMethod.POST)
	public void getMoments(@PathVariable String userId) throws ParseException {
		creator = new SqlCreator();
		validateUser(userId);

		List<Practice> practices = creator.getPractices(userId);

	}

	//welke dag van de tijd geleerd en aantal
	@RequestMapping(value = "/times", method = RequestMethod.POST)
	public void getTimes(@PathVariable String userId) throws ParseException {
		creator = new SqlCreator();
		validateUser(userId);


	}

	//Snelheid van de geleerde woordjes met aantal binnen welke snelheid
	@RequestMapping(value = "/subjects", method = RequestMethod.POST)
	public void getSubjects(@PathVariable String userId) throws ParseException {
		creator = new SqlCreator();
		validateUser(userId);
	}

	//Aantal leermomenten voor elke woorden met aantal
	@RequestMapping(value = "/speed", method = RequestMethod.POST)
	public void getSpeed(@PathVariable String userId) throws ParseException {
		creator = new SqlCreator();
		validateUser(userId);
	}


    private void validateUser(String userId) {
        creator = new SqlCreator();
        if(!creator.validateUser(userId)) {
            throw new UserNotFoundException(userId);
        }
    }


}

@ResponseStatus(HttpStatus.NOT_FOUND)
class UserNotFoundException extends RuntimeException {

    public UserNotFoundException(String userId) {
        super("could not find user '" + userId + "'.");
    }
}
