From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Status of sparse-next
Date: Mon, 12 Jun 2017 23:27:46 +0100
Message-ID: <CACXZuxfu_W9tzOPdONFD4fGCiivY+VsF_YWfuddwtz8X+B1vUg@mail.gmail.com>
References: <CACXZuxfeUP6bvDwmYv=O4yR7GXOCDeFPf5Sk-_OdXtE+=uZ1Eg@mail.gmail.com>
 <20170611224629.ak7evynf6lcyorz7@ltop.local> <CACXZuxdqtQY=ak+tNJ64H4hg2CdCxLs_W73tYEQhMKFCmoJ3_A@mail.gmail.com>
 <CANeU7Q=P-MbopU3k_gNQEBNMVDLP1C1BYrKEK9n0d3UvAnNpQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36302 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbdFLW1s (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Jun 2017 18:27:48 -0400
Received: by mail-wr0-f169.google.com with SMTP id v111so116017309wrc.3
        for <linux-sparse@vger.kernel.org>; Mon, 12 Jun 2017 15:27:48 -0700 (PDT)
In-Reply-To: <CANeU7Q=P-MbopU3k_gNQEBNMVDLP1C1BYrKEK9n0d3UvAnNpQA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 12 June 2017 at 17:26, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Jun 11, 2017 at 3:57 PM, Dibyendu Majumdar
>>>> I was wondering if the sparse-next branch is going to be stable soon.
>
> I want to clarify that, "stable" you mean the code quality is good (no obvious
> bugs or crashes), or the git branch will not be roll back.
>
> As for the code quality, I believe that is reasonable stable.
>
> As for change roll back, the sparse-next is created with the goal to
> test out some of the newly merge changes. In theory rolling back history
> is possible with sparse-next if we find out some thing seriously wrong
> with the purposed changes. So it is not a stable point if you want to base
> your change on. The master branch will not roll back history,
> that is a more stable branch.
>

Okay thanks, I will wait until the master branch has all the changes,
as I want to minimize the number of merges I have to do.

Thanks and Regards
Dibyendu
