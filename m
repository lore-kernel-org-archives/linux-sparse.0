From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] V2 move kill_unreachable_bbs to outer cse stage Was Re:
 [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Wed, 19 Jul 2017 16:57:38 -0400
Message-ID: <CANeU7Qk3N2F+yOUC5SHGJ=jzWMNhgVL=EV3tbSWPZj-7JRVEHw@mail.gmail.com>
References: <CANeU7QkCcx1d29megDn9bQ0g7rw04=ujsWCe_bN1Kc1NW_-NZw@mail.gmail.com>
 <20170719204854.6jwkt6q7shnlfelu@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33973 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753239AbdGSU5j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 16:57:39 -0400
Received: by mail-pf0-f177.google.com with SMTP id q85so4332394pfq.1
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 13:57:39 -0700 (PDT)
In-Reply-To: <20170719204854.6jwkt6q7shnlfelu@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jul 19, 2017 at 4:48 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> The original patch had a testcase for the regressions testsuite.
> Is there a reasons why there it has been dropped here?
>
> The original patch had a reference to the patch it fixed,
> which is quite helpful to understand the exact situation.
> Is there a reason why it has been dropped here?

Nope, I was hoping your can merge the patch with your test
case and resubmit as a combine patch. I haven't heard from
you so far so that is what I have.

It feel wrong for me to take your test case and submit as mine.
Again I consider my change just an alternative incremental change
build on top of yours.

If you want to improve the commit message or comment on the
source, I am all for it. I am glad to see that. I haven't push my
change to master for that reason. On the other hand, I can't
hold the release for ever.

Chris
