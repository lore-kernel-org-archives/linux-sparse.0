From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] llvm: fix output_op_[ptr]cast()
Date: Mon, 6 Mar 2017 09:56:42 +0800
Message-ID: <CANeU7Qk1JVtk1VTn-ifosVi58Mw8H6TvhiT7wRDF5N5ODpoYMA@mail.gmail.com>
References: <CACXZuxcd6q6c5VzsYME01nzUhKzLjzvxTDt3juSbNB226APTTg@mail.gmail.com>
 <20170303052459.2351-1-luc.vanoostenryck@gmail.com> <CACXZuxcN_5H+Ur53axpwbxy-LwQX2fANp5x6GUU-jU+7b4_2tw@mail.gmail.com>
 <CACXZuxd_gY9uaDHiCzq1TqRweeyp22ifWDDYZbYmjnMkGohenw@mail.gmail.com>
 <CACXZuxcBg1ry4d2AihkAJUX-6L-W_17HYXvja3q=2TFPGoJmNg@mail.gmail.com> <CAExDi1Rgc9M9rs2KfXv_Wrn_iKA+FKKc0e8MHBxU59mLOZASAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36130 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbdCFB4n (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 20:56:43 -0500
Received: by mail-io0-f182.google.com with SMTP id l7so104423322ioe.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 17:56:43 -0800 (PST)
In-Reply-To: <CAExDi1Rgc9M9rs2KfXv_Wrn_iKA+FKKc0e8MHBxU59mLOZASAg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Mar 4, 2017 at 3:55 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Mar 3, 2017 at 7:30 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> Perhaps we need these fixes?
>>
>> https://patchwork.kernel.org/patch/8175541/
>
> I very much doubt it would make any difference.
> This patch is part of a serie enforcing correct handling
> of constant expression *as defined by the standard*.
> It won't change the type of an expression or something like this.

I second that. Those patch series give warnings but it should not
affect the IR.

Chris
