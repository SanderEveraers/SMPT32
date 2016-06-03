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

        return new Tip().getTip(speed, correctie, consistent, (consistent_dayParts/practices.size()));
    }

    @RequestMapping(method = RequestMethod.POST)
    public void addPractice(@PathVariable String userId,
                      @RequestParam(value="amount", defaultValue="8") int amount,
                      @RequestParam(value="mistakes", defaultValue="0") int mistakes,
                      @RequestParam(value="duration", defaultValue="120") int duration) throws ParseException {

        creator = new SqlCreator();
        validateUser(userId);
        creator.addPractice(new Practice(duration, amount, mistakes), userId);
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
