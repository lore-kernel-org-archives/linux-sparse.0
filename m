From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] llvm: fix output_op_[ptr]cast()
Date: Fri, 3 Mar 2017 20:55:09 +0100
Message-ID: <CAExDi1Rgc9M9rs2KfXv_Wrn_iKA+FKKc0e8MHBxU59mLOZASAg@mail.gmail.com>
References: <CACXZuxcd6q6c5VzsYME01nzUhKzLjzvxTDt3juSbNB226APTTg@mail.gmail.com>
 <20170303052459.2351-1-luc.vanoostenryck@gmail.com> <CACXZuxcN_5H+Ur53axpwbxy-LwQX2fANp5x6GUU-jU+7b4_2tw@mail.gmail.com>
 <CACXZuxd_gY9uaDHiCzq1TqRweeyp22ifWDDYZbYmjnMkGohenw@mail.gmail.com> <CACXZuxcBg1ry4d2AihkAJUX-6L-W_17HYXvja3q=2TFPGoJmNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34214 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbdCCU7y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 15:59:54 -0500
Received: by mail-qk0-f182.google.com with SMTP id g129so12951140qkd.1
        for <linux-sparse@vger.kernel.org>; Fri, 03 Mar 2017 12:59:51 -0800 (PST)
In-Reply-To: <CACXZuxcBg1ry4d2AihkAJUX-6L-W_17HYXvja3q=2TFPGoJmNg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Mar 3, 2017 at 7:30 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Perhaps we need these fixes?
>
> https://patchwork.kernel.org/patch/8175541/

I very much doubt it would make any difference.
This patch is part of a serie enforcing correct handling
of constant expression *as defined by the standard*.
It won't change the type of an expression or something like this.

Luc
