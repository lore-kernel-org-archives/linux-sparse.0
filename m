From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Sun, 5 Nov 2017 08:45:53 +0800
Message-ID: <CANeU7Qm4+DWdcDrMytWqxTELrwuyMEkhs2hFGj6599ghetBE8A@mail.gmail.com>
References: <20171025100222.5983-1-jlayton@kernel.org> <20171025142009.foxh2rblmfpxvm7d@ltop.local>
 <CANeU7Qnvvezdc62s-cAWNonw2cKOJPWH2xSdgTdAL4M4skSnJw@mail.gmail.com>
 <1509019885.29077.6.camel@kernel.org> <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
 <1509476260.4553.45.camel@kernel.org> <CANeU7Qm8YHpYLLW8O=y=m9m6kRAD_5MiTnS79N5ffCk-PVcxFQ@mail.gmail.com>
 <20171101141705.aqn5gnwvuohkapp3@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:48423 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbdKEApy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Nov 2017 20:45:54 -0400
Received: by mail-yw0-f196.google.com with SMTP id q1so5281948ywh.5
        for <linux-sparse@vger.kernel.org>; Sat, 04 Nov 2017 17:45:54 -0700 (PDT)
In-Reply-To: <20171101141705.aqn5gnwvuohkapp3@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Nov 1, 2017 at 10:17 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

> This is still not correct. It still doesn't allow to compile sparse
> via 'make CFLAGS=<some extra flags, possibly none>'.
>
> Visibly this hasn't been tested.

Sorry about that.

There is one spot I miss after solving conflict of rebase master.

How about this one:

https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=cflags-v3

Thanks

Chris
