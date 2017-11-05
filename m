From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 29/36] build: use git-clean
Date: Mon, 6 Nov 2017 07:09:11 +0800
Message-ID: <CANeU7Qn84dG+AfncgrmmdtM3WnTk7J6JpMxaGMtKyoESGMyPdA@mail.gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-29-luc.vanoostenryck@gmail.com> <20171105174100.r3y4o4m2i47d25o5@s>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:43245 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdKEXJM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 18:09:12 -0500
Received: by mail-yw0-f193.google.com with SMTP id y75so6490625ywg.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 15:09:12 -0800 (PST)
In-Reply-To: <20171105174100.r3y4o4m2i47d25o5@s>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>

On Mon, Nov 6, 2017 at 1:41 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> No, you can't use git-clean here, for two reasons.
>
> First, it has to be possible to build, and clean, sparse from a
> tarball release, not just a git repository.

I totally agree with Josh,

Sparse should be able to build clean from just tar balls
without git.

You can still download the sparse tar ball from KORG
using snapshot for example.

https://git.kernel.org/pub/scm/devel/sparse/sparse.git/snapshot/sparse-0.5.1.tar.gz

Chris
