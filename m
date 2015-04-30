From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sparse/parse.c: ignore hotpatch attribute
Date: Thu, 30 Apr 2015 10:51:42 -0700
Message-ID: <CA+55aFxCTx32CPkHCJM1NNv67vKHo-6yuTiLOg2Ya-=pn=O36g@mail.gmail.com>
References: <1430218119-58354-1-git-send-email-heiko.carstens@de.ibm.com>
	<CA+55aFzZtGyz3CLF5Hjyjr0GVkx3SYui8yE9JjO5tzzHZzk78g@mail.gmail.com>
	<20150430173823.GA9379@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38792 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbbD3Rvm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 30 Apr 2015 13:51:42 -0400
Received: by igbhj9 with SMTP id hj9so20476446igb.1
        for <linux-sparse@vger.kernel.org>; Thu, 30 Apr 2015 10:51:42 -0700 (PDT)
In-Reply-To: <20150430173823.GA9379@cloud>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Apr 30, 2015 at 10:38 AM,  <josh@joshtriplett.org> wrote:
>
> I think part of the problem arises because sparse claims (via the
> preprocessor symbols we provide) to be whatever version of GCC it was
> compiled with.  I think that's a mistake.  We should pick a version of
> GCC for which we support all the attributes we actually need to do
> something with, and advertise ourselves specifically as that version.

Fair enough. Although there may then be headers that are unhappy.

> I suspect that 3.2 is probably the version sparse should claim to be,
> for now.

That may be too old. You can't reliably compile the kernel with gcc
that old (some config options will complain).

At least CONFIG_GCOV_KERNEL wants 3.4 minimum.

                       Linus
