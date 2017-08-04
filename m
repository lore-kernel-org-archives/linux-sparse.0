From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 1/2] take comma expr in account for constant value
Date: Fri, 4 Aug 2017 23:20:35 +0200
Message-ID: <CAExDi1SehOyNXN7uQEgwfrc4z27r4gzxx1DhpDpF-aurBs4eUg@mail.gmail.com>
References: <20170804160622.18260-1-luc.vanoostenryck@gmail.com>
 <20170804160622.18260-2-luc.vanoostenryck@gmail.com> <CANeU7QmakT6Q-7oYaG735cUOFt+L4C2JQ_eYHnfho+q5BLBmiQ@mail.gmail.com>
 <CAExDi1ST=xX=OS8FvbscHKMp3pyA728T=38yPVo4VuvSyxh8TA@mail.gmail.com> <CANeU7Q=_XWZDuUrZdkToUAw_Lm82UdtLXV+thEVnNK4Z+uWJtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38657 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752313AbdHDVUg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 17:20:36 -0400
Received: by mail-qk0-f195.google.com with SMTP id m84so2700480qki.5
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 14:20:36 -0700 (PDT)
In-Reply-To: <CANeU7Q=_XWZDuUrZdkToUAw_Lm82UdtLXV+thEVnNK4Z+uWJtA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 4, 2017 at 11:05 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Aug 4, 2017 at 4:27 PM, Luc Van Oostenryck wrote:
> <luc.vanoostenryck@gmail.com> wrote:
>> I really prefer to keep independent things separated (for a lot of reasons)
>> but if it is a problme for you feel free to squash both together I don't mind
>> (and have no others series which would depend on this one).
>
> As I said, it is a minor one. I also realize it is some what personal
> preference.
> It will not impact how the patch get merged or not.

OK.

>>
>>> The test case on the other hand can justify to become a standalone patch.
>>> Some time we want see the how the code change (with or without patches)
>>> impact the test case.
>>
>> Well ... if you had the test case before the fix you break
>> bissectability and adding it after is pointless ...
>
> Before was the model for a while when Josh was the maintainer.
> I did not push separate test patch any more.
>
>> We could add it before and tagging it as known-to-fail
>> and remove the tag when adding the fix but ...
>
> May be not justifiable.
>
>>
>>> Another minor commend is that, if it is not for RC5.
>>
>> Well, it's up to you to decide if it is for -rc5 or not.
>
> I will listen to your recommendation as the base line.
>
> If it compress 20 seconds to 2 seconds. I vote for include it.

If only it would do so for every input code ;)

> But really that is your call too. I am fine either way.
>
>> Personally, I wouldn't take such a patch for such problem in -rc5
>> (but this decision would also depend on the frequency of releases,
>> for example). On one hand, the change seems quite limited and
>> 'obviously correct' (famous last words), on the other hand, every
>> changes, even the smallest need to retest things and delay this
>> release a bit more.
>
> After the RC5 release, we should have some good test on it any way.
> Chance of this patch breaking new things is relative low.

It can only impact code that is in fact erroneous.

>> Well, it's also because I would need to think a bit more about the API
>> look after the different uses regarding the warning flag and such.
>> I'm not even convinced that we must in general take in account
>> comma expressions like done here for this specific case.
>> All things that would need a bit more thinking and time.
>
> Yes, your call :-)

OK, considering also that the situation may be present in other
code (at various degree) and that this non-expansion of the
builtin is really bad I'm fine to include it.

Strangely I have a series of 5 or 6 patches fixing some similar situations
(where some code is not evaluated and/or expanded, often creating
duplicated warnings) but not this precise case.
I never posted them because I considered it was too late in the release ...

-- Luc
