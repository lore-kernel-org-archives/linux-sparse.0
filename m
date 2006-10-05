From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: Moving smatch to use sparse
Date: Fri, 06 Oct 2006 00:46:35 +0200
Message-ID: <45258B4B.6010907@redhat.com>
References: <a63d67fe0607140925h3665cd98ibc2fab07f6f80360@mail.gmail.com>	 <a63d67fe0607151742l6a387783x59494b84de80be88@mail.gmail.com>	 <a63d67fe0610050141x251253fei59b93fff28505dc4@mail.gmail.com>	 <45252A39.3050008@redhat.com> <a63d67fe0610051358j6181f558p2baaf1b59b0a042e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:50564 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751364AbWJEWqv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Oct 2006 18:46:51 -0400
In-Reply-To: <a63d67fe0610051358j6181f558p2baaf1b59b0a042e@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: smatch-discuss@lists.sourceforge.net, linux-sparse@vger.kernel.org

Dan Carpenter wrote:
> On 10/5/06, Michael Stefaniuc <mstefani@redhat.com> wrote:
>> Dan Carpenter wrote:
>> > Work on smatch is going ahead.  I have one real life check is working
>> > and I've added a patched up the core code quite a bit.
>> great work! What about the old smatch.pm and perl scripts? Will i be
>> still able to use those or would i have to port them over? I'm still
>> using the old smatch on checking Wine.
> 
> They'll have to be ported I'm afraid.
That's not realy a problem especialy as i can keep using the old smatch
for a while.

> Rewrites are a pain, but it's worth it because now it's easier to
> install, it's easier to use, and it runs a bajillion times faster.
I'm more concerned about how easy it is to write new "scripts" or modify
existing ones. For Wine I use only unreached-code.pl as is. Due to the
Win32 API i had to modify unfree.pl quite a bit.

> Using sparse also buys us a bunch of features for free, for example if
> you have 'i' defined in two different scopes with sparse handles that.
> Another example is compound conditions.  The old code was confused by
> stuff like:
> if (a && a->foo() || a && a->bar())
> there wasn't a good way to deal with that with the old way.
> 
> Which checks do you use most?  I'll port those first...
The scripts used regularly for Wine are on
http://people.redhat.com/mstefani/wine/smatch/scripts.html. Except that
i use only unreached-code.pl from the original smatch scripts.
Though not all scripts are that usefull; i probably could throw out
immediately while_for_check.pl and crosscalls_WtoA.pl. Most successfull
script is redundant_null_check.pl (finds "if (bla) free(bla);") as i had
only 2 false positives until now. unfree-wine.pl is the adaptation+bug
fixes of the original unfree.pl (usefull but lots of false positives).
The other usefull script is wine_locks.pl that found quite a few missing
unlocks on error paths. And i have some other ideas about a couple of
usefull smatch scripts for Wine but lack the time to implement them.

So most usefull would be a short documentation how to port things. Maybe
a short mapping between the most importand smatch.pm functions and their
 C counter part would be enough for the start. I looked at the smatch
sparse diff and it didn't look that complicated to use. I have anyway a
longish train ride next week so i will give it a try; maybe with an easy
and dumb version of redundant_null_check.pl

bye
	michael
-- 
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
Red Hat GmbH                    Email: mstefani@redhat.com
Hauptstaetterstr. 58            http://www.redhat.de/
D-70178 Stuttgart
