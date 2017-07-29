From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] fix for rare crashes
Date: Sat, 29 Jul 2017 12:07:16 -0400
Message-ID: <CANeU7QmcSUQBQ0WZz35a9CnZJavFq3X-k=KakhvS4q4+Y70hww@mail.gmail.com>
References: <20170729125303.65852-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34606 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752599AbdG2QHS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 12:07:18 -0400
Received: by mail-pg0-f47.google.com with SMTP id u185so16518711pgb.1
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 09:07:17 -0700 (PDT)
In-Reply-To: <20170729125303.65852-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jul 29, 2017 at 8:53 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Chris, this pull request is for the rare crashes fixes
> discovered after -rc4.
> The changes since the initial post are:
> - add a note to patch 1
> - avoid an unneeded allocation in patch 4
> - add a missing signoff

Thanks for the patches.

Pull and push to sparse-next already. I rebase some other patch in the
sparse-next
after you change. Let me know if you notices any problems.

Chris
