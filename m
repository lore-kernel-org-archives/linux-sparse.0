From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Question about Sparse parsing - return statement
Date: Tue, 22 Aug 2017 00:53:49 +0100
Message-ID: <CACXZuxdYnwd30wiuVUd5arfPFqjsgWXTh+3RRMUhh8qkm0X1hQ@mail.gmail.com>
References: <CACXZuxc36un9_MM6T=iujCSoYuOVxtf=ZmtszVgmcHqj37DB+Q@mail.gmail.com>
 <CA+55aFzWEvVX-=Y0228qsZdVsFocs_dYT=Ds=i+x2RQ-yzGzTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:37993 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754326AbdHUXxu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 19:53:50 -0400
Received: by mail-vk0-f51.google.com with SMTP id l132so8454906vke.5
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 16:53:50 -0700 (PDT)
In-Reply-To: <CA+55aFzWEvVX-=Y0228qsZdVsFocs_dYT=Ds=i+x2RQ-yzGzTg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Linus,

On 22 August 2017 at 00:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Aug 21, 2017 at 2:53 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> I notice that the return statement has a symbol associated with - the
>> ret_target. What is the meaning of this symbol?
>
> Sparse uses symbols for branch targets too.
>
> There's several special target symbols - the return target, the
> break/continue targets for loops and switch statements etc.
>
> For example, a regular label (ie a target of a "goto") is a symbol
> with the identifier being the label.  Amd the return point is
> basically just another label that has the identifier "return".
>
> So a "return statement" is basically the same as "goto return-label"
> (plus the expression handling if there is one, of course).
>

Okay thanks.

> Note that there can be *many* such return points as a function is
> generated, since each inlined function will have its return point
> pointing to the place in the calling function where it will return.
> The same way each 'switch' statement will have its "break" label, and
> each "for/.while/do" loop will have it's own "continue" and "break"
> labels.
>
> Note how each label is always described by a symbol, and how you can
> look up what "break" means (regardless of whether you're in a switch
> or a loop context) by just looking up the "break" label in the
> NS_ITERATOR namespace.
>
> In fact, it should be noted that the code to handle "break" and
> "continue" is *EXACTLY*THE*SAME*. That should blow your mind. They
> both use exactly the same logic, and they just do exactly the same
> thing: look up the symbol associated with that ident, and "goto" it.
>

Cool. I haven't got around to breaks and continues yet.

> (I may be off in some of the details, it's way too long since I looked
> at this code).
>
> The return symbol is also the exit point of a compound statement, so
> there's a lot of just commonalities here: any branch target always is
> a symbol that is associated with the basic block that is the target.
>

Okay makes sense.

Regards
Dibyendu
