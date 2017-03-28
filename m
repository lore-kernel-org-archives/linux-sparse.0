From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Potential incorrect simplification
Date: Tue, 28 Mar 2017 16:11:14 +0200
Message-ID: <20170328141113.kbrwdva6ttsrokts@macpro.local>
References: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
 <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35495 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbdC1OLe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 10:11:34 -0400
Received: by mail-wr0-f178.google.com with SMTP id u1so107337186wra.2
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 07:11:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 28, 2017 at 02:58:57PM +0100, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> 
> The first instruction and.32 refers to %r4 which is undefined.

Yes, I saw.
This %r4 corresponds (somehow) to s3 which isn't initialized.

But yes, there is two problems here:
*) we should use something explicit, like VOID
*) there is a circulary dependence between %r3 & %r4, the first %r4
   being obviously wrong.

I suspect there is a lot of problems present once there is some
undefined variables.

Thanks for the repoort.

-- Luc
