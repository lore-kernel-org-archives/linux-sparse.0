From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] cpp: silently allow conditional directives within macro
Date: Mon, 16 Mar 2020 01:46:22 +0100
Message-ID: <20200316004622.hoiz72yi2wloz25g@ltop.local>
References: <CAHk-=wiNPBt4wNkfgSd_utshPkjqQv-z7cg5iCji2jbFAUrLkg@mail.gmail.com>
 <20200312211630.53710-1-luc.vanoostenryck@gmail.com>
 <20200313161748.GA22910@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51462 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgCPAq1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 15 Mar 2020 20:46:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id a132so15834969wme.1
        for <linux-sparse@vger.kernel.org>; Sun, 15 Mar 2020 17:46:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200313161748.GA22910@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Mar 13, 2020 at 05:17:48PM +0100, Oleg Nesterov wrote:
> On 03/12, Luc Van Oostenryck wrote:
> >
> > @@ -2098,6 +2103,12 @@ static void handle_preprocessor_line(struct stream *stream, struct token **line,
> >  		if (false_nesting)
> >  			goto out;
> >  	}
> > +
> > +	if (expanding) {
> > +		if (Wdirective_within_macro && !is_cond)
>                     ^^^^^^^^^^^^^^^^^^^^^^^
> I am not sure Wdirective_within_macro is really useful after this change,
> I'd suggest to drop my patch but this is up to you.

Yes, it makes much less sense now. I've replaced that by supporting
-pedantic.
 
> > +			warning(start->pos, "directive in macro's argument list");
> > +		expanding = 0;		// warn only once
> > +	}
> 
> then you should probably update preprocessor22.c ? See below.
> 
> I am not sure about validation/preprocessor/expand-redef.c added by the
> previous patch,

Yes, I hadn't updated the testcases because the patch just a RFC
to see if just allowing the #if/... was OK (but I forgot to mark
is as such) and they also depended on the previous RFC patch about
the expansion of newline.

Series updated and pushed now.
Thanks for the review.

-- Luc 
