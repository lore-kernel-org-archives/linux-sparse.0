From: Christopher Li <sparse@chrisli.org>
Subject: Re: What is cooking in sparse-next
Date: Wed, 2 Aug 2017 19:02:10 -0400
Message-ID: <CANeU7Q=1j1UJkr1MkmZuD9p+q374UAw4h7ex7CW+fvcqVQqsRA@mail.gmail.com>
References: <CANeU7QkzU9rvyne26zYYEN_jxeLwUN_TWh+YLjRP-X2chiE_-A@mail.gmail.com>
 <CAMHZB6H=5dORMuDA-LwUV2zHx7p-QAHaxmi9qe6S1oeqM8KYRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:37638 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbdHBXCL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Aug 2017 19:02:11 -0400
Received: by mail-pg0-f49.google.com with SMTP id y129so26741665pgy.4
        for <linux-sparse@vger.kernel.org>; Wed, 02 Aug 2017 16:02:11 -0700 (PDT)
In-Reply-To: <CAMHZB6H=5dORMuDA-LwUV2zHx7p-QAHaxmi9qe6S1oeqM8KYRw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Wed, Aug 2, 2017 at 6:56 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Which patch? Which second nested loop delete?
> The "Let pseudo->users loop on duplicate version of list" one?

Yes,  "Let pseudo->users loop on duplicate versin of list".
It is 7d54acb0d6d4a9dff3c91688b0223cd4c4a6d6ea on sparse-next
right now.

It currently use the duplicate list, so if the list entry was deleted
in the inner loop.
The entry will still be loop on the outer loop. I just notice there is
a typo on the
commit message "version" as well.

Chris
