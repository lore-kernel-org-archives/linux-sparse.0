From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Mon, 30 Oct 2017 14:34:54 +0800
Message-ID: <CANeU7QnMfs5edS71xV7d1_TBwNyikNGBti91vA+Tnmh7Na579A@mail.gmail.com>
References: <20171025100222.5983-1-jlayton@kernel.org> <20171025142009.foxh2rblmfpxvm7d@ltop.local>
 <CANeU7Qnvvezdc62s-cAWNonw2cKOJPWH2xSdgTdAL4M4skSnJw@mail.gmail.com>
 <1509019885.29077.6.camel@kernel.org> <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
 <20171029172809.6nlaz5lvxdcs677w@ltop.local> <CANeU7QnQi3313pVMiv4pGTZE51XU2EUbrB3Dg=DHgM-T-7f0EA@mail.gmail.com>
 <20171030054039.4qjxtpcpxq2xnvcd@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:45871 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdJ3Gez (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 30 Oct 2017 02:34:55 -0400
Received: by mail-yw0-f179.google.com with SMTP id j4so10634106ywb.2
        for <linux-sparse@vger.kernel.org>; Sun, 29 Oct 2017 23:34:55 -0700 (PDT)
In-Reply-To: <20171030054039.4qjxtpcpxq2xnvcd@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Oct 30, 2017 at 1:40 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Since for flags like -O[0123] but also for all flags like -f[no-]xxx
> and all sort of others settings in GCC and in a multitude of others
> programs it's the last value that matters, appending to CFLAGS *is*
> the usual way to *override* previous settings.
> Jeff's patch allowed that, mine too but yours not.

Ah, I see. Thanks the for catching that. I did not notice that subtle
detail. I just need to reorder the CFLAGS as the last variable then.

Chris
