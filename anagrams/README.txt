=== Question #1: Anagrams

Two words are said to be 'anagrams' if the letters of one word can be rearranged to form the other word.  For example, in English, 'ascot' and 'tacos' are anagrams; so are 'tacos' and 'coats'.  A set of words that are all anagrams of one another is an 'anagram set'.  For example,

       ascot coast coats tacos

is an anagram set.

Letter case doesn't matter, so, for example, 'liberating' and 'Gilbertian' are considered to be anagrams.

Write a program, 'make_anagrams', which reads from stdin a list of words, one per line, and finds all the anagrams in the the word list.  It should output an anagram dictionary, as follows:

* 'Words' that contain digits or punctuational characters should be discarded.

* Anagram sets that contain only one word should be omitted from the output.

* If an anagram set contains two words, say 'halls' and 'shall', the output should contain two lines:

       halls shall
       shall halls

* If an anagram set contains more than two words, the entire set should be listed under the alphabetically first word; the others should cross-reference it.  For example:

       headskin nakedish sinkhead
       nakedish (See 'headskin')
       sinkhead (See 'headskin')

* The output lines should be in alphabetic order.

For example, if the input was

       5th
       ascot
       ate
       carrot
       coast
       coats
       cots
       Dorian
       eat
       halls
       headskin
       inroad
       nakedish
       ordain
       Ronald's
       shall
       sinkhead
       tacos
       tea

then the output should be:

       Dorian inroad ordain
       ascot coast coats tacos
       ate eat tea
       coast (See 'ascot')
       coats (See 'ascot')
       eat (See 'ate')
       halls shall
       headskin nakedish sinkhead
       inroad (See 'Dorian')
       nakedish (See 'headskin')
       ordain (See 'Dorian')
       shall halls
       sinkhead (See 'headskin')
       tacos (See 'ascot')
       tea (See 'ate')

