From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: what is cooking in sparse-next-20170805
Date: Sun, 6 Aug 2017 03:52:54 +0200
Message-ID: <20170806015253.752xof7o3nnf2gps@ltop.local>
References: <CANeU7Q=PetPO=LujGB9mk6RhzJz9aQivYNgx=_4Eht3XMrPFCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35849 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdHFBw6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Aug 2017 21:52:58 -0400
Received: by mail-wm0-f51.google.com with SMTP id t201so44642348wmt.1
        for <linux-sparse@vger.kernel.org>; Sat, 05 Aug 2017 18:52:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=PetPO=LujGB9mk6RhzJz9aQivYNgx=_4Eht3XMrPFCA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 05, 2017 at 08:42:12AM -0400, Christopher Li wrote:
> Two new series from Luc has been applied.
> - fix: give a type to bad conditionnal expressions
>   I confirm the wine source file checking went from 23s to 3.x seconds.
> 
> - fix list corruption with recursive remove_usage()
>    this replace 7d54acb0d6d4a9dff3c91688b0223cd4c4a6d6ea
>    "Let pseudo->users loop on duplicate versin of list"
> 
> The kernel compile check shows that has output difference in 3 files
> compare to rc4. I include the diff here. I will dig a bit more which change
> cause it. It seems reasonable enough.  There is one context imbalance
> warning was gone. My guess is that the conditional expression patch
> make sparse understand the source code better now.

Yes.

Also the context checking warnings are quite sensitive to
small changes in the optimization (via the merging of BBs).
But then it's just a change in the file:line:pos, like in
the first file here under. The other two are different and
I also think they are due to the cond-expr change.

-- Luc
