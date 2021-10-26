# README

## Notes

* Currently loading the existing data set happens via seeds.
  This probably wouldn't be how I'd approach pulling data from third parties
  in other circumstances, but for a quick, one-off demo, it seems fine.
* Visit: /tax_entities[?state=<code>] to view results.
* Using JSONAPI spec because of using jsonapi-serializer
* View on Heroku at https://instrumentl-demo.herokuapp.com/
* Went with the easiest to use way of dealing with XML. It seems clear
  that something more powerful would be a better choice if dealing with
  lots of docs like this in production. If there's a trick to predicting
  tag changes I didn't notice it.
* Set this project up with tailwind and stimulus reflex to potentially play
  with them in the future, but that caused a huge time sync because of the
  javascript pack pipeline stuff having issues...
