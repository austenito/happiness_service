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

## Root Path

```
curl localhost -H Content-Type:application/json -H API-TOKEN:testing http://localhost:3000

{
  "_links": {
    "self": {
      "href": "http://localhost:3000/"
    },
    "surveys": {
      "href": "api/surveys"
    },
    "users": {
      "href": "api/users"
    },
    "questions": {
      "href": "api/questions"
    }
  }
}
```

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

### Reading surveys

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

```
curl localhost -H API-TOKEN:testing localhost:3000/api/surveys/1

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
  "survey_questions": []
}
```

### Creating empty survey

```
curl localhost -H Content-Type:application/json -H API-TOKEN:testing -d '{ "survey": { "service_user_id": "d59dfd171d8915ee80927a6538a5526f53181b6d600510aa0cd43b27665a724d" } }

{
  "id": 35,
  "user_id": 36,
  "_links": {
    "self": {
      "href": "http://localhost:3000/api/surveys/35"
    },
    "survey_questions": {
      "post": {
        "href": "/api/surveys/35/survey_questions"
      },
      "put": {
        "href": "/api/surveys/35/survey_questions"
      }
    }
  },
  "completed": false,
  "survey_questions": []
}
```

### Creating survey with random questions

```
curl localhost -H Content-Type:application/json -H API-TOKEN:testing -d '{ "survey": { "service_user_id": "d59dfd171d8915ee80927a6538a5526f53181b6d600510aa0cd43b27665a724d" }, "random": true }' localhost:3000/api/surveys

{
  "id": 36,
  "user_id": 36,
  "_links": {
    "self": {
      "href": "http://localhost:3000/api/surveys/36"
    },
    "survey_questions": {
      "post": {
        "href": "/api/surveys/36/survey_questions"
      },
      "put": {
        "href": "/api/surveys/36/survey_questions"
      }
    }
  },
  "completed": false,
  "survey_questions": [
    {
      "id": 146,
      "text": "How do you feel right now?",
      "type": "range",
      "responses": [
        "0",
        "10"
      ],
      "answer": null,
      "freeform": false,
      "_links": {
        "self": {
          "href": "/api/surveys/36/survey_questions/146"
        },
        "post": {
          "href": "http://localhost:3000/api/surveys/36/survey_questions"
        },
        "put": {
          "href": "/api/surveys/36/survey_questions/146"
        },
        "survey": {
          "href": "/api/surveys/36"
        }
      }
    }
    ...
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

### Creating a survey question

```
curl localhost -H Content-Type:application/json -H API-TOKEN:testing -d '{ "survey_question": { "question_id": 31 } }' localhost:3000/api/surveys/35/survey_questions

{
  "id": 151,
  "survey_id": 35,
  "question_id": 31,
  "answer": null,
  "created_at": "2014-09-21T20:12:28.959Z",
  "updated_at": "2014-09-21T20:12:28.959Z"
}
```

### Updating a survey question

```
curl localhost -X PUT -H Content-Type:application/json -H API-TOKEN:testing -d '{ "survey_question": { "answer": "poptarts" } }' localhost:3000/api/surveys/35/survey_questions/151

# Returns a 204
```

