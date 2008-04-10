From: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Thu, 10 Apr 2008 18:05:31 +0200
Message-ID: <200804101805.31854.philipp.reisner@linbit.com>
References: <20080410132519.049821000@sipsolutions.net> <200804101746.14457.philipp.reisner@linbit.com> <1207842687.13354.12.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aug.linbit.com ([212.69.162.22]:42754 "EHLO mail.linbit.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758829AbYDJQFe (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Apr 2008 12:05:34 -0400
In-Reply-To: <1207842687.13354.12.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

Am Donnerstag, 10. April 2008 17:51:27 schrieb Johannes Berg:
> > I also worked on that part, although I have to admitt that I did not
> > got that part of the manpage. Instead I invented the require_context
> > attribute.
>
> Heh.
>
> > Here is the second patch. It applies on top of the first one...
>
> I don't really have time to look through it right now, sorry.
>
> > I hope that we get the good ideas of our two works combined and
> > accepted into sparse...
>
> That would be good :)
>

>
> What's this "rdwr" etc. for? And "call"? Also, how are you planning to
> handle nested contexts, where 1,1 doesn't cut it any >0,>0 is really
> more like what we need?
>

I also use it to check a recusive lock mechanism. 

The sematics of what I implemented is:
You simply use the __attribute__((context(ctx,in,out))) to
annotate the context changes of functions.

to annotate a variable, struct/union member or a function that
a certain locking primitive is required for accessing it, you
do it by 

__attribute__((require_context(ctx,min,max,"type")))

ctx ... the expression that describes the locking primitive
min ... the minimum of locks required of that locking primitive
max ... the maximum allowed of locks of that locking primitive.
type .. read, write, rdwr or call for the access type.

So you can express you need to hold this and that locking 
primitive to write to something. But an other locking
primitive might be sufficient for reading that something.

The annotation for a variable foo protected by a recursive lock
bar would be:

int foo __attribute__((require_context(bar,1,99999,"rdwr")))

PS: I just realized that there my e-mail client introduced linebreakes
    in the first patch I posted. I will repost on request of course.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
