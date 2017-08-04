From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] mark pseudo user as deleted instead of removing them
Date: Fri, 4 Aug 2017 14:33:50 -0400
Message-ID: <CANeU7Q=D6TJ-9a2cHEsoVZzdidJMecVvUdjUHQyu91ytfr9F7A@mail.gmail.com>
References: <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
 <20170804002230.5047-1-luc.vanoostenryck@gmail.com> <CANeU7Q=eNTqHRS__DPFnoOMH7vnUJHRh+3wCcFR-EF_SB7zmSA@mail.gmail.com>
 <CANeU7Q=Lsy+_5qBVGGBhK9ux5pJDVy6i0OTTsBoK=UCeSkTJhw@mail.gmail.com> <CA+55aFw+C1X2AZTA+m3ve8jxO4C6LAmciGN=DfLf4VZnkaGq4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36730 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbdHDSdv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 14:33:51 -0400
Received: by mail-pf0-f169.google.com with SMTP id c28so10177054pfe.3
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 11:33:51 -0700 (PDT)
In-Reply-To: <CA+55aFw+C1X2AZTA+m3ve8jxO4C6LAmciGN=DfLf4VZnkaGq4w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Fri, Aug 4, 2017 at 12:54 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think what might be a good idea is to simply replace the "nr" in
> "ptr_list" with a bitmap of entries instead.

That is one interesting idea.

>
> We already limit each ptr_list[] to 29 entries, so making it an
> "unsigned int" bitmap instead wouldn't be hard. So it would be just a
> single-bit "tag" whether an entry is present or not.

Sure. I think Luc has a patch to make it 13 entries now.

>
> And that allows easy deletion, easy insertion and easy to iterate over too.

I have to think about the insert and ptrlist node split more.

>
> The insertion is admittedly a *bit* awkward, since you have to find a
> free bit, but it's either a fairly simple loop or on newer CPU's you
> can use the "find first bit" instruction.

So for the nested loop insert case, the parent loop iterator will keep
track of __nth_valid_ptr as the slot indicator instead of __nr. If the insert
happen before the __nth_valid_ptr, That still doesn't work, because
the list->list[] will still get shifted.

If the insert only happen after __nth_valid_ptr, that might be
able to work.

For node spiting, We just need to carry over the __nth_valid_ptr to
the next splinted node, still not work if the insert position is
before the carry
over part of the __nth_valid_ptr.

Again I need to think about it more.

Or do you see a way to make insert into any slot position work with
parent holding pointer to the slot number?

Yes, the bit mask seems better than the mark ptr entry as NULL or tag it.

Chris
