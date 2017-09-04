From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Simple SSA status
Date: Mon, 4 Sep 2017 22:55:43 +0200
Message-ID: <20170904205542.tb265qvphwjgr6om@ltop.local>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local>
 <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local>
 <CACXZuxd7_8EktgM6JWNA83Bf_qm5yv8sc2OJ=3LT97jthKfAdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35978 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbdIDUzr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 4 Sep 2017 16:55:47 -0400
Received: by mail-wr0-f182.google.com with SMTP id p14so2324488wrg.3
        for <linux-sparse@vger.kernel.org>; Mon, 04 Sep 2017 13:55:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxd7_8EktgM6JWNA83Bf_qm5yv8sc2OJ=3LT97jthKfAdQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Sep 04, 2017 at 09:37:17PM +0100, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> On 4 September 2017 at 21:07, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> 
> > About the phi-sources, I agree strongly with this. To me these
> > phi-sources are just a nuisance. Once things will be in better
> > shape, I'll see what can be done to get rid of them (quite a bit
> > of the logic depends on them for the moment, though).
> >
> 
> As you know the backend relies upon the phisrc instruction and treats
> it like a 'store' while treating the phi instructions as 'loads'.
> Selfishly I would like this to remain as it seems changing it is not
> necessary, but nice to have?

Well, I'm not very sure about how you use these phisrc but from what
I've understood, in sparse-llvm it's done like this because LLVM's phi
can't be used *because* of the problems described here above.
If I remove these phisources, I would of course adapt sparse-llvm
to do the right thing.

And no, removing these phisources is not a nice to have. Like
I said, they're a real nuisance and make a lots of things much
more complicated than needed.

Once the phi-nodes are correct, you can trivially recreate these
phisources if needed. But the simple fact that you can do this
trivially is a clear sign that you really don't *need* them.
Among other things you can do the alloca/store/load as easily
without them (instead of putting the store at the place of the
phisrc was, you put the store at the end of each predecessor,
which is where these phisrc should have been and where they are
now in my code).

Anyway, we're not yet at the point where it would be possible to
remove them. We're even still far from it.

-- Luc
