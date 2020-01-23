From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: PATCH: domtree_build() creates extraneous bb->doms entries
Date: Thu, 23 Jan 2020 20:27:26 +0100
Message-ID: <20200123192726.hiownrizgbkwpekk@ltop.local>
References: <CAO6moYtTsA8niRvL135+OMXDjAEnGEGMf8kG+CYgq+YDKPi4UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47103 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgAWT1b (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 23 Jan 2020 14:27:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so4379424wrl.13
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jan 2020 11:27:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAO6moYtTsA8niRvL135+OMXDjAEnGEGMf8kG+CYgq+YDKPi4UQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xan Phung <xan.phung@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Jan 23, 2020 at 04:27:41PM +0800, Xan Phung wrote:
> Hi, I use Sparse's domtree_build() as the basis of my C implementation of
> the "Relooper" algorithm. I notice domtree_build appears to have a "memory
> leak" (this is an oversimplification of the problem, but not far off the
> truth).
> 
> Specifically, each time domtree_build gets called, extraneous/duplicated
> child nodes get left in the bb->doms ptrlist.  This is because the existing
> children are not cleared from bb->doms ptr list before rebuilding it.  (If
> you want to reproduce this problem, I can supply a demo of it comprising a
> test input source file and a modified test-linearized.c, which calls
> domtree_build repeatedly and reports the memory allocation stats).
> 
> In addition to consuming memory, the extraneous child nodes cause problems
> with my Relooper algorithm (as it results in a malformed dominance tree
> when walking down bb->doms).

Yes, indeed. The leak is one thing but the correctness is another one.

> The following 3 line patch fixes this problem:

Yes, that should do it. Thank you.

For me to take your patch would you mind to add your Signed-off-by,
certifying that you wrote the patch? Details can be found, for example,
at https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

-- Luc
