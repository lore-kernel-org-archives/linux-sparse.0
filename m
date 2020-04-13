From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 13/17] scope: let labels have their own scope
Date: Mon, 13 Apr 2020 10:30:49 -0700
Message-ID: <CAHk-=wiLAGGb=RLUQvAggvqf5tbAp1nUPyKUrimwy2BRAso69A@mail.gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com> <20200413161605.95900-14-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732781AbgDMRbK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 13:31:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD075C0A3BDC
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 10:31:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m8so9569272lji.1
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 10:31:09 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id c4sm8470976lfg.82.2020.04.13.10.31.06
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 10:31:06 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id j14so1812476lfg.9
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 10:31:06 -0700 (PDT)
In-Reply-To: <20200413161605.95900-14-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Apr 13, 2020 at 9:16 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> One way of detecting gotos inside an statement expression
> is to use a new kind of scope for the gotos & labels.

Ack. This is a much better approach than trying to figure things out later.

Very nice.

               Linus
