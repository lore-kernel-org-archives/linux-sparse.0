From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] volatile loads are side-effects too
Date: Wed, 8 Nov 2017 02:55:05 +0800
Message-ID: <CANeU7Qm71L93qAKrsrfuCGGnYB3b2XPDhBq9hwJzTj_jHfD9Eg@mail.gmail.com>
References: <20171107155944.68463-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:52244 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756695AbdKGSzG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Nov 2017 13:55:06 -0500
Received: by mail-yw0-f175.google.com with SMTP id w2so197670ywa.9
        for <linux-sparse@vger.kernel.org>; Tue, 07 Nov 2017 10:55:06 -0800 (PST)
In-Reply-To: <20171107155944.68463-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Nov 7, 2017 at 11:59 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Some branch simplifications are only valid if the branch is free
> of side-effects. The check is done in flow.c:bb_has_side_effects()
> but currently deosn't take in account the fact that a volatile load
> is also a side-effect.
>
> Fix this by adding the appropriate check.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Looks good to me.

Chris
