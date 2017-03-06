From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 0/6] more validation of C99 for-loop initializers
Date: Mon, 6 Mar 2017 02:08:40 +0100
Message-ID: <20170306010840.joz7bas55skuzvl3@macpro.local>
References: <CANeU7Qk34VzZ6Q2oxEcFrreK=NOwmpSGbiVgvyckpp154xWJaQ@mail.gmail.com>
 <20170305192152.67931-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkepJvpg8p_5H2enP21dg_NVYNhbRhRrEV5MqMTQx3gcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34126 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752398AbdCFBIo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 20:08:44 -0500
Received: by mail-wr0-f175.google.com with SMTP id l37so106298421wrc.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 17:08:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QkepJvpg8p_5H2enP21dg_NVYNhbRhRrEV5MqMTQx3gcw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Mar 06, 2017 at 08:59:35AM +0800, Christopher Li wrote:
> On Mon, Mar 6, 2017 at 3:21 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > This serie adds scope & storage validations of C99-style for-loop
> > initializers.
> 
> This series looks great now. Thank you.
> 
> All applied to sparse-next.

Yes, I like how it turned out.
Thanks to you too.

Luc
