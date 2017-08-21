From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Question about Sparse parsing of initializers
Date: Mon, 21 Aug 2017 20:32:57 +0100
Message-ID: <CACXZuxfhxQcHYZ6SGarbuw=-0U57PdO2kXHFdAiwKaN+6rT9vg@mail.gmail.com>
References: <CACXZuxdMMvWmyW7THq5se-jf07vVt0kQZg3BOtomV6rKEdyRog@mail.gmail.com>
 <CANeU7Qm9+3MM+vM1tjktEvpbZrQiFydpZ2rw9HrMe8N9=1V=8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:38455 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbdHUTc6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 15:32:58 -0400
Received: by mail-ua0-f176.google.com with SMTP id n29so26127367uai.5
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 12:32:58 -0700 (PDT)
In-Reply-To: <CANeU7Qm9+3MM+vM1tjktEvpbZrQiFydpZ2rw9HrMe8N9=1V=8g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 21 August 2017 at 20:31, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Aug 21, 2017 at 3:29 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> I see a comment in show_initializer_expr() that:
>>
>> // Initializer indexes and identifiers should
>> // have been evaluated to EXPR_POS
>>
>> Does this mean that EXPR_IDENTIFIER and EXPR_INDEX are intermediate
>> steps that get replaced by EXPR_POS?
>
> Yes, that is exactly the case.
>
> EXPR_IDENTIFIER are for { .name = "my name" }
> EXPR_INDEX are for { [2] = 10 }
>
> EXPR_POS has convert those into structure bit offset.
>

Okay thanks!

Regards
Dibyendu
