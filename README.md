# bible-for-anki

This is a quick project to get the Book of Psalms into an [Anki](https://apps.ankiweb.net/)
flashcard deck in a compact but mnemonic format using just the first letter of each word.

Inspiration for this tool: https://teddyray.com/how-to-memorize-lots-of-scripture/

Dependencies:

 * bash
 * cURL
 * xmllint
 * Saxon-HE

Steps to getting to your cards:

1. Run *fetch.sh* to download all of the Psalms (stored in psalms.xml).
2. Run *transform.sh* to generate supermemo.xml. Optionally specify a card format.
   You can generate full-text cards, shorthand cards, or a hybrid (with the shorthand
   in the Question and the full text in the Answer). Run:
    * `./transform.sh full-text` (the default behavior if the argument is omitted),
    * `./transform.sh shorthand`, or
    * `./transform.sh hybrid`
3. Import supermemo.xml into Anki.

Both shell scripts are simple enough that you could probably adapt them easily enough
to your own environment.

Be advised that the XSLT is breakable; the (screen-scraped) output of BibleGateway.com
is naturally subject to change.
