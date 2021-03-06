Exercise 3
================
Alex Rados, Akhil Jonnalagadda, and Kenny Kato

# Predictive Model Building

## Overview

The goal at hand is producing the best model to predict rental income
per square foot of commercial rent buildings across the United States.
The main variable we are interested in is their green rating, whether
the building has been awarded LEED or EnergyStar certification (or both)
as a green building, and how that affects the rental price. We will thus
build a predictive model for price using the variables provided and
evaluate the effect of having a green rating or not.

## Data

We will be looking at the green buildings dataset to assess how the rent
price (in dollars per square foot per calendar year) of commercial rent
buildings across the United States is effected by a variety of variables
including size (total square footage of available renting space), number
of floors, and their green rating, to list a few.

Using these variables, we will fit a random forest model, attempting to
get the most accurate prediction of rent prices based on the variables
provided. The accuracy of the model will be measured in the form of the
root mean-squared error (RMSE). Once we fit said model, we will use it
to quantify the average change in rental income per square foot
associated with green certification, holding other features of the
building constant.

In order to generate the most accurate predictions, however, we can’t
judge it based on past data that we have. Thus, we randomly sampled 80%
of the data at hand and used that as a training set on which we built
our model while using the other 20% as a test set on which we tested our
model to gather a sufficient RMSE. This then allows us to measure the
out-of-sample performance.

## Model

I decided on using a random forest model as it would give accurate and
legitimate results while not needing the specifics that boosting
requires. I initially began by setting a random forest model to
variables that I assumed would have a significant effect on rent price.

I began to whittle down the components of the model, getting rid of or
adjusting the variables that had the smallest effects on the SSE when
being included depending on the variable imporance plot.
![](Master-Branch_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

I finally ended up settling on the following model that resulted in the
lowest RMSE when attempting to predict the out-of-sample rent prices.
This was after ensuring that the random variation that comes with a
train/test split along with the model itself is taken care of and is
guaranteeing that we are choosing the model that is consistently the
best
predictor.

\[y = Agex_{1} + Class_ax_{2} + Class_bx_{3} + Green Ratingx_{4} + Amenitiesx_{5} + Sizex_{6} + Storiesx_{7} + Renovatedx_{8} + Precipitationx_{9} + Gas Costsx_{10} + Electricity Costsx_{11} + Total Degree Daysx_{12}\]

    ## [1] 7.433272

From this model, the average change in absolute terms in rental income
per square foot associated with whether one has a green certification or
not is as follows:

    ##   green_rating     yhat
    ## 1            0 28.43318
    ## 2            1 28.78113

## Conclusion

Through using a random forest model, we found an accurate way of
predicting rental income per square foot with a variety of variables.
While many made significant impacts on the dependent variable at hand,
the most important ones were electricity costs in the building’s
geographic region and size of the rental space. The least important
components were indeed whether the building was green certified by
either LEED or EnergyStar and the amenities that were included.

Thus, if a leasing company is looking to make the most out of the
factors that go into constructing and leasing a building, we would
recommend focusing on choosing the right region surrounding the project
and the size of the available space for rent.

# What Causes What?

1.  Why can’t I just get data from a few different cities and run the
    regression of “Crime” on “Police” to understand how more cops in the
    streets affect crime? (“Crime” refers to some measure of crime rate
    and “Police” measures the number of cops in a city.)

There is legitimacy to either argument that higher crime rates force a
leader to increase the size of the police force (high crime rates for
large police force) or a larger police force leads to lower crime rates
(low crime rates for large police force), giving opposing results to how
the amount of police affects crime rates.

We also are not necessarily asking a causal question here but rather a
correlation question, so a regression of crime on police wouldn’t answer
“does increasing the amount of cops lead to lower crime” because crime
rates affect the amount of police deployed (given one lives in a
reasonable neighborhood) yet the amount of police would also affect
crime rates. Because police is an endogenous variable, we would have to
bring in an instrumental variable that is exogenous and is related to
the size of the police force while not directly related to street level
crime rates. Enter, terrorism alert level.

2.  How were the researchers from UPenn able to isolate this effect?
    Briefly describe their approach and discuss their result in the
    “Table 2”, from the researchers’ paper.

You can’t effectively estimate street crime rates just by looking at
level of police force because of what we described earliers. Thus,
researchers wanted to find an example where there’s a lot of police for
reasons unrelated to crime, which ended up being the terrorism alert
system. This represents an instrumental variable, a variable that is
related to amount of police used but is not related at all with street
crime.

When the terror alert level goes to orange, extra police are used in
Washington D.C. to protect against possible terror attacks. This
shouldn’t be related at all to street crime, so then they could
evaluate those days when there’s extra police to see what happens to
street crime and not worry about street crime having an effect on the
amount of police deployed. Street crime does indeed go down in this case
and is significant at the 5% level, allowing us to reject the null that
the number of police doesn’t affect the crime rate.

3.  Why did they have to control for Metro ridership? What was that
    trying to capture?

They questioned whether it was possible that tourists were less likely
to be out when there is a terror alert level that is orange, which would
remove one of the two requirements for an instrumental variable that it
isn’t correlated with the outcome, crime rate. To combat this, they
controlled for metro ridership, thus including the possibility that the
street crime rate didn’t drop just because there were less people
outside (or, in the case of the original question proposed on the
podcast, that the criminals weren’t staying at home because of the
threat of terrorsim).

4.  Below I am showing you “Table 4” from the researchers’ paper. Just
    focus on the first column of the table. Can you describe the model
    being estimated here? What is the conclusion?

The model being estimated is a regression of crime rates in Washington
D.C. on high alert (whether there was a terror alert level of orange
which provides an unusual increase in the amount of police present)
interacted with the first district of Washington D.C. and high alert
interacted with all the other districts while still controlling for
Metro ridership.

We are seeing that there is a difference in the high alert police level
effects on crime rates between District 1 and every other district. When
there is an unusual influx of police to District 1 because of a high
terror level, it decreases crime rates more drastically than when there
is an increase in police in every other district (for District 1 it
would be a significant decrease at the 1% level while for the other
districts it wouldn’t be significant at all). This provides some
evidence that maybe an increase in police in District 1 provides a
decrease in street crime while for every other district we can’t reject
the null that the crime rate does not change with a change in amount of
police.

# Clustering and PCA

This problem required us first to pick an appropriate clustering method
and run both that method and PCA. From this we had to choose the optimal
method in identifying colors red and white. Logically, I used K Means
clustering to separate these wines. This data set had a handful of
variables that were used to measure each sample and it mapped to quality
and color. The goal of K clustering is to average over these variables
so that the average of each samples’ characteristics would link to the
nearest similar cluster.

In my analysis, I had to figure out what K to use. I created an elbow
plot, a graph of the mean sum of squares where the optimal K would be
its tangent point. I found the ideal K would be 3 for this analysis.

![](Master-Branch_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

After finding the optimal K, I used it to run K Means and create 3
clusters. To run this analysis I made colors binary, red=1 and white=0.
I linked the appropriate clusters to red or white. If the value of the
color column was greater than .5 then the cluster would be classified as
a red wine, and if not, it would be classified as a white. From this we
had our predictions of red and white wines, as shown in the following
graphs.

![](Master-Branch_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->![](Master-Branch_files/figure-gfm/unnamed-chunk-8-2.png)<!-- -->![](Master-Branch_files/figure-gfm/unnamed-chunk-8-3.png)<!-- -->

From these three graphs we see that there is grouping of reds and
whites. The red wines have higher levels of sulfur and a smaller range
of sulfate levels. The second graph shows us that citric acids are
relatively spread the same but red wines have hiring chloride counts
than white. Our third graph shows us that red wines are not as sweet as
white wine and tend to have a higher spread of acidity.

We also see an important factor to consider is that there is overlap of
red and white wines at times. This is due to the fact that the
clustering is not perfect and we thus face some level of error as wines
are similar in the chemical breakdown Now we should compare to the PCA
analysis to separate reds and whites. I scaled the data set and sorted
the data and ran PCA. The summary showed that the first two components
explained most of the variation of the data. From this, the data was
plotted and mapped to show reds and whites. We see that the difference
is more distinct when separating the two groups. We see that PCA does a
better job of decipering between red and white wines with less overlap
of the data, making it a better technique.

![](Master-Branch_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

## Wine Quality Ranking

Part two of this assignment was to find a way to rank the quality of
wines. I went with a PCA because it was more accurate on this data set
and it works better when there are higher levels of correlation like in
our wine set.

I ran a similar method to the PCA earlier for the wine quality problem.
The goal was to split the quality of wines into seven individual groups.
From our graph we see there is some slight differences between the
groups. The left chunk is slightly lighter than the right chunk. This
shows there is some light separation of quality. However as a whole we
can’t find definite segments of quality.

The reason that this could be that there is a high level of correlation
between all the variables regardless of quality. By this I mean there is
less differentiation of wine quality from the chemical make up.

![](Master-Branch_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

After our failed PCA for quality I tried out K means approach to see if
there was an alternative approach. I ran a parallel method as the wine
color clustering method to cluster for quality. I ran into a similar
issue where I could not separate for each of the qualities . In the
density graphs we see that the majority of the wines grouped around 5
and 6. This supports that the individual wine qualities were not
identified. We also see that the majority of the clusters were showing
clusters that averaged around 5 or 6. This supports the idea that the
variables were too highly correlated to help us segment quality as the
clusters were just similar to average quality of the data
set.

![](Master-Branch_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->![](Master-Branch_files/figure-gfm/unnamed-chunk-14-2.png)<!-- -->![](Master-Branch_files/figure-gfm/unnamed-chunk-14-3.png)<!-- -->![](Master-Branch_files/figure-gfm/unnamed-chunk-14-4.png)<!-- -->

## Conclusion

In summary of analysis, both K means clustering and PCA were able to
show us separate segments of red and white. When running a similar
process for wine quality we found that it was not possible to separate
each wine on the quality rating. The assumption is that the wines are
all very similar in their breakdown regardless of the quality group they
fall in.

# Market Segmentation

**Background:** Defined market segments are fundamental for guiding a
marketing strategy and as such, we valued clarity, ease of
communication, and relevance throughout this project. Market
segmentation, in our view, is not just a categorization scheme, but a
basis for action.

While we tried agglomerative hierarchical clustering (since we suspected
that tags like “chatter” might be an umbrella with several
distinct/relevant sub-characteristics) and principal components analysis
(PCA), in order to distill any correlations, we thought that K-means++
conveyed the clearest insights. By use of K-means++, we are able to
discern and characterize 6 distinct market segments that may help inform
the marketing strategy of NutrientH20.

## Pre-Processing

To prune the dataset, we:

  - Deleted records that carried at least one “adult” and one “spam”
    label, judging their credibility to be in question while not
    significantly slashing the size of the dataset
  - Deleted records whose labels were more than 25% “adult,” for both
    credibility and usefulness concerns (our thinking being that
    excessively adult-oriented users are unlikely to inform any useful
    marketing strategy for NutrientH20)
  - Deleted the “spam” feature, since only three records left had a
    single spam label

Overall, we think these steps made a more trustworthy and useful
dataset.

## Market Segments (K-Means++)

**Choosing K:** Our first task was to choose a reasonable number of
clusters. In pursuit of an optimal number, we employed an elbow plot,
the CH-Index, and the gap statistic, all to no avail, so we decided to
just pick one. After some test runs, we settled on 6 clusters that were
most identifiable.

Each cluster is listed below, ordered by size from smallest to largest,
with their eight most common labels and a short description (it should
be noted that “chatter” and “photo-sharing” are in each cluster’s top
8):

#### The Youthful:

Number of users:

    ## [1] 434

Top 8 labels:

    ##                  Label Count Center Value
    ## college_uni             4553    10.490783
    ## online_gaming           4127     9.509217
    ## chatter                 1926     4.437788
    ## photo_sharing           1225     2.822581
    ## sports_playing          1128     2.599078
    ## tv_film                  787     1.813364
    ## health_nutrition         763     1.758065
    ## travel                   675     1.555300

This cluster - the smallest - looks like a young group: concerned with
college, with time to spend on gaming, and energy to spend on playing
sports. At risk of sounding old-fashioned, these traits also appear to
be those traditionally associated with males.

#### The Aesthetic:

Number of users:

    ## [1] 572

Top 8 labels:

    ##                  Label Count Center Value
    ## cooking                 6174    10.793706
    ## photo_sharing           3500     6.118881
    ## fashion                 3180     5.559441
    ## chatter                 2852     4.986014
    ## beauty                  2222     3.884615
    ## health_nutrition        1297     2.267483
    ## shopping                1191     2.082168
    ## current_events          1015     1.774476

This group must be the best-looking: it has very photogenic interests,
and exploits as much, as evidenced by the high ranking of
“photo-sharing.” Their particular affinity for cooking could explain
their interest in NutrientH20. Again risking sounding old-fashioned,
these appear to be traditionally female interests.

#### The Worldly:

Number of users:

    ## [1] 677

Top 8 labels:

    ##               Label Count Center Value
    ## politics             6072     8.968981
    ## travel               3799     5.611521
    ## news                 3605     5.324963
    ## chatter              3084     4.555391
    ## photo_sharing        1725     2.548006
    ## computers            1671     2.468242
    ## automotive           1592     2.351551
    ## sports_fandom        1365     2.016248

Dominated by politics, travel, and news, this group is probably full of
subscribers to the New York Times and \#wanderlust hashtags.

#### The Domestic:

Number of users:

    ## [1] 755

Top 8 labels:

    ##               Label Count Center Value
    ## sports_fandom        4446     5.888742
    ## religion             3968     5.255629
    ## food                 3457     4.578808
    ## chatter              3208     4.249007
    ## parenting            3061     4.054305
    ## school               2036     2.696689
    ## photo_sharing        1984     2.627815
    ## family               1889     2.501987

This seems to be a fairly conservative group of people, focused much
more on close-to-home issues. Hilariously, as much as they post about
family, parenting, and religion, their sports team is second-to-none.

#### The Healthy:

Number of users:

    ## [1] 884

Top 8 labels:

    ##                  Label Count Center Value
    ## health_nutrition       10621    12.014706
    ## personal_fitness        5687     6.433258
    ## chatter                 3863     4.369910
    ## cooking                 2896     3.276018
    ## outdoors                2413     2.729638
    ## photo_sharing           2351     2.659502
    ## food                    1877     2.123303
    ## current_events          1377     1.557692

Not surprisingly, followers of NutrientH20 tend to post about
health/nutrition, fitness, cooking, and the great outdoors. This is the
largest cluster of users that don’t belong to…

#### Everybody Else:

Number of users:

    ## [1] 4448

Top 8 labels:

    ##                  Label Count Center Value
    ## chatter                19354     4.351169
    ## photo_sharing          10281     2.311376
    ## current_events          6420     1.443345
    ## shopping                5750     1.292716
    ## health_nutrition        4889     1.099146
    ## travel                  4859     1.092401
    ## politics                4526     1.017536
    ## tv_film                 4466     1.004047

Finally, this cluster - by far the largest - looks like somewhat of a
hodgepodge of characteristics, dominated by generic traits like
“chatter” and “photo sharing.” It admittedly seems like a cop-out to
call them “everybody else” when we’re trying to identify
characteristics; however, this cluster is distinguished by one thing in
particular:

## Frequent vs. Infrequent Users

While we don’t have information on how many posts each user posted over
the sample week, we can use the number of labels associated with them as
a proxy, assuming the number of labels per individual post is fairly
invariant across users. Here is the distribution of labels:

![](Master-Branch_files/figure-gfm/unnamed-chunk-30-1.png)<!-- -->

For each cluster, we divided the total number of labels by the number of
users to obtain average labels per user. All 5 of our minority clusters
average around 60 labels per user – on the higher end of the above
distribution. The sixth and largest cluster averages around 28, which is
where we see the largest mass of users in the distribution. We interpret
that to mean that frequent posters are more likely to convey tendencies
than less frequent posters (and are more engaged with Twitter itself).
K-means++ diligently sorted out the trends it could confidently find
from frequent posters and apparently sorted the less frequent posters
into their own cluster.

## Conclusion

While it might be initially frustrating that our largest cluster seems
to lack actionable distinctions, we think that patterns shown by users
who display a high engagement with Twitter are highly valuable, and
possibly represent latent behaviors of our less frequent posters. By
targeting the revealed patterns of minority, high-frequency users -
whether they are young, fashionable, worldly, domestic, or
health-conscious - NutrientH20 may yet increase the engagement of
Everybody Else.
