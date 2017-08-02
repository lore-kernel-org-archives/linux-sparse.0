From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: What is cooking in sparse-next
Date: Thu, 3 Aug 2017 00:56:16 +0200
Message-ID: <CAMHZB6H=5dORMuDA-LwUV2zHx7p-QAHaxmi9qe6S1oeqM8KYRw@mail.gmail.com>
References: <CANeU7QkzU9rvyne26zYYEN_jxeLwUN_TWh+YLjRP-X2chiE_-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34001 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdHBW4S (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Aug 2017 18:56:18 -0400
Received: by mail-qk0-f182.google.com with SMTP id u139so35481688qka.1
        for <linux-sparse@vger.kernel.org>; Wed, 02 Aug 2017 15:56:17 -0700 (PDT)
In-Reply-To: <CANeU7QkzU9rvyne26zYYEN_jxeLwUN_TWh+YLjRP-X2chiE_-A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Wed, Aug 2, 2017 at 9:47 PM, Christopher Li <sparse@chrisli.org> wrote:
> I have merge Luc's fix-fuzzy-crashes-v3 into sparse-next as base.
>
> I also revert the change aa497b9f6dab68a1f1d2b8f02bc03b523de15716
> which revert commit 11b1a83b d7985338.
>
> In other words, 11b1a83b d7985338 is reinstated in sparse-next.
> Only the test case has remain in the sparse-next.
>
> I want to give Luc's 7 patches a bit more chance to test. That is what
> sparse-next was for, testing new patches.
>
> I think it is a better base for the RC5 any way.
>
> I have verify the full kernel checking with spase remain pretty much unchanged.
> More testing on the way. Guys, please throw more test on the sparse-next as
> well.
>
> Please report back if any one run into problem with the current tip of
> sparse-next.
>
> BTW, Luc, if you have better patch to fix the second nested loop delete
> problem, feel free to trash the one in sparse-next :-)

Which patch? Which second nested loop delete?
The "Let pseudo->users loop on duplicate version of list" one?

-- Luc
