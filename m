From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] fix missing evaluation when using '-include <file>'
Date: Wed, 14 Feb 2018 01:02:45 +0100
Message-ID: <20180214000243.263hmp3puro4h4q3@ltop.local>
References: <CAHmME9o02YNvfqV3RFofJE8FXwRaUACzq03TBADSYc74E02iBg@mail.gmail.com>
 <20170917100552.72288-1-luc.vanoostenryck@gmail.com>
 <CAHmME9ofqdqwUsjmk9TSutFMOFGqstJo1rLuO7VOiC-OCRErGA@mail.gmail.com>
 <CAExDi1Qwc7MSRdDNAURFZNp3SLhWHaC0PKMfgpjVxeC3ZP8S+A@mail.gmail.com>
 <CAExDi1ST5ddB5Ti4rTOCdXsihc=xsuZ6riPAqvFCotrNmjUrUQ@mail.gmail.com>
 <CAHmME9qREfXRQb3ORwd7nyN2E-OTANRKpyirc6FkMON6T8fLOw@mail.gmail.com>
 <20180210200237.a4xmiyppshy5bbbk@ltop.local>
 <CANeU7QkhZix7xj4_pskyPUXSsSLX1qpXU98rJTf1BBBbxvCnXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:42982 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966157AbeBNACs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 19:02:48 -0500
Received: by mail-wr0-f179.google.com with SMTP id k9so6507861wre.9
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 16:02:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QkhZix7xj4_pskyPUXSsSLX1qpXU98rJTf1BBBbxvCnXg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 13, 2018 at 03:49:56PM -0800, Christopher Li wrote:
> On Sat, Feb 10, 2018 at 12:02 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Tue, Jan 30, 2018 at 02:23:11PM +0100, Jason A. Donenfeld wrote:
> >> Any chance of this getting merged into the real sparse tree?
> >>
> >> Jason
> >
> > Chris,
> >
> > Can you please take a look at this one, please?
> 
> Hi, I take a look at this series. It is this series, right?
> 
> https://patchwork.kernel.org/patch/9954727/

These two patches:
https://patchwork.kernel.org/patch/9954725/
https://patchwork.kernel.org/patch/9954727/

> It looks fine to me. I do want to apply them.
> 
> Do you want to make this 2 patch series pullable from master
> or I just apply them as patch?

Just apply them, please.

-- Luc
