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

API endpoints provide hypermedia links pointing to related resources. All hypermedia links have the following:

* href: the uri template
* rel: the description of the link to the resource
* method: the HTTP method the uri supports

## Root Path

```
curl -H Content-Type:application/json -H API-TOKEN:testing http://localhost:3000
{
  "_links": [
    {
      "href": "http://localhost:3000/",
      "rel": "self",
      "method": "GET"
    },
    {
      "href": "http://localhost:3000/api/surveys{/id}{?query*}",
      "rel": "surveys",
      "method": "GET"
    },
    {
      "href": "http://localhost:3000/api/surveys",
      "rel": "surveys",
      "method": "POST"
    },
    {
      "href": "http://localhost:3000/api/user{/id}{?query*}",
      "rel": "users",
      "method": "GET"
    },
    {
      "href": "http://localhost:3000/api/user",
      "rel": "users",
      "method": "POST"
    },
    {
      "href": "http://localhost:3000/api/questions{/id}{?query*}",
      "rel": "questions",
      "method": "GET"
    },
    {
      "href": "http://localhost:3000/api/questions",
      "rel": "questions",
      "method": "POST"
    },
    {
      "href": "http://localhost:3000/api/questions/surveys/{survey_id}/survey_questions{/id}{?query*}",
      "rel": "survey-questions",
      "method": "GET"
    },
    {
      "href": "http://localhost:3000/api/questions/surveys/{survey_id}/survey_questions",
      "rel": "survey-questions",
      "method": "POST"
    },
    {
      "href": "http://localhost:3000/api/questions/surveys/{survey_id}/survey_questions{/id}",
      "rel": "survey-questions",
      "method": "PUT"
    },
    {
      "href": "http://localhost:3000/api/questions/survey_questions{?query*}",
      "rel": "survey-questions-by-query",
      "method": "GET"
    }
  ]
}
```

## Questions

All questions have been duplicated from Track Your Happiness. They can be found [here](https://github.com/austenito/happiness_service/blob/master/config/questions.yml)

Questions are simple and general. They have the following schema:

* question text
* type (multiple, boolean, time, range)
* freeform (boolean)
* min and max

### Retrieve all questions
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
    "freeform": false,
    "absolute_index": null,
    "parent_question_id": null,
    "key": "how_hungry_are_you",
    "_links": [
      {
        "rel": "self",
        "href": "http://localhost:3000/api/questions/1",
        "method": "GET"
      }
    ]
  }
]

```

### Retrieve a question

```
curl -H API-TOKEN:testing localhost:3000/api/questions/1

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
  "freeform": false,
  "absolute_index": null,
  "parent_question_id": null,
  "key": "how_hungry_are_you",
  "_links": [
    {
      "rel": "self",
      "href": "http://localhost:3000/api/questions/1",
      "method": "GET"
    }
  ]
}
```

### Creating questions

```
curl -H Content-Type:application/json -H API-TOKEN:testing -d '{ "question": { "question_type": "multiple", "text" : "Do you love poptarts?", "responses": ["Yes", "No"], "freeform": true, "key" : "poptarts" } }' http://localhost:3000/api/questions

{
  "id": 74,
  "question_type": "multiple",
  "text": "Do you love poptarts?",
  "responses": [
    "Yes",
    "No"
  ],
  "freeform": false,
  "key": "poptarts"
  "absolute_index": null,
  "parent_question_id": null,
  "_links": [
    {
      "rel": "self",
      "href": "http://localhost:3000/api/questions/74",
      "method": "GET"
    }
  ]
}
```

## Users

All surveys and survey questions are scoped to a user.

### Reading user information

```
curl -H API-TOKEN:testing -H SERVICE-USER-ID:testing -H USER-TOKEN:testing localhost:3000/api/user

{
  "service_user_id": "testing"
  "_links": [
    {
      "href": "http://localhost:3000/api/user",
      "rel": "self",
      "method": "GET"
    }
  ],
  "token": "testing"
}
```

## Surveys

### Reading surveys

```
curl -H API-TOKEN:testing -H SERVICE-USER-ID:testing -H USER-TOKEN:testing localhost:3000/api/surveys

{
  "surveys": [
    {
      "id": 74,
      "user_id": 1,
      "_links": [
        {
          "href": "http://localhost:3000/api/surveys/74",
          "rel": "self",
          "method": "GET"
        },
        {
          "href": "http://localhost:3000/api/surveys/74/survey_questions",
          "rel": "survey-questions",
          "method": "POST"
        }
      ],
      "completed": false
      "survey_questions": []
    }
  ]
}
```

```
curl -H API-TOKEN:testing -H SERVICE-USER-ID:testing -H USER-TOKEN:testing localhost:3000/api/surveys/1

{
  "id": 74,
  "user_id": 1,
  "_links": [
    {
      "href": "http://localhost:3000/api/surveys/74",
      "rel": "self",
      "method": "GET"
    },
    {
      "href": "http://localhost:3000/api/surveys/74/survey_questions",
      "rel": "survey-questions",
      "method": "POST"
    }
  ],
  "completed": false,
  "survey_questions": []
}
```

### Creating an empty survey

```
curl -H Content-Type:application/json -H API-TOKEN:testing SERVICE-USER-ID:testing -H USER-TOKEN:testing -d '{ "survey": { "service_user_id": "d59dfd171d8915ee80927a6538a5526f53181b6d600510aa0cd43b27665a724d" } } localhost:3000/api/surveys

{
  "id": 74,
  "user_id": 36,
  "_links": [
    {
      "href": "http://localhost:3000/api/surveys/74",
      "rel": "self",
      "method": "GET"
    },
    {
      "href": "http://localhost:3000/api/surveys/74/survey_questions",
      "rel": "survey-questions",
      "method": "POST"
    }
  ],
  "completed": false,
  "survey_questions": []
}
```

## Survey Questions

### Retrieving all survey questions

```
curl -H Content-Type:application/json -H API-TOKEN:testing SERVICE-USER-ID:testing -H USER-TOKEN:testing http://localhost:3000/api/surveys/35/survey_questions

"survey_questions": [
  {
    {
      "id": 35,
      "text": "How do you feel right now?",
      "type": "range",
      "question_id": 1,
      "responses": [
        "0",
        "10"
      ],
      "answer": "10",
      "_links": [
        {
          "rel": "self",
          "href": "http://localhost:3000/api/surveys/74/survey_questions/35",
          "method": "GET"
        },
        {
          "rel": "self",
          "href": "http://localhost:3000/api/surveys/74/survey_questions/35",
          "method": "PUT"
        },
        {
          "rel": "surveys",
          "href": "http://localhost:3000/api/surveys/74",
          "method": "GET"
        }
      ]
    }
  }
]
```

Survey questions can also be scoped to the following keys:

* question_id
* key (the question_key of a question)
* survey_id

```
curl -H Content-Type:application/json -H API-TOKEN:testing SERVICE-USER-ID:testing -H USER-TOKEN:testing http://localhost:3000/api/surveys/35/survey_questions?question_id=1
curl -H Content-Type:application/json -H API-TOKEN:testing SERVICE-USER-ID:testing -H USER-TOKEN:testing http://localhost:3000/api/surveys/35/survey_questions?key=poptarts
curl -H Content-Type:application/json -H API-TOKEN:testing SERVICE-USER-ID:testing -H USER-TOKEN:testing http://localhost:3000/api/surveys/35/survey_questions?survey_id=1
```

### Retrieving a survey question
```
curl -H Content-Type:application/json -H API-TOKEN:testing SERVICE-USER-ID:testing -H USER-TOKEN:testing http://localhost:3000/api/surveys/35/survey_questions/151

{
  {
    "id": 35,
    "text": "How do you feel right now?",
    "type": "range",
    "question_id": 1,
    "responses": [
      "0",
      "10"
    ],
    "answer": "10",
    "_links": [
      {
        "rel": "self",
        "href": "http://localhost:3000/api/surveys/74/survey_questions/35",
        "method": "GET"
      },
      {
        "rel": "self",
        "href": "http://localhost:3000/api/surveys/74/survey_questions/35",
        "method": "PUT"
      },
      {
        "rel": "survey",
        "href": "http://localhost:3000/api/surveys/74",
        "method": "GET"
      }
    ]
  }
}
```


### Creating a survey question

```
curl -H Content-Type:application/json -H API-TOKEN:testing SERVICE-USER-ID:testing -H USER-TOKEN:testing -d '{ "survey_question": { "question_id": 31 } }' localhost:3000/api/surveys/35/survey_questions

{
  "id": 280,
  "question_id": 1,
  "text": "If you could, and it had no negative consequences, would you jump forward in time 24 hours?",
  "type": "boolean",
  "responses": [
    "t",
    "f"
  ],
  "answer": null,
  "_links": [
    {
      "rel": "self",
      "href": "http://localhost:3000/api/surveys/74/survey_questions/35",
      "method": "GET"
    },
    {
      "rel": "self",
      "href": "http://localhost:3000/api/surveys/74/survey_questions/35",
      "method": "PUT"
    },
    {
      "rel": "survey",
      "href": "http://localhost:3000/api/surveys/74",
      "method": "GET"
    }
  ]
}
```
### Updating a survey question

```
curl -X PUT -H Content-Type:application/json -H API-TOKEN:testing SERVICE-USER-ID:testing -H USER-TOKEN:testing -d '{ "survey_question": { "answer": "poptarts" } }' localhost:3000/api/surveys/35/survey_questions/151

# Returns a 204
```

