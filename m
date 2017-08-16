From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] sparse SSA construction
Date: Wed, 16 Aug 2017 09:22:08 -0400
Message-ID: <CANeU7Qkm=y5PSvfVGZ9+1qet7A3iL98m2QGqp=amfYwg4-mpJA@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
 <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com>
 <CACXZuxdbgoYtSwsutp+FUqjb8v_yX=BpmntBiBn092eoJ-zBjg@mail.gmail.com>
 <CAExDi1SXeds8_NPa37VTVLL-fRxY=xfhTDtFj8D4rUcAeoBkig@mail.gmail.com>
 <CACXZuxfd074S1jJMotGzn=MK-RORU7DEe7uj_yQ7oZPeyxVF9g@mail.gmail.com>
 <CAMHZB6Es+y+xCGMOrd=gvsqiTVWgz3niOXOQrv3fTFzr=6akVA@mail.gmail.com>
 <CACXZuxcFHGsfhMTT-BacMkkE5vZk7jScAZdkjeaX0rT+yWiEFQ@mail.gmail.com>
 <CANeU7Qn_raZ2RaK+aK_ms6GZOxE_-vRcqfc1oZrnTm1nTN49vw@mail.gmail.com>
 <CACXZuxd1NrUevtuAJe4rOELKA5iOajxLo=MxHqpk6U82UtGvUw@mail.gmail.com> <CANeU7Q=foyyU1_VvBKEdu8yLrOC2Si=2xboXYeokBBo0Bin64A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:32917 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdHPNWK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 09:22:10 -0400
Received: by mail-yw0-f171.google.com with SMTP id p68so22405620ywg.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 06:22:10 -0700 (PDT)
In-Reply-To: <CANeU7Q=foyyU1_VvBKEdu8yLrOC2Si=2xboXYeokBBo0Bin64A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 16, 2017 at 9:11 AM, Christopher Li <sparse@chrisli.org> wrote:
>> But Luc's implementation handles gotos fine without the extra phase -
>> hence please please try out the implementation before arriving at
>> conclusions.
>
> As I state very clear in the title, my thought as regarding the paper,
> and paper only. I will take some time to read Luc's implementation
> next.

Oops, sorry I mix up  the two email thread talk about SSA.
This thread is about the patch not paper. You are right I shouldn't
draw conclusion on it before reading it in more detail.

Let me restart.  Now I read the paper (kind of). I should go read the
implementation patches.

Chris
