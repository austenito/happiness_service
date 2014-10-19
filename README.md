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

# Consuming this service

The service can be consumed with the [Poptart](https://github.com/austenito/poptart) gem. It's called Poptart because poptarts make me happy!

# Api Documentation

## Authentication and Authorization

Users have two tokens:

* Service User Id
* User token

The service user id (SUID) is the external identifier used to identify users in this service. Clients can consume the API and find users in this service with the SUID.

The user token is used for user authorization. It is how the happiness service scopes data for clients. For example, clients can only request data for a user based on their token. This token can be re-generated if the token is compromised.

## Hypermedia

API endpoints provide hypermedia links pointing to related resources. The supported HTTP methods are the keys of the URIs.

## Root Path

```
curl -H Content-Type:application/json -H API-TOKEN:testing http://localhost:3000

{
  "_links": {
    "self": {
      "href": "http://localhost:3000/"
    },
    "surveys": {
      "href": "http://localhost:3000/api/surveys{/id}{?query*}"
    },
    "users": {
      "href": "http://localhost:3000/api/users{/id}{?query*}"
    },
    "questions": {
      "href": "api/questions{/id}{?query*}"
    }
  }
}
```

## Questions

All questions have been duplicated from Track Your Happiness. They can be found [here](https://github.com/austenito/happiness_service/blob/master/config/questions.yml)

Questions are simple and general. They have the following schema:

* question text
* type (multiple, boolean, time, range)
* freeform (boolean)
* min and max

```
curl -H API-TOKEN:testing localhost:3000/api/questions

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

### Creating questions

```
curl -H Content-Type:application/json -H API-TOKEN:testing -d '{ "question": { "question_type": "multiple", "text" : "Do you love poptarts?", "responses": ["Yes", "No"], "freeform": true, "key" : "poptarts" } }' http://localhost:3000/api/questions

{
  "id": 53,
  "question_type": "multiple",
  "text": "Do you love poptarts?",
  "responses": [
    "Yes",
    "No"
  ],
  "freeform": false,
  "key": "poptarts"
}
```

### Related questions

Sometimes you want to be able to have questions dependent on each other. For example, if you ask "Are you interacting with anyone?", you might want to ask a follow up question, "Who are with?".

You can do so by specifying a `parent_question_id`:

```
curl -H Content-Type:application/json -H API-TOKEN:testing -d '{ "question": { "question_type": "multiple", "text" : "Do you love poptarts?", "responses": ["Yes", "No"], "freeform": true, "parent_question_id": 8} }' http://localhost:3000/api/questions

{
  "id": 86,
  "question_type": "multiple",
  "text": "Do you love poptarts?",
  "responses": [
    "Yes",
    "No"
  ],
  "freeform": true,
  "absolute_index": null,
  "parent_question_id": 8
}
```


## Surveys

### Reading surveys

```
curl -H API-TOKEN:testing SERVICE-USER-ID:testing localhost:3000/api/surveys

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
            "href": "http://localhost:3000/api/surveys/1/survey_questions"
          },
          "put": {
            "href": "http://localhost:3000/api/surveys/1/survey_questions"
          }
        }
      },
      "completed": false
    }
  ]
}
```

```
curl -H API-TOKEN:testing SERVICE-USER-ID:testing localhost:3000/api/surveys/1

{
  "id": 1,
  "user_id": 1,
  "_links": {
    "self": {
      "href": "http://localhost:3000/api/surveys/1"
    },
    "survey_questions": {
      "post": {
        "href": "http://localhost:3000/api/surveys/1/survey_questions"
      },
      "put": {
        "href": "http://localhost:3000/api/surveys/1/survey_questions"
      }
    }
  },
  "completed": false,
  "survey_questions": []
}
```

### Creating an empty survey

```
curl -H Content-Type:application/json -H API-TOKEN:testing SERVICE-USER-ID:testing -d '{ "survey": { "service_user_id": "d59dfd171d8915ee80927a6538a5526f53181b6d600510aa0cd43b27665a724d" } } localhost:3000/api/surveys

{
  "id": 35,
  "user_id": 36,
  "_links": {
    "self": {
      "href": "http://localhost:3000/api/surveys/35"
    },
    "survey_questions": {
      "post": {
        "href": "http://localhost:3000/api/surveys/35/survey_questions"
      },
      "put": {
        "href": "http://localhost:3000/api/surveys/35/survey_questions"
      }
    }
  },
  "completed": false,
  "survey_questions": []
}
```

### Creating a survey with random questions

```
curl -H Content-Type:application/json -H API-TOKEN:testing SERVICE-USER-ID:testing -d '{ "survey": { "service_user_id": "d59dfd171d8915ee80927a6538a5526f53181b6d600510aa0cd43b27665a724d" }, "random": true }' localhost:3000/api/surveys

{
  "id": 36,
  "user_id": 36,
  "_links": {
    "self": {
      "href": "http://localhost:3000/api/surveys/36"
    },
    "survey_questions": {
      "post": {
        "href": "http://localhost:3000/api/surveys/36/survey_questions"
      },
      "put": {
        "href": "http://localhost:3000/api/surveys/36/survey_questions"
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
          "href": "http://localhost:3000/api/surveys/36/survey_questions/146"
        },
        "post": {
          "href": "http://localhost:3000/api/surveys/36/survey_questions"
        },
        "put": {
          "href": "http://localhost:3000/api/surveys/36/survey_questions/146"
        },
        "survey": {
          "href": "http://localhost:3000/api/surveys/36"
        }
      }
    }
    ...
  ]
}
```

## Survey Questions

```
curl -H Content-Type:application/json -H API-TOKEN:testing SERVICE-USER-ID:testing http://localhost:3000/api/surveys/35/survey_questions/151

{
  "id": 1,
  "user_id": 1,
  "_links": {
    "self": {
      "href": "http://localhost:3000/api/surveys/1"
    },
    "survey_questions": {
      "post": {
        "href": "http://localhost:3000/api/surveys/1/survey_questions"
      },
      "put": {
        "href": "http://localhost:3000/api/surveys/1/survey_questions"
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
          "href": "http://localhost:3000/api/surveys/1/survey_questions/1"
        },
        "post": {
          "href": "http://localhost:3000/api/surveys/1/survey_questions"
        },
        "put": {
          "href": "http://localhost:3000/api/surveys/1/survey_questions/1"
        },
        "survey": {
          "href": "http://localhost:3000/api/surveys/1"
        }
      }
    }
  ]
}
```

### Creating a survey question

```
curl -H Content-Type:application/json -H API-TOKEN:testing SERVICE-USER-ID:testing -d '{ "survey_question": { "question_id": 31 } }' localhost:3000/api/surveys/35/survey_questions

{
  "id": 280,
  "text": "If you could, and it had no negative consequences, would you jump forward in time 24 hours?",
  "type": "boolean",
  "responses": [
    "t",
    "f"
  ],
  "answer": null,
  "freeform": false,
  "_links": {
    "self": {
      "href": "http://localhost:3000/api/surveys/35/survey_questions/280"
    },
    "post": {
      "href": "http://localhost:3000/api/surveys/35/survey_questions"
    },
    "put": {
      "href": "http://localhost:3000/api/surveys/35/survey_questions/280"
    },
    "survey": {
      "href": "http://localhost:3000/api/surveys/35"
    }
  }
}
```

### Retrieving all survey questions for a question

```
curl -H API_TOKEN:testing http://localhost:3000/api/questions/103/survey_questions

{
  "survey_questions": [
    {
      "id": 837,
      "text": "Do you like poptarts?",
      "type": "boolean",
      "responses": [
        "t",
        "f"
      ],
      "answer": "t",
      "freeform": false,
      "_links": {
        "self": {
          "href": "http://localhost:3000/api/surveys/195/survey_questions/837"
        },
        "post": {
          "href": "http://localhost:3000/api/surveys/195/survey_questions"
        },
        "put": {
          "href": "http://localhost:3000/api/surveys/195/survey_questions/837"
        },
        "survey": {
          "href": "http://localhost:3000/api/surveys/195"
        }
      }
    }
    ]
  }
```



### Updating a survey question

```
curl -X PUT -H Content-Type:application/json -H API-TOKEN:testing SERVICE-USER-ID:testing -d '{ "survey_question": { "answer": "poptarts" } }' localhost:3000/api/surveys/35/survey_questions/151

# Returns a 204
```

