From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [RFC] sparse SSA construction
Date: Tue, 15 Aug 2017 15:09:49 +0100
Message-ID: <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com> <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:32948 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbdHOOJu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 15 Aug 2017 10:09:50 -0400
Received: by mail-vk0-f49.google.com with SMTP id j189so2890609vka.0
        for <linux-sparse@vger.kernel.org>; Tue, 15 Aug 2017 07:09:50 -0700 (PDT)
In-Reply-To: <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 15 August 2017 at 15:07, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Aug 15, 2017 at 10:06 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> The good news is that the minimal patch is quite small. I was
>> surprised by how small it is.
>>
> That is good new. Which minimal patch branch are you referring to?
> I know Luc has a few branches regarding the ssa conversion.
>

https://github.com/lucvoo/sparse/tree/sssa-mini-clean

This is built on top of RC5 so merge will be quite straightforward.

Regards
Dibyendu
