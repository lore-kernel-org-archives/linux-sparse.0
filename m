From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH v4 2/9] Remove single-store shortcut
Date: Thu, 10 Aug 2017 00:32:00 +0100
Message-ID: <CACXZuxdyWs8WJ7JKwZQRiO133UcnXe-y4ZXttqJh54A2cf87YQ@mail.gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com> <20170809193806.30975-3-luc.vanoostenryck@gmail.com>
 <CACXZuxejN5zBn4NN7XXmGhM26NJMiGAutW7+csb7kVPjWZRVLg@mail.gmail.com>
 <CAMHZB6FFs-SMSLr3awsHB+k1CTwwezrtbidS2bOMKJ1F2j_jng@mail.gmail.com>
 <CACXZuxc053p7yxDa_Y=tXxt+J4bLikiKjQU0us=_b27EHV1CFg@mail.gmail.com> <CAExDi1TU1VN19NiUZOnEj+Dis0AuqA9eNFXnZVZ86L10OkSBWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:32950 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbdHIXcB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 19:32:01 -0400
Received: by mail-vk0-f49.google.com with SMTP id j189so31223273vka.0
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 16:32:01 -0700 (PDT)
In-Reply-To: <CAExDi1TU1VN19NiUZOnEj+Dis0AuqA9eNFXnZVZ86L10OkSBWw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

Hi Luc,

On 10 August 2017 at 00:15, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Aug 10, 2017 at 12:23 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> Thank you. I am trying out this change as I am hoping it will help
>> avoid the incorrect simplifications we saw in some cases. So far my
>> findings are:
>>
>
>> But it doesn't help with the issue with pseudos defined in one branch
>> of the code (https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/bugs/simplifybug.c).
>>
>> Is there another fix / patch that you made to overcome above issue or
>> would you expect both issues to be fixed by this change?
>
> I don't know exactly what you have as problem with this other test.
> I quickly looked at the output of test-linearize and I saw no problem
> with self-defined pseudos. The phi-nodes are very wrong though but that's
> another problem.
>

Yes I suppose that is what it is. LLVM complains that 'instruction
does not dominate all uses'.
The unsimplified IR works fine
(https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/bugs/simplifybug.lin).
The simplified IR has an issue
(https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/bugs/simplifybug_O1.lin).

> You may try the new SSA construction at :
>    https://github.com/lucvoo/sparse/tree/sssa
> It will help a lot.
>

Is that a standalone change I can apply?

> But in both case, I saw that sparse-llvm crashes
> (which is normal as none of the LLVM fixes are applied here).
>
> In the coming days, I'll do a branch that aggregates all the good stuff.
>

I think that this is a very good idea. Since the official sparse repo
is so behind - it will be good if you maintain a branch in your repo
that has all the things that you have tested thoroughly and are happy
with - this can be the "next sparse version" for testing. I would
suggest aggregating only changes that you are 100% confident about. It
will allow me (and others like me) to test the changes and report back
if any issues are found.

> But until then, can you explain exactly what is wrong with this second test?
>
>> I will run my test cases with this change and report if anything breaks.
>
> Thanks.
> Testing in other environments, with other goals, is very useful.
>

So far I haven't found any breaks which is good. I will continue
testing tomorrow.

Regards
Dibyendu
