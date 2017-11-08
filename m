From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] volatile loads are side-effects too
Date: Wed, 8 Nov 2017 09:17:24 +0100
Message-ID: <20171108081722.7uwweh4657nk4o64@ltop.local>
References: <20171107155944.68463-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qm71L93qAKrsrfuCGGnYB3b2XPDhBq9hwJzTj_jHfD9Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:55172 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbdKHIR3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 03:17:29 -0500
Received: by mail-wr0-f177.google.com with SMTP id l22so1597223wrc.11
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 00:17:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qm71L93qAKrsrfuCGGnYB3b2XPDhBq9hwJzTj_jHfD9Eg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Nov 08, 2017 at 02:55:05AM +0800, Christopher Li wrote:
> On Tue, Nov 7, 2017 at 11:59 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Some branch simplifications are only valid if the branch is free
> > of side-effects. The check is done in flow.c:bb_has_side_effects()
> > but currently deosn't take in account the fact that a volatile load
> > is also a side-effect.
> >
> > Fix this by adding the appropriate check.
> >
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> Looks good to me.

Thank you for the review.
Thank you for the very fast review.

-- Luc
