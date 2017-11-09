From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Fri, 10 Nov 2017 05:10:48 +0800
Message-ID: <CANeU7Qk=pg0kWEoT6KUK_+6PVEjfAJeh+-_=dB_LqT-Bh+88CQ@mail.gmail.com>
References: <20171025100222.5983-1-jlayton@kernel.org> <20171025142009.foxh2rblmfpxvm7d@ltop.local>
 <CANeU7Qnvvezdc62s-cAWNonw2cKOJPWH2xSdgTdAL4M4skSnJw@mail.gmail.com>
 <1509019885.29077.6.camel@kernel.org> <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
 <1509476260.4553.45.camel@kernel.org> <CANeU7Qm8YHpYLLW8O=y=m9m6kRAD_5MiTnS79N5ffCk-PVcxFQ@mail.gmail.com>
 <20171101141705.aqn5gnwvuohkapp3@ltop.local> <CANeU7Qm4+DWdcDrMytWqxTELrwuyMEkhs2hFGj6599ghetBE8A@mail.gmail.com>
 <20171105165751.iqqlaxz6yu27nouj@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:51058 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdKIVKt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 16:10:49 -0500
Received: by mail-yw0-f193.google.com with SMTP id i198so6498421ywe.7
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 13:10:49 -0800 (PST)
In-Reply-To: <20171105165751.iqqlaxz6yu27nouj@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 6, 2017 at 12:57 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Much better!
> Now you can give it a try at 'make CFLAGS=-O3 selfcheck'.
>
The selfcheck on sparse-llvm.sc is independent of the CFLAGS changes.
BTW, I never saw the brakage on FC 26. because "llvm-config --cflags" does not
add new search path.

Here is the V4:

https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/commit/?h=cflags-v4

Chris
