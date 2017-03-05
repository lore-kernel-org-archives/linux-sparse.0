From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 6/7] make process_decl() aware of the presence of an
 initializer
Date: Sun, 5 Mar 2017 16:29:15 +0100
Message-ID: <20170305152915.vbnm3eho27mueymj@macpro.local>
References: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
 <20170228100403.33184-1-luc.vanoostenryck@gmail.com>
 <20170228100403.33184-7-luc.vanoostenryck@gmail.com>
 <CANeU7Qm1oPqK=56=c8q=dtVBr27vF0NufGgCr4Y0RYnyJVfBQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35462 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbdCEP3Y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 10:29:24 -0500
Received: by mail-wr0-f177.google.com with SMTP id g10so101243504wrg.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 07:29:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qm1oPqK=56=c8q=dtVBr27vF0NufGgCr4Y0RYnyJVfBQg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 05, 2017 at 10:49:37PM +0800, Christopher Li wrote:
> This can be written as:
> 
> int has_init = !is_typedef && match_op(token, '=');
> if (has_init) {

Yes, it can.
But honestly I absolutely detest this 'has_init'.

>      ....
> 
> Passing the "has_init" into a call back function make the code hard to
> read because the logic has separated into two function. At the same time
> process_for_loop_decl does not issue this warning at all, I think it should.

Since I just realize that this 'has_init' is not needed as we can
simply test the presence of decl->initializer, I'll remove it.
 
> I will apply this patch for sparse-next, I agree the warning is useful
> behavior. I am also expecting a follow up patch.

Yes.
Don't bother to add it to sparse-next, I'll send another version later.


Luc
