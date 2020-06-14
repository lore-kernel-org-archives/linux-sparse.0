From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [ANNOUNCE] Sparse v0.6.2-rc1
Date: Sun, 14 Jun 2020 23:54:45 +0200
Message-ID: <20200614215445.rtfbx23ve57fhlbr@ltop.local>
References: <20200613020735.iqb2vd23jpomisbq@ltop.local>
 <c80024d2-6d91-4fe7-a919-3edcf4a9b80a@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgFNVyt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 14 Jun 2020 17:54:49 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B7EC05BD43
        for <linux-sparse@vger.kernel.org>; Sun, 14 Jun 2020 14:54:49 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so15337400ejd.8
        for <linux-sparse@vger.kernel.org>; Sun, 14 Jun 2020 14:54:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <c80024d2-6d91-4fe7-a919-3edcf4a9b80a@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org

On Sun, Jun 14, 2020 at 08:35:51PM +0100, Ramsay Jones wrote:
> 
> 
> On 13/06/2020 03:07, Luc Van Oostenryck wrote:
> > Sparse v0.6.2-rc1 is now out.
> 
> Tested in the usual places (Linux Mint 19.3, 64-bit and 32-bit and
> 64-bit cygwin) and in the usual way; no issues found!

Thanks a lot. Here I tested it on 64-bit Debian (latest + unstable)
and Ubuntu, and also on ARM64, ARM(32), ppc64, sparc64, mips64.
I'll give a try later to some BSD.

> Well, I say no issues - I did notice some spelling errors and
> the formatting of the release notes does not look correct to
> me (https://sparse.docs.kernel.org/en/latest/release-notes/v0.6.2.html).
> Unfortunately, I don't know anything about the documentation tools
> you are using, so I can't try to fix this. (It seems to be the only
> attempt at nested 'bulleted lists', ...)

Yes, I saw that too now. I thought I had fixed it but visibly it
wasn't. It should be really fixed now.

[(Just FYI) The format of the doc is either reStructuredText
(.rst) or MarkDown (.md). Both are much less simple than they
appear to be but they have the huge advantage to almost look
as if there is no markup at all/as if written 'naturally' in
ASCII. Much much more readable than man-pages or html markup.

The system used to generate the resulting HTML is Sphinx.
It has the huge advantage to be very easy to install/to have
near-zero dependencies: it's just a single python package.
To use it, it's enough to just 'cd Documentation; make html'
and the result can be found in 'build/html'. But I confess,
most of the time, I'm too lazy to do that, I just push it
on github which trigger a build on readthedocs.io (which
then nicely send me an email if there is an error).]

-- Luc
