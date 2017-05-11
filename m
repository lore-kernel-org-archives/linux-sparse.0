From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] avoid useless warning for 'bool <- restricted type' conversion
Date: Thu, 11 May 2017 12:41:24 -0700
Message-ID: <CANeU7Qn1_FpuU2+n6x6Sh=kuERwdGA952VbOwfdpRMQR3WkaxQ@mail.gmail.com>
References: <20170511060744.GJ390@ZenIV.linux.org.uk> <20170511162127.15692-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:36059 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdEKTlZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 15:41:25 -0400
Received: by mail-io0-f172.google.com with SMTP id o12so28213589iod.3
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 12:41:25 -0700 (PDT)
In-Reply-To: <20170511162127.15692-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Pushkar Jambhlekar <pushkar.iit@gmail.com>

On Thu, May 11, 2017 at 9:21 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Conversion to bool is special in C since this conversion
> is essentially the result of the comparison with zero.
> As such, some operations which are normally unsafe to
> do with restricted types, like casting to an unrestricted
> type, are in fact safe to do when converting to bool
> and issuing a warning in those case is useless, confusing
> and causes people to add useless casts in the code in
> order to shut up the warning.
>
> Fix this by catching such 'bool <- restricted type' conversion
> and avoid such warnings.

The change seems fine. However, have you run the test-suite
with this change? It seems cause some test do not pass.
I assume it is cause by different error message it will output.

Chris
