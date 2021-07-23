---
author: peter
date: 2021-07-23 10:08:00+00:00
draft: false
title: "On the Economics of Streaming: Show me the money"
type: post
categories:
- Technology
featured_image: netflix_spotify.jpg
---
I've never spent as much money on music or TV and movies as I do now by paying
my Spotify and Netflix subscriptions. But still artists apparently [aren't
getting any money](https://www.google.com/search?q=artists+streaming+payments)
for their art. How can this be? Where is the money going?

[Below](#back-of-the-napkin-calculation)
I've done a back-of-the-napkin calculation. If all the premium money went to
artists we should be listening 45.5 hours/month, but on average, we
[*actually*](https://kommandotech.com/statistics/spotify-user-statistics/)
listen 25 hours/month. Which means that Spotify is keeping 45% of my
subscription, and only paying 55% to artists.

However, [Spotify is actually operating at a
loss](https://www.statista.com/statistics/813713/spotify-revenue/) and has been
since its inception. According to Spotify this is due to:

> high costs in areas such as content creation, marketing, and sales as well as
> securing rights of audio and video content

I have been assuming that "securing rights of audio and video content" is part
of the $0.003-$0.005 pay rate. But does Spotify have other expenses paid to
rightsholders?

So even though it would be satisfying to point the finger at Spotify (and Netflix and the other streaming platforms), it seems that at least it isn't Spotify that is hoarding all the money. So where is the money?

* Am I atypical, and is the problem that people just aren't paying for music
  any longer?
* Is operating a streaming platform really that expensive that it eats 45% of all the streaming money?
* Are the rightsholders hoarding all the money?

I know I'm paying more for music (and TV/movies) than ever before. And artists
are apparently not getting paid nearly as much as previously. Do you know where
the money is? Because I can't find it...

## Appendix: Back-of-the-napkin Calculation {#back-of-the-napkin-calculation}

I've found these figures to try to calculate how many hours a month I would
need to listen to Spotify if all my subscription where to go to artists:

* The [price for Spotify](https://www.spotify.com/us/premium/) (in the US where it is cheaper by far than here in
  Denmark): 9.99 $/month
* [Pay Rate for Spotify Streams](https://help.songtrust.com/knowledge/what-is-the-pay-rate-for-spotify-streams): $0.003 to $0.005 a stream: We'll go with $0.005.
* [Average stream length (2019)](https://www.music-jobs.com/uk/article/news/news-pop-songs-are-getting-shorter-a-new-study-finds): 3 mintues
* Spotify has 113 million premium subscribers but 248 million monthly active users ([source](https://kommandotech.com/statistics/spotify-user-statistics/)).
* On average, Spotify’s active users listen to 25 hours of content monthly ([two](https://kommandotech.com/statistics/spotify-user-statistics/) [sources](https://www.statista.com/statistics/813876/spotify-monthly-active-users-time-spent-listening/))
* The majority of [Spotify's revenues comes from its premium
  subscribers](https://www.statista.com/statistics/245125/revenue-distribution-of-spotify-by-segment/)
  rather than ad placements, so lets assume that the income from the
  non-premium users is $0, even though Spotify serves ads to them.

* 1 month = 60 * 30 minutes

<!-- HUGO: mathjax -->
{{< mathjax/block >}}\[
\begin{align*}
    Income_{per \: user} &= \frac{9.99 \frac{\$}{month \cdot active \: user} \cdot 113 \: active \: users}{248 \: \displaystyle users} = 4.55 \frac{\$}{month \cdot user} \\[10 pt]
    N_{minutes/month} &= \frac{4.55 \frac{\$}{month}}{0.005 \frac{\$}{song}} \cdot 3 \frac{minutes}{song} \Leftrightarrow \\[10 pt]
    N_{minutes/month} &= 2730 \frac{minutes}{month} \Leftrightarrow \\[10 pt]
    N_{hours/month} &= 45.5 \frac{hours}{month} \Leftrightarrow \\[10 pt]
    N_{hours/day} &= 1.5 \frac{hours}{day}
\end{align*}
\]{{< /mathjax/block >}}
