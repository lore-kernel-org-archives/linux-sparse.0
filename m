From: Christopher Li <sparse@chrisli.org>
Subject: Re: Some random thoughts regarding the SSA paper
Date: Wed, 16 Aug 2017 08:56:11 -0400
Message-ID: <CANeU7QktJq4mAH8B_v3FO0pZYzW4N_NsP9oxODcNo=66oLGRMw@mail.gmail.com>
References: <CANeU7QmcVS_8oko6RhG_g_97AjUNVYa=KDqDocbXL5ney=mrJw@mail.gmail.com>
 <CACXZuxdnMFA5HPg3GXLWXP6+Mk8+UikcZsJZH8DJ227PYHyEfQ@mail.gmail.com>
 <CANeU7Q=r4A8WQrqaACQ2iak9CcEXds20peJrr1AqJ8tyxCF56Q@mail.gmail.com>
 <CACXZuxcjBJdM2Sy4KWjaU1Oofr+S3=1vRkznOd9WatycuOSWsw@mail.gmail.com>
 <CANeU7Q=byg+e9qKhyO9cuVgrveqmWUajv_e6AWuK4PsJV4+T4g@mail.gmail.com> <CACXZuxf2Nh=S3bmF+uCDwVaPbHDF44Vb2TPPuMwdXsEBBGTwGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34542 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdHPM4M (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 08:56:12 -0400
Received: by mail-yw0-f180.google.com with SMTP id s143so21886464ywg.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 05:56:12 -0700 (PDT)
In-Reply-To: <CACXZuxf2Nh=S3bmF+uCDwVaPbHDF44Vb2TPPuMwdXsEBBGTwGw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 16, 2017 at 8:47 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> That is only if you want a minimal SSA right? Do you need one? Again I
> suggest you try out Luc's implementation which appears to work fine -
> and it doesn't do this extra pass I believe.

If it does not do this extra pass then it will leave redundant phi node around.
Base on my understanding of the paper.

Yes, I would like to have minimal phi node SSA. Other than the code size,
the extra redundant phi node will have impact on later stage of the
optimization.
It make the define and usage chain less clear, having the middle man phi node
might or might not be needed.

Chris
