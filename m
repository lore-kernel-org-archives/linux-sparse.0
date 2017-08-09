From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 2/9] Remove single-store shortcut
Date: Thu, 10 Aug 2017 01:51:54 +0200
Message-ID: <CAMHZB6FL65PKYr=QmLaKCF=saQ2eTSz-DQ+wfiebM0pKLFwAqQ@mail.gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com> <20170809193806.30975-3-luc.vanoostenryck@gmail.com>
 <CACXZuxejN5zBn4NN7XXmGhM26NJMiGAutW7+csb7kVPjWZRVLg@mail.gmail.com>
 <CAMHZB6FFs-SMSLr3awsHB+k1CTwwezrtbidS2bOMKJ1F2j_jng@mail.gmail.com>
 <CACXZuxc053p7yxDa_Y=tXxt+J4bLikiKjQU0us=_b27EHV1CFg@mail.gmail.com>
 <CAExDi1TU1VN19NiUZOnEj+Dis0AuqA9eNFXnZVZ86L10OkSBWw@mail.gmail.com> <CACXZuxdyWs8WJ7JKwZQRiO133UcnXe-y4ZXttqJh54A2cf87YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:35720 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752093AbdHIXvz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 19:51:55 -0400
Received: by mail-qt0-f171.google.com with SMTP id p3so45614191qtg.2
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 16:51:54 -0700 (PDT)
In-Reply-To: <CACXZuxdyWs8WJ7JKwZQRiO133UcnXe-y4ZXttqJh54A2cf87YQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Thu, Aug 10, 2017 at 1:32 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Yes I suppose that is what it is. LLVM complains that 'instruction
> does not dominate all uses'.
> The unsimplified IR works fine
> (https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/bugs/simplifybug.lin).
> The simplified IR has an issue
> (https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/bugs/simplifybug_O1.lin).

Yes, I saw now. It's hopeless.
It's a problem with the SSA construction (happen between linearization
and simplification), basically, it puts the phi-nodes where there is a load
but it's often too late, they need to be put where paths join.

>> You may try the new SSA construction at :
>>    https://github.com/lucvoo/sparse/tree/sssa
>> It will help a lot.
>>
>
> Is that a standalone change I can apply?

Arf ... in a sense yes but it's really a 40 patches series
(but most changes are isolated, maybe not too much work for you
I don't know).

> I think that this is a very good idea. Since the official sparse repo
> is so behind - it will be good if you maintain a branch in your repo
> that has all the things that you have tested thoroughly and are happy
> with - this can be the "next sparse version" for testing. I would
> suggest aggregating only changes that you are 100% confident about. It
> will allow me (and others like me) to test the changes and report back
> if any issues are found.

It's the idea.
Only that the 100% confident will be "confident that it won't break but
improve situations I know about".

Regards,
-- Luc
