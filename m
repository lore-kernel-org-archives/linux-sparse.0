From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Casting 0 to a __bitwise type
Date: Tue, 14 Feb 2017 23:51:30 +0100
Message-ID: <20170214225127.gxvtfnbe5dkqp4lq@macbook.local>
References: <9c361aab-ee4b-8309-ff1a-b0e65bb93c5d@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36455 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdBNWvh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Feb 2017 17:51:37 -0500
Received: by mail-wr0-f169.google.com with SMTP id k90so179557322wrc.3
        for <linux-sparse@vger.kernel.org>; Tue, 14 Feb 2017 14:51:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9c361aab-ee4b-8309-ff1a-b0e65bb93c5d@solarflare.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Edward Cree <ecree@solarflare.com>
Cc: linux-sparse@vger.kernel.org

On Tue, Feb 14, 2017 at 09:36:40PM +0000, Edward Cree wrote:
> I'm given to understand that bitwise types consider 0 'special', in that
>  sparse will allow, say:
>         typedef __u32 __bitwise __be32;
>         __be32 value = 0;
> However, it appears that if I try to cast a constant 0 to a bitwise type,
>         static inline void ip6_fill_mask(__be32 *mask)
>         {
>                 mask[0] = mask[1] = mask[2] = mask[3] = ~(__be32)0;
>         }
> sparse complains "warning: cast to restricted __be32".

I can't reproduce this with the current head.
Wich version of sparse are you using? Can you retry with sparse's head?


Luc Van Oostenryck
