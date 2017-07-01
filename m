From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: [PATCH 2/2] make for-loop statement simpler
Date: Sat, 01 Jul 2017 16:03:38 +0200
Message-ID: <1498917818.7320.1.camel@petrovitsch.priv.at>
References: <20170628204918.25853-1-luc.vanoostenryck@gmail.com>
         <20170628204918.25853-3-luc.vanoostenryck@gmail.com>
         <CANeU7Qm8Qjf--w-7dc1J5qXhORPoPduc859-tk0-75L8Gx5iww@mail.gmail.com>
         <20170629031804.tptm423ouo3a5ma4@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:1325 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdGAO4B (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Jul 2017 10:56:01 -0400
In-Reply-To: <20170629031804.tptm423ouo3a5ma4@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, 2017-06-29 at 05:18 +0200, Luc Van Oostenryck wrote:
> On Wed, Jun 28, 2017 at 05:18:18PM -0700, Christopher Li wrote:
> > On Wed, Jun 28, 2017 at 1:49 PM, Luc Van Oostenryck
> > <luc.vanoostenryck@gmail.com> wrote:
> > > The for-statement needs a lot of fields in struct statement, much
> > > more than any other statement. This is due to the complexity of
> > > the for-statement.
> > > 
> > > However part of this complexity can be removed by processing the
> > > 'pre-' statement separately from the loop. This is equivalent to
> > > transform a single-statement for-loop like:
> > >         for (pre; cond; post)
> > >                 body
> > > into a compound statement like:
> > >         pre;
> > >         for (;cond; post)
> > >                 body;
> > 
> > Notice that the two are not exactly the same.
[...]
> Yes, and the patch take care of the scope too.
Just update the explanation to
----  snip  ----
transform a single-statement for-loop like:
        for (pre; cond; post)
                body
into a compound statement like:
{
        pre;
        for (;cond; post)
                body;
}
----  snip  ----
which makes it identical.

MfG,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
