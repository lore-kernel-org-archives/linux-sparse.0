From: Van Oostenryck Luc <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 0/8] fix uses of killed instructions
Date: Tue, 7 Feb 2017 20:30:19 +0100
Message-ID: <CAExDi1RJ8rPE7n7eGmBRnSe3FudW28HF7DkVErmVmniZrwSQJQ@mail.gmail.com>
References: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34067 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbdBGTaV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 14:30:21 -0500
Received: by mail-qt0-f193.google.com with SMTP id w20so20239447qtb.1
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 11:30:21 -0800 (PST)
In-Reply-To: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Sun, Jan 29, 2017 at 11:48 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> - drop patch 2 ("fix killing of OP_SETVAL instructions") as it causes
>   a strange unexpected change at a single place when testing on a kernel
>   allyesconfig on x86.

I've investigated what was happening with this one.
Everything is all right.
What was happening was that the absence of the patch
"fix value of label statement" created a lot of dead OP_SETVAL.
The patch "fix killing of OP_SETVAL instructions" did its job
but the code was wrong anyway and created a lot of changes
in kernel's allyesconfig's output.

So now that "fix value of label statement" is applied, you can
safely apply "fix killing of OP_SETVAL instructions" somewhere
after it, it won't create useless noise.

Luc
