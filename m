From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] fix crash in ctags.c
Date: Fri, 5 Jan 2018 01:44:51 +0800
Message-ID: <CANeU7Qn7qpkro6sdEGJTf6T2rS1-W+9CdaCEqOD6j8P+ePpuXQ@mail.gmail.com>
References: <20180101225817.3cb135dc04ea0195f28d8512@redchan.it> <20180102151116.22060-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36291 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeADRox (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 Jan 2018 12:44:53 -0500
Received: by mail-yb0-f194.google.com with SMTP id j7so913063ybl.3
        for <linux-sparse@vger.kernel.org>; Thu, 04 Jan 2018 09:44:52 -0800 (PST)
In-Reply-To: <20180102151116.22060-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, foobar <foobar@redchan.it>

On Tue, Jan 2, 2018 at 11:11 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This series contains two patches fixing a null pointer
> dereference in ctags.
>
> Note: part of the problem here is that the ctags tools directly
>       use global_scope->symbols and that the builtins are in
>       the global scope. I think they should be in a separate
>       scope, but it'll be another story.
>
> These patches are available in the Git repository at:
>   git://github.com/lucvoo/sparse-dev.git fix-ctags-crash
> and soon will be pushed at:
>   git://github.com/lucvoo/sparse.git     master
>
> Luc Van Oostenryck (2):
>   give a type to builtin functions
>   ctags: avoid null deref

Sorry for the late reply. I will take a look at it tomorrow.
Too late for me to think straight now.

Thanks for the patches

Chris
