From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: RFC: Move Sparse development to github
Date: Sat, 12 Aug 2017 15:04:03 +0100
Message-ID: <CACXZuxfH9gZQheY9xE4C4rsotGAn7K3OSowxW+OWzpiFtkp5Zg@mail.gmail.com>
References: <CACXZuxfUbrV5P0aoTfOvfaX3RDW=Nc2-BPfXj1DLENznt_TE4Q@mail.gmail.com>
 <20170811001145.mylydsr2xfbd3pnq@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34425 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdHLOEE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 10:04:04 -0400
Received: by mail-vk0-f65.google.com with SMTP id d124so2683915vkf.1
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 07:04:04 -0700 (PDT)
In-Reply-To: <20170811001145.mylydsr2xfbd3pnq@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

I get the feeling that this is a non-starter for people here, so I
won't be continuing the discussion anymore. But my responses to your
points are below.

On 11 August 2017 at 01:11, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Aug 10, 2017 at 11:58:30AM +0100, Dibyendu Majumdar wrote:
>> I would like to propose moving Sparse development to github. The model
>> I would like to propose is as follows:
>
> I'll want to first add a few things.
>
> * 'sparse' is a kernel.org:Linux Foundation project and I doubt it's
>   official version will be hosted elsewhere (but I may be wrong, I dunno).
>
> * We need & want to comply with the 'Developer certificate of origin',
>   the 'Signed-off-by' thing.
>

Okay I don't know if these are deal breakers or if any other Linux
project is using github.

> * Current sparse developers are subcribed to the mailing list and
>   are used to do/read discussion via email.
>
> * I'm much more efficient at writting comments, discuss, ...
>   with my $EDITOR than using any web UI. I guess than I'm far from
>   being alone.
>

Sure I understand. Github appears to support email interaction with
the issues system but I am not sure it will be as convenient as it is
today.


> On the other hand:
>
> * I don't see any problem having a kind of official mirror on github
>

That is not very useful in my view.

> * I'm very fine to take patches via pulls on github but:
>   - see the certificate of origin heer above
>   - discussions still need to be done via email
>
> * I understand that sending patches via email can, for some, be
>   and awkward process
>   I would be fine for those people to forward pacthes to the ML
>   so that the patches can be discussed about in the usual way.
>   But I would not write for them something like the cover letter
>   and such. I would only be able to do this if the volume is low.
>
> * Same for bug reports and suggestions
>

I don't really see the benefit of that as you will be substituting one
git repository with another. In my view the advantages of github are
that it brings together other features in one easy to use package and
the features work well together.

>> 4. My suggestion would that for enhancements a simple majority voting
>> should be adopted to ensure that features go in because Sparse users
>> want them.
>
> I don't see a real need for that.
> If someone has a features and wrote the patches, those patches should
> be submitted, reviewed, ... as usual and then pushed to master.
> I'm being a bit naive or optimistic here, but I think that for most
> cases the usefullness of a features is obvious and would certainly not
> need any kind of votes. If the features has some negatives aspects then
> of course, it's the usual work to balance things and make the best choice.
>
> Also, for technical matters, I don't believe in votes. Only he technical
> merrits should count.
>

Fine, but I think voting is a good way to prioritize things.

>> 5. I would also suggest separating out the testing infrastructure to
>> another repository so that more people can help with testing. I would
>> be interested in helping with the testing infrastructure as I believe
>> this will ease a lot of the pain experienced today with making
>> changes.
>
> As is, I don't see what would be the benefit, on the contrary separating
> them would be a disadvantage.
> Mind to clarify a bit more what you have in mind, it's reasons?
>

Well I was mainly thinking that testing repository could be opened up
to more people and allow direct commit access to people interested in
adding tests.

Regards
Dibyendu
