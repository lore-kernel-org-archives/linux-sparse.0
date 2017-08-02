From: Christopher Li <sparse@chrisli.org>
Subject: What is cooking in sparse-next
Date: Wed, 2 Aug 2017 15:47:08 -0400
Message-ID: <CANeU7QkzU9rvyne26zYYEN_jxeLwUN_TWh+YLjRP-X2chiE_-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35154 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdHBTrJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Aug 2017 15:47:09 -0400
Received: by mail-pf0-f180.google.com with SMTP id t86so24873673pfe.2
        for <linux-sparse@vger.kernel.org>; Wed, 02 Aug 2017 12:47:09 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Michael Stefaniuc <mstefani@mykolab.com>

I have merge Luc's fix-fuzzy-crashes-v3 into sparse-next as base.

I also revert the change aa497b9f6dab68a1f1d2b8f02bc03b523de15716
which revert commit 11b1a83b d7985338.

In other words, 11b1a83b d7985338 is reinstated in sparse-next.
Only the test case has remain in the sparse-next.

I want to give Luc's 7 patches a bit more chance to test. That is what
sparse-next was for, testing new patches.

I think it is a better base for the RC5 any way.

I have verify the full kernel checking with spase remain pretty much unchanged.
More testing on the way. Guys, please throw more test on the sparse-next as
well.

Please report back if any one run into problem with the current tip of
sparse-next.

BTW, Luc, if you have better patch to fix the second nested loop delete
problem, feel free to trash the one in sparse-next :-)

Chris
