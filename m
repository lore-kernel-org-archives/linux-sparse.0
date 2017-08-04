From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] mark pseudo user as deleted instead of removing them
Date: Fri, 4 Aug 2017 16:37:58 -0400
Message-ID: <CANeU7QkguR5FU23LuUGt+1DkDVT9CTXWeBpuo8PsL26WaGD+6w@mail.gmail.com>
References: <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
 <20170804002230.5047-1-luc.vanoostenryck@gmail.com> <CANeU7Q=eNTqHRS__DPFnoOMH7vnUJHRh+3wCcFR-EF_SB7zmSA@mail.gmail.com>
 <CANeU7Q=Lsy+_5qBVGGBhK9ux5pJDVy6i0OTTsBoK=UCeSkTJhw@mail.gmail.com>
 <CA+55aFw+C1X2AZTA+m3ve8jxO4C6LAmciGN=DfLf4VZnkaGq4w@mail.gmail.com>
 <CANeU7Q=D6TJ-9a2cHEsoVZzdidJMecVvUdjUHQyu91ytfr9F7A@mail.gmail.com> <CANeU7Q=u0BFdcct6sbSyhiaiC2M-Wbe8wWznPJr_z_ZQQSZ-3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:38570 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbdHDUiA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 16:38:00 -0400
Received: by mail-pg0-f43.google.com with SMTP id l64so11992195pge.5
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 13:37:59 -0700 (PDT)
In-Reply-To: <CANeU7Q=u0BFdcct6sbSyhiaiC2M-Wbe8wWznPJr_z_ZQQSZ-3A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Fri, Aug 4, 2017 at 4:08 PM, Christopher Li <sparse@chrisli.org> wrote:
> Then the parent loop iterator will keep a copy of the insert mask and
> __nth_slot_ptr before execute the loop body.

I found a small bug here. The outer most loop iterator need to
reset insert mask to zero. In other words, it need the ptrlist
refcount patch. The outer most iterator can even compact the list->list[]
and clear out delete slot mask and insert slot mask when refcount
drop to zero.

>
> The inner loop might update the ptrlist and the insert
> slot mask.

The insert only need to update insert slot mask when list->refcout != 0.
In other words, some one is looping on this list entry. Which is very rare.

I expect his have very minimal performance impact (other than the refcount
part). Most of the case there is no insert happen in this ptrlist. We can
do the fast path, need need to adjust __nth_slot_ptr. Let a non inlined
function to do the slow patch adjustment of __nth_slot_ptr base on
the two  insert slot mask(before and after).

Chris
