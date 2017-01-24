From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Query regarding sizeof long
Date: Tue, 24 Jan 2017 15:47:12 +0100
Message-ID: <20170124144711.evipzg47ka572qgd@macpro.local>
References: <CACXZuxdCP6C_1Y7OHgrxkLYct6CuuArM22ZH6_g_CHixMDhTQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34162 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdAXOrT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 24 Jan 2017 09:47:19 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so35089190wmi.1
        for <linux-sparse@vger.kernel.org>; Tue, 24 Jan 2017 06:47:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxdCP6C_1Y7OHgrxkLYct6CuuArM22ZH6_g_CHixMDhTQQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org

On Tue, Jan 24, 2017 at 02:23:13PM +0000, Dibyendu Majumdar wrote:
> Hi
> 
> I am working on porting Sparse to Windows, and I noticed that in
> 64-bit architecture the bits_in_long is set to 64. This is not true
> for Windows where long is 32 bits on a 64-bit machine. I was wondering
> if I just need to set this parameter to 32 or if there are other
> implications that I need to be aware of.

Hi,

If you just change the initial value in target.c, it won't do what you
need because currently, if you compile sparse on a machine where
__x86_64__ is defined, it will automatically enable the -m64 option
which will setup things for an LP64 architecture instead of the LLP64
that you need (inside handle_arch_m64_finalize()).

Ideally, we should have a mean to configure the default value of such
things at building time.

Hope it helps,
Luc 
