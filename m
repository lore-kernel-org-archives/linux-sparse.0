From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix: build sparse-llvm on i686s too.
Date: Thu, 7 Dec 2017 10:20:06 +0800
Message-ID: <CANeU7QnuAwrXcC7n=_M+UL=xAUoxaHrb=Wbb3d=W05dP3Wm3TQ@mail.gmail.com>
References: <20171206102554.12887-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:45299 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbdLGCUH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Dec 2017 21:20:07 -0500
Received: by mail-yb0-f195.google.com with SMTP id 184so2393698ybw.12
        for <linux-sparse@vger.kernel.org>; Wed, 06 Dec 2017 18:20:07 -0800 (PST)
In-Reply-To: <20171206102554.12887-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Dec 6, 2017 at 6:25 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> In commit "f1e4ba13d (build: disable sparse-llvm on non-x86)",
> we wanted to disable the build of sparse-llvm on non-x86 archs
> but the pattern used also excluded machines like 'i686'.
>
> Fix this by using the pattern 'i[3456]86' instead.

Looks good to me.

Chris
