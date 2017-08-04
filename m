From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mark pseudo user as deleted instead of removing them
Date: Fri, 4 Aug 2017 09:54:13 -0700
Message-ID: <CA+55aFw+C1X2AZTA+m3ve8jxO4C6LAmciGN=DfLf4VZnkaGq4w@mail.gmail.com>
References: <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
 <20170804002230.5047-1-luc.vanoostenryck@gmail.com> <CANeU7Q=eNTqHRS__DPFnoOMH7vnUJHRh+3wCcFR-EF_SB7zmSA@mail.gmail.com>
 <CANeU7Q=Lsy+_5qBVGGBhK9ux5pJDVy6i0OTTsBoK=UCeSkTJhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35511 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbdHDQyO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 12:54:14 -0400
Received: by mail-oi0-f48.google.com with SMTP id e124so20196689oig.2
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 09:54:14 -0700 (PDT)
In-Reply-To: <CANeU7Q=Lsy+_5qBVGGBhK9ux5pJDVy6i0OTTsBoK=UCeSkTJhw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Fri, Aug 4, 2017 at 8:29 AM, Christopher Li <sparse@chrisli.org> wrote:
>
> There is a few design choice here. We can make ptr==NULL for the condition
> of ptr is marked deleted. We can also use tags to do the marking. Using tags
> will allow NULL pointer as valid entry in the ptrlist.

I think what might be a good idea is to simply replace the "nr" in
"ptr_list" with a bitmap of entries instead.

We already limit each ptr_list[] to 29 entries, so making it an
"unsigned int" bitmap instead wouldn't be hard. So it would be just a
single-bit "tag" whether an entry is present or not.

And that allows easy deletion, easy insertion and easy to iterate over too.

The insertion is admittedly a *bit* awkward, since you have to find a
free bit, but it's either a fairly simple loop or on newer CPU's you
can use the "find first bit" instruction.

                Linus
