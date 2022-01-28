# Social Media Research

---

## Twitter

### Search Bar

 [Twitter](https://twitter.com/)'s search bar can be used to find tweets, people, and media related to the query.
 
 #### Keyword
 
 Return all items that contain the  keyword `nba`.
 
 ```txt
 nba
 ```
 
#### Multiple Keywords

Return all items that contain the keywords `nba` and `draft` (not necessarily in that order).

```txt
nba draft
```

#### Phrase

Return all items that contain the exact phrase `nba draft pick`.

```txt
"nba draft pick"
```

#### Hashtags

Return all items that contain the hashtag `#nba`.

```txt
#nba
```

#### `from`

Return all items produced by `@thecybermentor`.

```txt
from:thecybermentor
```

#### `to`

Return all replies to `@thecybermentor`.

```txt
to:thecybermentor
```

#### `since` & `until`

Return all items produced since 01 February 2019 until 01 March 2019.

```txt
since:2019-02-01 until:2019-03-01
```

`until` can be omitted if you want all items until the present moment.

#### `geocode`

Return all items tagged within 10km the given geocode.

```txt
geocode:34.0207305,-118.6919133,10km
```

### Command Line Tools

- [twint](https://github.com/twintproject/twint)

### Third-Party Twitter Analytics Web Applications

These applications provide analytical insights into the query term, from keywords to handles to hashtags and more. These insights include:

- Follower count
- Reach
- Geographic Tweet map
- Day of week and time of day analysis
- Relationships to other users (i.e., most retweeted, most replied to, most mentioned)

The applications:

- [TweetDeck](https://tweetdeck.twitter.com/)
- [Social Bearing](https://socialbearing.com/)
- [Twitonomy](https://www.twitonomy.com/)
- [Sleeping Time](https://sleepingtime.org/)
	- Just determines a user's sleeping time based on their Twitter activity
- [MentionMap](https://mentionmapp.com/)
	- Generates a graph of users Twitter user activity
	- Requires a paid account
- [Twitter Beaver](https://tweetbeaver.com/)
	- Contains several helpful Twitter utility tools, like converting a handle to an identifier

Example from  [Social Bearing](https://socialbearing.com/) to give you an idea of what these kinds of applications offer:

![[Pasted image 20220126160806.png]]

![[Pasted image 20220126160359.png]]

---

## Facebook

### Search Bar

[Facebook](https://www.facebook.com/)'s search bar can be used to find all kinds of content including posts, users, media, marketplace entries, pages, groups, events, and more. Each type of content also has extra filters available.

![[Pasted image 20220127092711.png]]

### Find a User's ID

1. Open their page
2. View the page's source
3. Ctrl-F for `userID` --> the user's ID is in a JSON object with that as its key

### Third-Party Facebook Graphing Web Applications

- [IntelligenceX](https://intelx.io/tools)

---

## Instagram

### Search Bar
 
#### Keyword

Return all items that contain the  keyword `nba`.

```txt
nba
```

#### Hashtags

Return all items that contain the hashtag `#nba`.

```txt
#nba
```

### Get a User's ID

Input their username into [this tool](https://codeofaninja.com/tools/find-instagram-user-id/).

### Download a Photo

Visit someone's profile on [imginn](https://imginn.com/). You can directly download the photos from there.

---

## Snapchat

Search bar and Snap Map.

---

## Reddit

Search bar.

---

## LinkedIn

Search bar.

[[theHarvester]] can also be used to perform LinkedIn enumeration.

---

## TikTok

Search bar.
