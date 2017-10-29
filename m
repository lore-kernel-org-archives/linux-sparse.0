From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] llvm fixes
Date: Mon, 30 Oct 2017 07:13:20 +0800
Message-ID: <CANeU7Qnu7h09YHhGVOY3r4M9FNOvOrs+kB_yJT-i0cSeLtKhAw@mail.gmail.com>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:47247 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdJ2XNV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Oct 2017 19:13:21 -0400
Received: by mail-yw0-f172.google.com with SMTP id u142so10018016ywg.4
        for <linux-sparse@vger.kernel.org>; Sun, 29 Oct 2017 16:13:21 -0700 (PDT)
In-Reply-To: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Sep 18, 2017 at 5:51 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Chris,
>
> Please, pull these patches for master.
>
> No surprises here, it's just all March's good old fixes
> for sparse-llvm which have been rebased on top of rc5.
>

Hi Luc,

Sorry for the delay. I will start to reply to your patch email in this series.
I have some feed back store on my computer a while back but I haven't
have to the chance send out the email.

Over all the the series seems good. It seems have some measurable
speed up in my stress test. There is one of two patch I will comment more
in the follow up email. I will reply in the order of the patch send
out. If a patch
does not have comment, that means it looks good to me.

BTW, I think a lot of the 68 patches can be break into smaller series.
There is some inter dependency but not that much especially relate to
the testsuite. Smaller series will make it easier to review.

More email to follow up.

Thanks for the series and sorry for the delay.

Chris
