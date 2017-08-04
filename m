From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] mark pseudo user as deleted instead of removing them
Date: Fri, 4 Aug 2017 16:08:50 -0400
Message-ID: <CANeU7Q=u0BFdcct6sbSyhiaiC2M-Wbe8wWznPJr_z_ZQQSZ-3A@mail.gmail.com>
References: <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
 <20170804002230.5047-1-luc.vanoostenryck@gmail.com> <CANeU7Q=eNTqHRS__DPFnoOMH7vnUJHRh+3wCcFR-EF_SB7zmSA@mail.gmail.com>
 <CANeU7Q=Lsy+_5qBVGGBhK9ux5pJDVy6i0OTTsBoK=UCeSkTJhw@mail.gmail.com>
 <CA+55aFw+C1X2AZTA+m3ve8jxO4C6LAmciGN=DfLf4VZnkaGq4w@mail.gmail.com> <CANeU7Q=D6TJ-9a2cHEsoVZzdidJMecVvUdjUHQyu91ytfr9F7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35235 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdHDUIw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 16:08:52 -0400
Received: by mail-pg0-f50.google.com with SMTP id v189so11823514pgd.2
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 13:08:51 -0700 (PDT)
In-Reply-To: <CANeU7Q=D6TJ-9a2cHEsoVZzdidJMecVvUdjUHQyu91ytfr9F7A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Fri, Aug 4, 2017 at 2:33 PM, Christopher Li <sparse@chrisli.org> wrote:
> So for the nested loop insert case, the parent loop iterator will keep
> track of __nth_valid_ptr as the slot indicator instead of __nr. If the insert
> happen before the __nth_valid_ptr, That still doesn't work, because
> the list->list[] will still get shifted.
>
> If the insert only happen after __nth_valid_ptr, that might be
> able to work.
>
> For node spiting, We just need to carry over the __nth_valid_ptr to
> the next splinted node, still not work if the insert position is
> before the carry
> over part of the __nth_valid_ptr.
>
> Again I need to think about it more.
>
> Or do you see a way to make insert into any slot position work with
> parent holding pointer to the slot number?

OK. I might have a way to make it work for insert case.
Let me lay it out here.

Has two bit mask, one for deleted entry. one for inserted entry, let's
call it insert slot mask.

The deleted entry is what Linus suggested. The inserted slot mask is marking
which entry is new element insert into the list->list[]. When the list->list[]
was shifted to make room for new ptr entry, the insert slot mask will need
to be shift accordingly was well. (so does the delete slot mask).

I was original thinking only track element insert in the middle of list->list[].
But then I realize for the reverse ptr loop case I need to track insert
from the tail as well.

Then the parent loop iterator will keep a copy of the insert mask and
__nth_slot_ptr before execute the loop body.

The inner loop might update the ptrlist and the insert
slot mask.

The parent can compare the cached version of the insert slot mask
and the current list insert slot mask to find out which slot are inserted
during the execution of the loop body. Then the parent can adjust
__nth_slot_ptr accordingly.

It is complicated, but it seems possible to make correct loop iterator
when the inner loop modify insert element to the list. It is the first idea
I have that does not involve with a link list of the previous modify log.

I obvious need to think about it more. For now, I do think this can
produce the correct behavior. The space cost of extra 32 bit slot is not
too bad either.

Chris
