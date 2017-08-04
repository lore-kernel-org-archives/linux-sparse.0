From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 1/2] take comma expr in account for constant value
Date: Fri, 4 Aug 2017 22:27:51 +0200
Message-ID: <CAExDi1ST=xX=OS8FvbscHKMp3pyA728T=38yPVo4VuvSyxh8TA@mail.gmail.com>
References: <20170804160622.18260-1-luc.vanoostenryck@gmail.com>
 <20170804160622.18260-2-luc.vanoostenryck@gmail.com> <CANeU7QmakT6Q-7oYaG735cUOFt+L4C2JQ_eYHnfho+q5BLBmiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34547 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdHDU1x (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 16:27:53 -0400
Received: by mail-qt0-f169.google.com with SMTP id s6so15487468qtc.1
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 13:27:52 -0700 (PDT)
In-Reply-To: <CANeU7QmakT6Q-7oYaG735cUOFt+L4C2JQ_eYHnfho+q5BLBmiQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 4, 2017 at 9:49 PM, Christopher Li <sparse@chrisli.org> wrote:
> Looks fine to me.
>
> One of the very minor note is that. I think this patch can actually merge with
> the next one. It is easier to read patch have both the define and usage.
> I found myself need to switch between patches to read how it was used.

I really prefer to keep independent things separated (for a lot of reasons)
but if it is a problme for you feel free to squash both together I don't mind
(and have no others series which would depend on this one).

> The test case on the other hand can justify to become a standalone patch.
> Some time we want see the how the code change (with or without patches)
> impact the test case.

Well ... if you had the test case before the fix you break
bissectability and adding it after is pointless ...
We could add it before and tagging it as known-to-fail
and remove the tag when adding the fix but ...

> Another minor commend is that, if it is not for RC5.

Well, it's up to you to decide if it is for -rc5 or not.
Personally, I wouldn't take such a patch for such problem in -rc5
(but this decision would also depend on the frequency of releases,
for example). On one hand, the change seems quite limited and
'obviously correct' (famous last words), on the other hand, every
changes, even the smallest need to retest things and delay this
release a bit more.

> You actually don't need to worry about code impact range
> any more. You might just as well do the full change into the constant
> expression value evaluation.

Well, it's also because I would need to think a bit more about the API
look after the different uses regarding the warning flag and such.
I'm not even convinced that we must in general take in account
comma expressions like done here for this specific case.
All things that would need a bit more thinking and time.

-- Luc
