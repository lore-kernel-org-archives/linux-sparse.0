From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Question about Sparse parsing - return statement
Date: Mon, 21 Aug 2017 16:40:48 -0700
Message-ID: <CA+55aFzWEvVX-=Y0228qsZdVsFocs_dYT=Ds=i+x2RQ-yzGzTg@mail.gmail.com>
References: <CACXZuxc36un9_MM6T=iujCSoYuOVxtf=ZmtszVgmcHqj37DB+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35006 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753979AbdHUXku (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 19:40:50 -0400
Received: by mail-oi0-f41.google.com with SMTP id r200so34401232oie.2
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 16:40:49 -0700 (PDT)
In-Reply-To: <CACXZuxc36un9_MM6T=iujCSoYuOVxtf=ZmtszVgmcHqj37DB+Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 21, 2017 at 2:53 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I notice that the return statement has a symbol associated with - the
> ret_target. What is the meaning of this symbol?

Sparse uses symbols for branch targets too.

There's several special target symbols - the return target, the
break/continue targets for loops and switch statements etc.

For example, a regular label (ie a target of a "goto") is a symbol
with the identifier being the label.  Amd the return point is
basically just another label that has the identifier "return".

So a "return statement" is basically the same as "goto return-label"
(plus the expression handling if there is one, of course).

Note that there can be *many* such return points as a function is
generated, since each inlined function will have its return point
pointing to the place in the calling function where it will return.
The same way each 'switch' statement will have its "break" label, and
each "for/.while/do" loop will have it's own "continue" and "break"
labels.

Note how each label is always described by a symbol, and how you can
look up what "break" means (regardless of whether you're in a switch
or a loop context) by just looking up the "break" label in the
NS_ITERATOR namespace.

In fact, it should be noted that the code to handle "break" and
"continue" is *EXACTLY*THE*SAME*. That should blow your mind. They
both use exactly the same logic, and they just do exactly the same
thing: look up the symbol associated with that ident, and "goto" it.

(I may be off in some of the details, it's way too long since I looked
at this code).

The return symbol is also the exit point of a compound statement, so
there's a lot of just commonalities here: any branch target always is
a symbol that is associated with the basic block that is the target.

         Linus
