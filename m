From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 0/5] fix list corruption with recursive remove_usage()
Date: Sat, 5 Aug 2017 07:45:16 -0400
Message-ID: <CANeU7Qknou8p02+t61mD7cxUvg4JaE6UVPc71+rFf_xwL7HKeQ@mail.gmail.com>
References: <20170804215321.66392-1-luc.vanoostenryck@gmail.com>
 <CAExDi1Ra9v5QXoP-oSRH6J7XFadMAO5BC79e0e9+-FMjvnwmNw@mail.gmail.com>
 <CANeU7QkKeP_eqCZkutog53zPiASQVOtMPzyRDPtP9ggAQyMuMA@mail.gmail.com> <CAExDi1Rv17E=RwZwhZQKKcsHtnnvz7cyuo1dGQG=eN-QaCDcfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35553 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdHELpR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Aug 2017 07:45:17 -0400
Received: by mail-pf0-f173.google.com with SMTP id t86so17329143pfe.2
        for <linux-sparse@vger.kernel.org>; Sat, 05 Aug 2017 04:45:17 -0700 (PDT)
In-Reply-To: <CAExDi1Rv17E=RwZwhZQKKcsHtnnvz7cyuo1dGQG=eN-QaCDcfg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 5, 2017 at 4:55 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Yes, sure.
> Why you're asking?

OK, I apply the series using patches.
I need to fix up the 4/5 though. As it is the patch 4 will not compile.
The fix is in patch 5. I move that part of the fix from patch 5 to patch 4.

It should be one sparse-next soon. You can check if out if I did any thing
wrong

Chris
