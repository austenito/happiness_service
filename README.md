![Build Status](https://travis-ci.org/austenito/happiness_service.svg?branch=master)

# Happiness Service

An open source server implementation of [Track Your Happiness](https://www.trackyourhappiness.org), which allows you to answer [questions](https://github.com/austenito/happiness/blob/master/QUESTIONS.md) and store your responses.

The impetus of this project is around privacy and limited sharing. I want confidence my data is stored in a safely and I want to be able to expose certain aspects of myself to others. I also wanted to have the ability to control what questions I answer and how many questions I answer.

A big problem I find with Track Your Happiness are:

* questions to answer - I don't like answering more than 5 questions
* general questions - I want to answer questions that are specific to me
* survey length - I wish the survey lasted for longer than 6 weeks. I want a total picture of my happiness over a long period of time.

# Setup

```
bundle
rake db:create db:migrate db:seed db:test:prepare
rspec
```

# Questions

All questions have been duplicated from Track Your Happiness. They can be found [here](https://github.com/austenito/happiness_service/blob/master/config/questions.yml)

Questions are simple and general. They have the following schema:

* question text
* type (multiple, boolean, time, range)
* freeform (boolean)
* min and max

# Consuming this service

The service can be consumed with the [Poptart](https://github.com/austenito/poptart) gem. It's called Poptart because poptarts make me happy!

# Api Documentation

## Hypermedia

API endpoints provide hypermedia links pointing to related resources. The supported HTTP methods are the keys of the URIs.

## Questions

```
curl localhost -H API-TOKEN:testing localhost:3000/api/questions

[
  {
    "id": 1,
    "question_type": "multiple",
    "text": "How hungry or full are you right now?",
    "responses": [
      "Very hungry",
      "Somewhat hungry",
      "Neither full nor hungry",
      "Somewhat full",
      "Very full"
    ],
    "freeform": false
  }
]

```

## Surveys

```
curl localhost -H API-TOKEN:testing localhost:3000/api/surveys

{
  "surveys": [
    {
      "id": 1,
      "user_id": 1,
      "_links": {
        "self": {
          "href": "http://localhost:3000/api/surveys/1"
        },
        "survey_questions": {
          "post": {
            "href": "/api/surveys/1/survey_questions"
          },
          "put": {
            "href": "/api/surveys/1/survey_questions"
          }
        }
      },
      "completed": false
    }
  ]
}
```

## Survey Questions

```
{
  "id": 1,
  "user_id": 1,
  "_links": {
    "self": {
      "href": "http://localhost:3000/api/surveys/1"
    },
    "survey_questions": {
      "post": {
        "href": "/api/surveys/1/survey_questions"
      },
      "put": {
        "href": "/api/surveys/1/survey_questions"
      }
    }
  },
  "completed": false,
  "survey_questions": [
    {
      "id": 1,
      "text": "How do you feel right now?",
      "type": "range",
      "responses": [
        "0",
        "10"
      ],
      "answer": "10",
      "freeform": false,
      "_links": {
        "self": {
          "href": "/api/surveys/1/survey_questions/1"
        },
        "post": {
          "href": "http://localhost:3000/api/surveys/1/survey_questions"
        },
        "put": {
          "href": "/api/surveys/1/survey_questions/1"
        },
        "survey": {
          "href": "/api/surveys/1"
        }
      }
    }
  ]
}
```

