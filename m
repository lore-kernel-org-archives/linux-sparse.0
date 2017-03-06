From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Possible incorrect linearization of code (master branch)
Date: Mon, 6 Mar 2017 20:26:12 +0100
Message-ID: <CAExDi1RSA0qgBEbH8DH9w573-g1DrH4DhOrUo_GDdnKVh--F-w@mail.gmail.com>
References: <CACXZuxeNopu3Syg+TCL3TLnhwmA84qkQ1NsN4hjL-VLPi6ASYA@mail.gmail.com>
 <20170306163638.huqjg6my2qhwyyzy@macpro.local> <CACXZuxd_6YS7cficTeuPayyYCT-0Q==i3hje_Xd-MtoAP6bLyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34987 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932471AbdCFT0T (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 14:26:19 -0500
Received: by mail-qk0-f177.google.com with SMTP id v125so108637666qkh.2
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 11:26:18 -0800 (PST)
In-Reply-To: <CACXZuxd_6YS7cficTeuPayyYCT-0Q==i3hje_Xd-MtoAP6bLyQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Mar 6, 2017 at 7:47 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Okay thanks. I had originally started from the release 0.5 version of
> Sparse, and applied fixes selectively.

release 0.5 is quite old and a lot of patches have been added;
almost nothing related to correctness of LLVM but well about the correctness
of the linearization.

> Because I have a modified
> version of Sparse with all global state removed, merging changes is a
> bit painful as it has be done manually.

I can imagine this.
I, of course, hve no idea why you (have to) do this but I can only very strongly
advice you to try to avoid this as much as possible.

> That is why I have not been
> tracking sparse-next as I thought it is not yet stable. I have now
> merged all changes from master. Should I merge sparse-next now or wait
> for it to be merged into master?

It depends a bit you confortable you are with applying patches,
merging or rebasing
branches but as you have seen there is needed patches in sparse-next
that are not
yes in master although master was updated very recently.

It depends also about the nature of your changes, what is the
probability to have
nasty conflicts.

But idealy you would take very recent stuff but not too recent
(sparse-next itself may be
a bit too wild in the sense that the very top of it is often rebased).

-- Luc Van Oostenryck
