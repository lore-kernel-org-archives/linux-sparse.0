From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: Re: [PATCH] Fixup and cleanup of the modifier_string() function
Date: Tue, 14 Sep 2010 16:37:23 +0200
Message-ID: <1284475043.6699.152.camel@thorin>
References: <1282300429.10440.230.camel@thorin>
	 <AANLkTikugbBQ1gYVAdFRxWVmEX-odjq+Y5wA4mnN7Vnj@mail.gmail.com>
	 <1282466539.5200.1.camel@thorin>
	 <AANLkTinT5xhr+C4H71CWx3R9EqHy6ycp8gskjUqjts2Q@mail.gmail.com>
	 <1282574577.5200.18.camel@thorin>
	 <AANLkTikOGhqVu8+A_kT=95AX=10H_pxhwqLmQr+08zzm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:2100 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751950Ab0INOhb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 14 Sep 2010 10:37:31 -0400
In-Reply-To: <AANLkTikOGhqVu8+A_kT=95AX=10H_pxhwqLmQr+08zzm@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Fre, 2010-09-03 at 02:13 -0700, Christopher Li wrote:
> On Mon, Aug 23, 2010 at 7:42 AM, Bernd Petrovitsch <bernd@sysprog.at> wrote:
> > Fixup and cleanup of the modifier_string() function
> >
> > This patch does:
> > - it fixes the modifier_string() function
> > - The array with the names is made "static".
> 
> Sorry for the late reply.

No problem - August is holiday time (at least hereover) and if there are
more pressing issues.

> Your patch does not apply to the chrisl repository. I also notice that

They were against git://git.kernel.org/pub/scm/devel/sparse/sparse.git
which is listed on https://sparse.wiki.kernel.org/index.php/Main_Page.
But your patch doesn't apply against it. And it doesn't apply against
git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git - which
looks at the first glance identical to the above.

I found http://marc.info/?l=linux-sparse&m=126634898432123 but there is
no "chrisl" branch - at least not in the output of `git branch -a`.
What I'm doing wrong?

> if modifier
> is zero, it will return buffer without initialized. Well the modifier

Ooops, ACK.
Grrml, not the first time in my life that I forgot that.

> is not supposed
> to be zero, but still.
> 
> Another thing in the patch is that I don't want to move the modifier
> bits for just the debug
> function. It is expected to have more change in the modifier bits. How about
> this patch? I start with your patch and end up like this.

Yes, the associative array is the better solution.
And the buffer overflow is also fixed.

> If that works for you, please sign it off and I will check it in.

It works for me.
Signed-off-by: Bernd Petrovitsch <bernd@sysprog.at>

	Bernd
-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services

