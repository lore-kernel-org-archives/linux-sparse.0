From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] V2 move kill_unreachable_bbs to outer cse stage Was Re:
 [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Wed, 19 Jul 2017 22:48:57 +0200
Message-ID: <20170719204854.6jwkt6q7shnlfelu@ltop.local>
References: <CANeU7QkCcx1d29megDn9bQ0g7rw04=ujsWCe_bN1Kc1NW_-NZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33745 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755237AbdGSUtC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 16:49:02 -0400
Received: by mail-wm0-f48.google.com with SMTP id 15so2422697wmm.0
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 13:49:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QkCcx1d29megDn9bQ0g7rw04=ujsWCe_bN1Kc1NW_-NZw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

> From 484a3a27d95b4bf3be9ac4b9bcf1aca1abe3ac19 Mon Sep 17 00:00:00 2001
> From: Christopher Li <sparse@chrisli.org>
> Date: Sat, 8 Jul 2017 19:34:49 -0700
> Subject: [PATCH] move kill_unreachable_bbs to outer cse stage
> 
> The current way of kill_unreach_bbs in insert_branch()
> cause delete entry in ptrlist that the upper level
> caller is looping on.
> 
> Move it outside to the cse stage avoid that problem.
> 
> Reported-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Signed-of-By: Christopher Li <sparse@chrisli.org>
> ---
>  cse.c       | 3 +++
>  flow.c      | 2 --
>  linearize.c | 3 ---
>  3 files changed, 3 insertions(+), 5 deletions(-)

The original patch had a testcase for the regressions testsuite.
Is there a reasons why there it has been dropped here?

The original patch had a reference to the patch it fixed,
which is quite helpful to understand the exact situation.
Is there a reason why it has been dropped here?

-- Luc
