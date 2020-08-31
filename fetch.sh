echo '<doc xmlns:xlink="whatever">' >psalms.xml

# Intervals are based on a variable maximum threshold (probably based on word or byte count); YMMV!
curl "https://www.biblegateway.com/passage/?search=psalms+1-20&version=NIV" | xmllint --html --xmlout --format --c14n - >>psalms.xml
curl "https://www.biblegateway.com/passage/?search=psalms+21-36&version=NIV" | xmllint --html --xmlout --format --c14n - >>psalms.xml
curl "https://www.biblegateway.com/passage/?search=psalms+37-51&version=NIV" | xmllint --html --xmlout --format --c14n - >>psalms.xml
curl "https://www.biblegateway.com/passage/?search=psalms+52-69&version=NIV" | xmllint --html --xmlout --format --c14n - >>psalms.xml
curl "https://www.biblegateway.com/passage/?search=psalms+70-81&version=NIV" | xmllint --html --xmlout --format --c14n - >>psalms.xml
curl "https://www.biblegateway.com/passage/?search=psalms+82-97&version=NIV" | xmllint --html --xmlout --format --c14n - >>psalms.xml
curl "https://www.biblegateway.com/passage/?search=psalms+98-107&version=NIV" | xmllint --html --xmlout --format --c14n - >>psalms.xml
curl "https://www.biblegateway.com/passage/?search=psalms+108-119&version=NIV" | xmllint --html --xmlout --format --c14n - >>psalms.xml
curl "https://www.biblegateway.com/passage/?search=psalms+120-145&version=NIV" | xmllint --html --xmlout --format --c14n - >>psalms.xml
curl "https://www.biblegateway.com/passage/?search=psalms+146-150&version=NIV" | xmllint --html --xmlout --format --c14n - >>psalms.xml

echo '</doc>' >>psalms.xml
