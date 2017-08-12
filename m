From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: RFC: Move Sparse development to github
Date: Sat, 12 Aug 2017 17:11:48 +0200
Message-ID: <CAExDi1SZx318TGj_YT_ThMzz1+0hm1TR_9JMRAxkUjtZLfKmFQ@mail.gmail.com>
References: <CACXZuxfUbrV5P0aoTfOvfaX3RDW=Nc2-BPfXj1DLENznt_TE4Q@mail.gmail.com>
 <20170811001145.mylydsr2xfbd3pnq@ltop.local> <CACXZuxfH9gZQheY9xE4C4rsotGAn7K3OSowxW+OWzpiFtkp5Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34383 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbdHLPLu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 11:11:50 -0400
Received: by mail-oi0-f48.google.com with SMTP id x3so55214503oia.1
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 08:11:49 -0700 (PDT)
In-Reply-To: <CACXZuxfH9gZQheY9xE4C4rsotGAn7K3OSowxW+OWzpiFtkp5Zg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 12, 2017 at 4:04 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Luc,
>
> I get the feeling that this is a non-starter for people here, so I
> won't be continuing the discussion anymore. But my responses to your
> points are below.

I'm certainly interested to understand what are the problems for others
and try to improve things when possible.

>> On the other hand:
>>
>> * I don't see any problem having a kind of official mirror on github
>
> That is not very useful in my view.

I agree. But it would already give a more visibility than now.

>> * I'm very fine to take patches via pulls on github but:
>>   - see the certificate of origin heer above
>>   - discussions still need to be done via email
>>
>> * I understand that sending patches via email can, for some, be
>>   and awkward process
>>   I would be fine for those people to forward pacthes to the ML
>>   so that the patches can be discussed about in the usual way.
>>   But I would not write for them something like the cover letter
>>   and such. I would only be able to do this if the volume is low.
>>
>> * Same for bug reports and suggestions
>
> I don't really see the benefit of that as you will be substituting one
> git repository with another. In my view the advantages of github are
> that it brings together other features in one easy to use package and
> the features work well together.

Yes, it's not much beneficial, I agree.

>>> 4. My suggestion would that for enhancements a simple majority voting
>>> should be adopted to ensure that features go in because Sparse users
>>> want them.
>>
>> Also, for technical matters, I don't believe in votes. Only he technical
>> merrits should count.
>
> Fine, but I think voting is a good way to prioritize things.

Maybe, and sorry if this seems like an easy canned response but
the development is done by volunteers, on their free time, like I suppose
you do for your dmr_C project. It's one thing to say "oh yes, I also think
this is a good idea/something that we need badly", it's another one
to have a list of prioritized features. How binding would this list be?

Even, having a list of bugs doesn't help much to solve these bugs,
prioritized or not.

> Well I was mainly thinking that testing repository could be opened up
> to more people and allow direct commit access to people interested in
> adding tests.

I think that simply saying on the mailing list something like:
"hey look at this piece of code I have a problem with. I think
that this or that is wrong" would already be a good thing,
like you already did.


I'm sorry if all this seems to go against what you're proposing.
I'm very sure though that we have the same goal in mind:
improve sparse and make good use of it.

-- Luc
