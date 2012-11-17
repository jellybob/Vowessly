Vowessly
--------

This is a wiki designed for historical research. As such while it has the concept of pages
which all wikis do, it also has more structured "Facts", which allow multiple pages to be
linked together organically.

Facts can have sources and notes attached to them, to provide extra detail on how they're
relevant to the current page. Some facts may cause another page to be created.

It's being built for my wife, who is starting a PhD, and will gain features as they're needed,
but feel free to use it if you find it useful. Who knows, maybe you to are building a database
of medieval vowesses, in which case, you'll almost certainly find it useful. It should in theory
be a decent place to start with any sort of research data though.

An Example
----------

For this example, we're going to be using Alice Hampton, who died in 1516.

She gets a page to herself, marked with the "Person" type.

There's some text about her, which takes much the same form as any other wiki page you've seen. Lots
of dense text. Then we get to the facts.

Died: 1516
Father: John Hampton II
Birth place: Minchinhampton, Gloucestershire

Those facts will each have a source attributed to them, possibly some extra notes, but most interestingly
they'll have their own pages as well. By following the link to John Hampton II for example, you'll get some
information about him, and possibly be able to follow his family tree around.

The birth place, being a location, will also be geocoded. That gives the possibility of integration with a
mapping service, letting you find all the medieval vowesses in the area. Vowtastic!

Setting up your own copy of Vowessly
------------------------------------

So, you're convinced are you? Here's how to get your own version of Vowessly running for free on Heroku.

(This might work on Windows, but you may be better off borrowing a Mac from someone.)

Create a Heroku account at http://heroku.com

Download and install the Heroku toolbelt from https://toolbelt.heroku.com/

Open a terminal (you can find it in the "Utilities" folder of your Applications)

Enter the following commands, changing "my-vowessly" to a name of your choice.

    export name="my-vowessly"
    git clone git@github.com:jellybob/Vowessly
    cd Vowessly
    heroku login
    heroku create $name
    ./script/setup_heroku_app $name
    git push heroku master

Go to http://my-vowessly.herokuapp.com/, where you can now find your own version of Vowessly!

Optionally, if you want a username and password, run these commands as well:

    heroku config:set APP_USERNAME="your-username" APP_PASSWORD="your-password"
    heroku restart

Help! I'm Just a Researcher!
----------------------------

If you're a researcher, and want to use this software yourself, drop me a message. I should be able to get a
version running for you quite quickly.

If you're an academic department which wants to use this software, I do software consultancy for a living. Do
feel free to pay me to make changes for you ;)
