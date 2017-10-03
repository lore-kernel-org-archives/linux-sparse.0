From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix cgcc ELF version for ppc64/pcc64le
Date: Tue, 3 Oct 2017 00:46:44 -0400
Message-ID: <CANeU7QkHASgSkVuKT0yj6MD_g+KoXDGj5XWY1pw=0vwhYAriBg@mail.gmail.com>
References: <20170927080007.jz2vfe4ekjjowkbe@taurus.defre.kleine-koenig.org> <20170927211137.16461-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:53985 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbdJCEqp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 3 Oct 2017 00:46:45 -0400
Received: by mail-qt0-f178.google.com with SMTP id 47so10880235qts.10
        for <linux-sparse@vger.kernel.org>; Mon, 02 Oct 2017 21:46:45 -0700 (PDT)
In-Reply-To: <20170927211137.16461-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>

On Wed, Sep 27, 2017 at 5:11 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Commit e0306fe0 "cgcc: teach cgcc about ppc64[le]" add support
> for PPC64 to cgcc by adding the needed options like '-m64' &
> '-m{little,big}-endian' and defines likes '-D__PPC64__=1'.
>
> In this commit the defined '-D_CALL_ELF=2' was also added
> but the value of 2 is for ELF v2 ABI, normally used for ppc64le,
> while the older ELF ABI, normally used for plain ppc64 should use
> '-D_CALL_ELF=2'.
>
> Fix this by using the value of 1 or 2 for '_CALL_ELF' depending
> if the architecture is ppc64 or ppc64le.

Applied on master.

Chris
