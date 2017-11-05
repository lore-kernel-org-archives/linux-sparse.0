From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 29/36] build: use git-clean
Date: Sun, 5 Nov 2017 21:58:49 +0100
Message-ID: <20171105205846.pt2dloi3dwxrccgi@ltop.local>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-29-luc.vanoostenryck@gmail.com>
 <20171105174100.r3y4o4m2i47d25o5@s>
 <20171105201629.qwitgngzeb7jzr6n@ltop.local>
 <20171105203845.inkp5mcrm634lmov@s>
 <00d1e1c1-c35b-85e6-0a91-c3302e14dd14@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:55799 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdKEU6v (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 15:58:51 -0500
Received: by mail-wm0-f42.google.com with SMTP id y83so10468360wmc.4
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 12:58:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <00d1e1c1-c35b-85e6-0a91-c3302e14dd14@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Sun, Nov 05, 2017 at 09:50:17PM +0100, Uwe Kleine-König wrote:
> On 11/05/2017 09:38 PM, Josh Triplett wrote:
> > On Sun, Nov 05, 2017 at 09:16:31PM +0100, Luc Van Oostenryck wrote:
> >> The real question would be: "is there anybody, doing some kind of
> >> development on sparse and who won't use git?"
> > 
> > Sure: anyone doing packaging. If someone wants to package Sparse for a
> > distribution, they'll likely do so in a way that does not include .git
> > in the source package. And if that package wants to "make clean" for any
> > reason, or if someone grabs the source from that distribution for
> > development and happens to run "make clean", that would be *bad*.
> 
> Ack with my sparse Debian package maintainer hat on. If you check the
> Debian build logs (e.g.
> https://buildd.debian.org/status/fetch.php?pkg=sparse&arch=arm64&ver=0.5.1-2&stamp=1506419417&raw=0)
> you can see that the first relevant step after extracting the source tar
> and applying patches is to run make clean.

OK, then it's definitively not an option.

Thanks to both of you.

-- Luc
