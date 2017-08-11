From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: RFC: Move Sparse development to github
Date: Fri, 11 Aug 2017 02:11:46 +0200
Message-ID: <20170811001145.mylydsr2xfbd3pnq@ltop.local>
References: <CACXZuxfUbrV5P0aoTfOvfaX3RDW=Nc2-BPfXj1DLENznt_TE4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35563 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdHKALu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 20:11:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id r77so4761214wmd.2
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 17:11:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxfUbrV5P0aoTfOvfaX3RDW=Nc2-BPfXj1DLENznt_TE4Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 10, 2017 at 11:58:30AM +0100, Dibyendu Majumdar wrote:
> Hi,
> 
> I would like to propose moving Sparse development to github. The model
> I would like to propose is as follows:

I'll want to first add a few things.

* 'sparse' is a kernel.org:Linux Foundation project and I doubt it's
  official version will be hosted elsewhere (but I may be wrong, I dunno).

* We need & want to comply with the 'Developer certificate of origin',
  the 'Signed-off-by' thing.

* Current sparse developers are subcribed to the mailing list and
  are used to do/read discussion via email.

* I'm much more efficient at writting comments, discuss, ...
  with my $EDITOR than using any web UI. I guess than I'm far from
  being alone.

On the other hand:

* I don't see any problem having a kind of official mirror on github

* I'm very fine to take patches via pulls on github but:
  - see the certificate of origin heer above
  - discussions still need to be done via email

* I understand that sending patches via email can, for some, be
  and awkward process
  I would be fine for those people to forward pacthes to the ML
  so that the patches can be discussed about in the usual way.
  But I would not write for them something like the cover letter
  and such. I would only be able to do this if the volume is low.

* Same for bug reports and suggestions

> 4. My suggestion would that for enhancements a simple majority voting
> should be adopted to ensure that features go in because Sparse users
> want them.

I don't see a real need for that.
If someone has a features and wrote the patches, those patches should
be submitted, reviewed, ... as usual and then pushed to master.
I'm being a bit naive or optimistic here, but I think that for most
cases the usefullness of a features is obvious and would certainly not
need any kind of votes. If the features has some negatives aspects then
of course, it's the usual work to balance things and make the best choice.

Also, for technical matters, I don't believe in votes. Only he technical
merrits should count.

> 5. I would also suggest separating out the testing infrastructure to
> another repository so that more people can help with testing. I would
> be interested in helping with the testing infrastructure as I believe
> this will ease a lot of the pain experienced today with making
> changes.

As is, I don't see what would be the benefit, on the contrary separating
them would be a disadvantage.
Mind to clarify a bit more what you have in mind, it's reasons?

> 7. Releases ought to be time based - i.e. a release must be cut every
> three months or six months - with the current feature set.

Yes, or at least something very reasonable.
6 months seems a maximum to me.
 
I'm also very much in favor of being able to cut a release at any time
using the current master branch.

> I think this might be a controversial topic - so apologies for raising
> it but having observed the process for the past six months I do think
> change is necessary.

No problem.
And yes, the process is far from good, at several levels.

-- Luc
