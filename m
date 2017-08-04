From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] mark pseudo user as deleted instead of removing them
Date: Fri, 4 Aug 2017 15:24:47 -0400
Message-ID: <CANeU7QkRWygQB_dsD4o4omB-G_xtZZVLZP4-DgaK3iDMd=HB4w@mail.gmail.com>
References: <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
 <20170804002230.5047-1-luc.vanoostenryck@gmail.com> <CANeU7Q=eNTqHRS__DPFnoOMH7vnUJHRh+3wCcFR-EF_SB7zmSA@mail.gmail.com>
 <CANeU7Q=Lsy+_5qBVGGBhK9ux5pJDVy6i0OTTsBoK=UCeSkTJhw@mail.gmail.com>
 <20170804155822.kr3bzd2amnxzqk76@ltop.local> <CANeU7Q=WRs47kXndEj6bPTJFUoVH211pAKwv3aV0Sx87oxZasA@mail.gmail.com>
 <20170804191216.x35bhjg6uskvzzu3@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36009 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdHDTYs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 15:24:48 -0400
Received: by mail-pg0-f44.google.com with SMTP id v77so11453774pgb.3
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 12:24:48 -0700 (PDT)
In-Reply-To: <20170804191216.x35bhjg6uskvzzu3@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 4, 2017 at 3:12 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> Fair enough. Yes. I can apply it. The question is, do you want to remove
>> the duplicate set of API? (by testing "list->rm").
>
> Sure but I think I will even not test anything at all.
> For the others lists we don't touch to the ->rm field and
> we have the guarantee that it will be initialized to zero
> so adding nr or adding (nr - rm) will be the same anyway
> (and doing the substraction certainly won't cost more than
> adding a test).

Yes, exactly. Testing was the mental model. Implementation
can be optimized away. :-)

Wait for your new patch then.

Chris
