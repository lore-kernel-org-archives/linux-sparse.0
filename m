From: Christopher Li <sparse@chrisli.org>
Subject: Re: Question about Sparse parsing of initializers
Date: Mon, 21 Aug 2017 15:31:38 -0400
Message-ID: <CANeU7Qm9+3MM+vM1tjktEvpbZrQiFydpZ2rw9HrMe8N9=1V=8g@mail.gmail.com>
References: <CACXZuxdMMvWmyW7THq5se-jf07vVt0kQZg3BOtomV6rKEdyRog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35917 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753555AbdHUTbk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 15:31:40 -0400
Received: by mail-yw0-f181.google.com with SMTP id y64so12207324ywf.3
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 12:31:39 -0700 (PDT)
In-Reply-To: <CACXZuxdMMvWmyW7THq5se-jf07vVt0kQZg3BOtomV6rKEdyRog@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 21, 2017 at 3:29 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi,
>
> I see a comment in show_initializer_expr() that:
>
> // Initializer indexes and identifiers should
> // have been evaluated to EXPR_POS
>
> Does this mean that EXPR_IDENTIFIER and EXPR_INDEX are intermediate
> steps that get replaced by EXPR_POS?

Yes, that is exactly the case.

EXPR_IDENTIFIER are for { .name = "my name" }
EXPR_INDEX are for { [2] = 10 }

EXPR_POS has convert those into structure bit offset.

Chris
