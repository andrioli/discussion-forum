# discussion-forum

This is a simple discussion forum API written in Ruby on Rails framework.

## Running Locally

Make sure you have [Ruby](https://www.ruby-lang.org) (>= 2.0.0) and [Bundler](http://bundler.io) installed.

```sh
git clone git@github.com:andrioli/discussion-forum.git
cd discussion-forum
bundle
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rails s
```

## Implementation Design

* The API is written in Ruby on Rails without any extra `gem` other than the provided by `rails new` command.
* A few tests were provided and can be executed with `rake test` command.
* The hierarchy of posts/threads was implemented with materialized paths. This allow query entire conversations with simple and efficient SQL statements.

## Caveats

* For the sake of simplicity, the maximum number of posts/threads per page and the black list of words for censorship was implemented  as hard coded constants.
* N+1 query problem: Even with materialized paths representing the posts/threads hierarchy, we are not taking advantage of it. i.e., we do not bring an entire conversation with a single query. The result is the same of a foreign key to the parent post/thread.

## API

### POST /posts

Create a post/thread.

#### Parameters

| Parameter | Description             |
| --------- | ----------------------- |
| title     | The post title          |
| email     | The post author's email |
| body      | The post content body   |

#### Example

##### Request

```sh
curl -H'Content-type: application/json' -i http://localhost:3000/posts -d '
{
  "title" : "Title text",
  "email" : "email@email.com",
  "body" : "Hello World"
}'
```

##### Response

```
HTTP/1.1 201 Created
```

```json
{
  "id" : 1,
  "title" : "Title text",
  "email" : "email@email.com",
  "body" : "Hello World",
  "created_at" : "2016-10-27T04:26:01.203Z",
  "comments" : [],
  "_links" : {
    "self" : "http://localhost:3000/posts/1"
  }
}
```

### GET /posts/:id

Return JSON data about a single post/thread.

#### Parameters

| Parameter | Description |
| --------- | ----------- |
| id        | The post ID |

#### Example

##### Request

```sh
curl -i http://localhost:3000/posts/1
```

##### Response

```
HTTP/1.1 200 OK
```

```json
{
  "id" : 1,
  "title" : "Title text",
  "email" : "email@email.com",
  "body" : "Hello World",
  "created_at" : "2016-10-27T04:26:01.203Z",
  "comments" : [],
  "_links" : {
    "self" : "http://localhost:3000/posts/1"
  }
}
```

### POST /posts/:id/comments

Create a comment for a post/thread. The comment is also a post/thread.

#### Parameters

| Parameter | Description                |
| --------- | -------------------------- |
| title     | The comment title          |
| email     | The comment author's email |
| body      | The comment content body   |

#### Example

##### Request

```sh
curl -H'Content-type: application/json' -i http://localhost:3000/posts/1/comments -d '
{
  "title" : "Comment title text",
  "email" : "other@email.com",
  "body" : "Foo Bar"
}'
```

##### Response

```
HTTP/1.1 201 Created
```

```json
{
  "id" : 2,
  "title" : "Comment title text",
  "email" : "other@email.com",
  "body" : "Foo Bar",
  "created_at" : "2016-10-27T04:38:01.098Z",
  "comments" : [],
  "_links" : {
    "self" : "http://localhost:3000/posts/2"
  }
}
```

### GET /posts

Return JSON data for all posts/threads. The result is paginated.

#### Parameters

| Parameter | Description                |
| --------- | -------------------------- |
| page      | The page number (optional) |

#### Example

##### Request

```sh
curl -i http://localhost:3000/posts?page=1
```

##### Response

```
HTTP/1.1 200 OK
```

```json
{
  "_meta" : {
    "total_pages" : 1,
    "page" : 1
  },
  "data" : [
    {
      "id" : 1,
      "title" : "Title text",
      "email" : "email@email.com",
      "body" : "Hello World",
      "created_at" : "2016-10-27T04:26:01.203Z",
      "comments" : [
        {
          "id" : 2,
          "title" : "Comment title text",
          "email" : "other@email.com",
          "body" : "Foo Bar",
          "created_at" : "2016-10-27T04:38:01.098Z",
          "comments" : [],
          "_links" : {
            "self" : "http://localhost:3000/posts/2"
          }
        }
      ],
      "_links" : {
        "self" : "http://localhost:3000/posts/1"
      }
    }
  ],
  "_links" : {
    "self" : "http://localhost:3000/posts?page=1",
    "first" : "http://localhost:3000/posts?page=1",
    "last" : "http://localhost:3000/posts?page=1"}
  }
```
