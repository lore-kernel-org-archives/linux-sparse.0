From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Bug relate to delete ptr list entry while parent looping on it
Date: Sun, 9 Jul 2017 12:14:10 +0200
Message-ID: <20170709101409.tdtnr7ammncqxzj2@ltop.local>
References: <CANeU7QnEnRiaLgYP-cLOgEJD1Hrc3aUMn7MrpjYJoGFjBzKUnA@mail.gmail.com>
 <20170709071845.qqjvyh75h4wxccfq@ltop.local>
 <CANeU7Q=8m=MbvXvoCfGucSEkTEzGyrd+Lr+-M3KenDCZb9s_-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35144 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbdGIKOP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 06:14:15 -0400
Received: by mail-wr0-f171.google.com with SMTP id k67so100809246wrc.2
        for <linux-sparse@vger.kernel.org>; Sun, 09 Jul 2017 03:14:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=8m=MbvXvoCfGucSEkTEzGyrd+Lr+-M3KenDCZb9s_-w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Jul 09, 2017 at 01:54:41AM -0700, Christopher Li wrote:
> On Sun, Jul 9, 2017 at 12:18 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Sat, Jul 08, 2017 at 10:54:18PM -0700, Christopher Li wrote:
> >> Hi Luc,
> >>
> >> I make some progress of the ptrlist ref count patch.
> > Have you this new version available somewhere?
> 
> Just clean it up a bit:
> 
> https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=ptrlist-refcount-clean

OK, thanks.
 
> While you where there, can you take a look at the patch before it?
> I need to have it to avoid die on the ep->bbs list.
I already looked at it Friday but I haven't yet totally made my mind
about it.
I understand quite well the need and motivation for it.
It passes my crash tests here too.

Problem is that this is exactly what I did first when I needed it 
for the insert_branch()/"crazy programmer" but but for some reasons
I had to move it directly after the insert_branch().

I'm not sure anymore about the reasons though.
I suppose it was some bad effects with CSE.

-- Luc
