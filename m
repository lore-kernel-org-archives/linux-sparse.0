From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 3/5] add helper handle_simple_switch()
Date: Thu, 1 Jun 2017 16:30:33 +0200
Message-ID: <CAExDi1QX9r26=zYsaeLERfOPTq+kbTVeBOr3yue+LSSHZp16nA@mail.gmail.com>
References: <20170412083703.11552-1-luc.vanoostenryck@gmail.com>
 <20170412083703.11552-4-luc.vanoostenryck@gmail.com> <CANeU7Qkrmkbb6s9k2Jj_mF95g8bwdqJ5-HqabU3_NZ_ozfj1tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:34215 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFAOaf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 10:30:35 -0400
Received: by mail-qt0-f170.google.com with SMTP id c13so37518257qtc.1
        for <linux-sparse@vger.kernel.org>; Thu, 01 Jun 2017 07:30:34 -0700 (PDT)
In-Reply-To: <CANeU7Qkrmkbb6s9k2Jj_mF95g8bwdqJ5-HqabU3_NZ_ozfj1tA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jun 1, 2017 at 8:15 AM, Christopher Li <sparse@chrisli.org> wrote:
> I have some very minor comment.
>
>> +static int handle_simple_switch(const char *arg, const char *name, int *flag)
>> +{
>> +       int val = 1;
>> +
>> +       // Prefixe "no-" mean to turn flag off.
>> +       if (strncmp(arg, "no-", 3) == 0) {
>
> You don't need to compare to zero. This can be written as:
>  if (!strncmp(arg, "no-", 3)) {
>
> That is how most of the strcmp done in sparse.

I'm not sure exactly what you want me to do in this case.
Is it just a comment for things to avoid in the future or would you
like me to change it
before it is integrated?

Of course, I know that it is not needed to compare it against zero,
I do it purposely because when I use "if (!x) " it means to me something like
"x is invalid" or "x is not true" and my mental model of string
compare never match
with "is invalid" or "is not true", so I use the "if (x == 0)" idioms
to be very clear
that for strcmp() a return value of 0 means "the two strings are equal".

But I don't mind, I can change it if you prefer.
What annoys me is that this code have been posted more than 7 weeks ago,
is now part of the pull request I sent 2 weeks ago and by now I have 35 topic
branches that depend on this code and I certainly would prefer to do more
usefull things than handling these nits and rewrite all my history.

-- Luc
