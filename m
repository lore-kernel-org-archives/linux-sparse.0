From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Cast to double being removed
Date: Fri, 17 Mar 2017 10:38:14 +0000
Message-ID: <CACXZuxd_YRpyfTmubOczp7J8xgaXsW89H4TOk7OqhUJ6nU0cmw@mail.gmail.com>
References: <CACXZuxdNCM5wWvnYhvt65WaX6hSR_fTnaqd7=pv8O81NWoYQ_w@mail.gmail.com>
 <CA+55aFxCqUY5k7=rmmfzW+=44+csM71bxcqqGJgLXqsg5C6F4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:35706 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdCQKpS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Mar 2017 06:45:18 -0400
Received: by mail-it0-f42.google.com with SMTP id m27so18342007iti.0
        for <linux-sparse@vger.kernel.org>; Fri, 17 Mar 2017 03:44:29 -0700 (PDT)
In-Reply-To: <CA+55aFxCqUY5k7=rmmfzW+=44+csM71bxcqqGJgLXqsg5C6F4Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Linus,

On 17 March 2017 at 00:24, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Thu, Mar 16, 2017 at 5:00 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> The cast to double has been removed. I am trying to understand where
>> this is happening as it seems to happen quite early on. Any tips on
>> where I should look?
>
> Since sparse was mostly done for kernel stuff, there's almost no
> floating point support anywhere.
>

So far the tests with floating points I have been running appear to
work after some fixes to sparse-llvm. This is the first one that seems
to be an upstream issue. I have found a floating point paranoia test
in the lcc compiler test suite - hopefully once I adapt this to run
with sparse-llvm it will help tease out any other bugs.

> There's something seriously screwed up with explicit double casting.
> See the differences between
>
>   double f1(void) { return -1; }
>   double f2(void) { return (double)-1; }
>   double f3(void) { return -1.0; }
>
> and notice how the first one and third ones actually kind-of make
> sense. The second one? Not so much, it just uses a 64-bit integer.
>
> The bug is already at the parse tree stage, the linearization doesn't
> even see the cast.
>
> I think it's this, in simplify_cast():
>
>         /* A cast of a constant? */
>         if (constant(src)) {
>                 int sign = orig_type->ctype.modifiers & MOD_SIGNED;
>                 long long val = get_cast_value(src->value, orig_size,
> size, sign);
>                 src = value_pseudo(val);
>                 goto simplify;
>         }
>
> which doesn't even check whether it's a FP value, it just looks if
> it's a constant and assumes it's an integer. At least it checks the
> sign ;)
>

Thank you for pointing me to the location where the issue might be.

Regards
Dibyendu
