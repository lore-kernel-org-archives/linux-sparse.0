From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] mark pseudo user as deleted instead of removing them
Date: Fri, 4 Aug 2017 21:12:18 +0200
Message-ID: <20170804191216.x35bhjg6uskvzzu3@ltop.local>
References: <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
 <20170804002230.5047-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=eNTqHRS__DPFnoOMH7vnUJHRh+3wCcFR-EF_SB7zmSA@mail.gmail.com>
 <CANeU7Q=Lsy+_5qBVGGBhK9ux5pJDVy6i0OTTsBoK=UCeSkTJhw@mail.gmail.com>
 <20170804155822.kr3bzd2amnxzqk76@ltop.local>
 <CANeU7Q=WRs47kXndEj6bPTJFUoVH211pAKwv3aV0Sx87oxZasA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36888 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdHDTMX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 15:12:23 -0400
Received: by mail-wm0-f42.google.com with SMTP id t201so26913736wmt.0
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 12:12:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=WRs47kXndEj6bPTJFUoVH211pAKwv3aV0Sx87oxZasA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 04, 2017 at 02:19:54PM -0400, Christopher Li wrote:
> First thing first, I don't have strong reason to object this patch.
> So it can be merge into RC5.

OK, good.
 
> > I would be fine with this patch (but it would need a bit more testing).
> > I would be fine with no patch at all.
> > I would be ok with your patch (the one with list duplication) but I
> > think it's not a good one, even as a temporary bandaid (for the reasons
> > I explained the first time I commented on it).
> 
> Fair enough. Yes. I can apply it. The question is, do you want to remove
> the duplicate set of API? (by testing "list->rm").

Sure but I think I will even not test anything at all.
For the others lists we don't touch to the ->rm field and
we have the guarantee that it will be initialized to zero
so adding nr or adding (nr - rm) will be the same anyway
(and doing the substraction certainly won't cost more than
adding a test).

-- Luc
