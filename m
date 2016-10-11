From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Development version of sparse?
Date: Tue, 11 Oct 2016 20:38:57 +0200
Message-ID: <20161011183856.GA2403@macpro.local>
References: <20161011172101.GA126173@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34833 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbcJKSjD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Oct 2016 14:39:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id 123so127939wmb.2
        for <linux-sparse@vger.kernel.org>; Tue, 11 Oct 2016 11:39:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161011172101.GA126173@google.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: linux-sparse@vger.kernel.org, sparse@chrisli.org

On Tue, Oct 11, 2016 at 10:21:01AM -0700, Eric Biggers wrote:
> Hi,
> 
> I found that the "official" sparse repository,
> git://git.kernel.org/pub/scm/devel/sparse/sparse.git, only contains patches up
> to January 2015.
> 
> There is another repository, which was more difficult to find, which contains
> some more recent patches, but only up to January 2016:
> http://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git
> 
> There have been a number of useful patches posted to the mailing list since then
> which don't appear in either repository, such as fixing the prototype for
> __builtin_object_size().
> 
> Which one, if either, is currently the "official" repository for sparse?  Is
> Chris L. still the maintainer?
> 
> And if the official repository has changed, can we get some of the links
> updated?  For example the one on
> https://sparse.wiki.kernel.org/index.php/Main_Page.
> 
> Thanks,
> 
> Eric
> --

Hi,

Yes, the official repository is indeed:
	 git://git.kernel.org/pub/scm/devel/sparse/sparse.git

I consider the other one as Chris' staging/pending tree and indeed
it contains some commits which have never been pushed to the official tree.
And since August 2015, there have been a now a bunch of patches posted on
the mailing list which haven't received any actions or comments from the
maintainer.

Yes, Chris Li is still the maintainer.


Luc Van Oostenryck
