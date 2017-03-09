From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm incorrect definition of local variables
Date: Thu, 9 Mar 2017 15:35:14 +0100
Message-ID: <20170309143513.pe7y5kuclabndyzu@macbook.local>
References: <CACXZuxdH3tryp92DVHhd8zs9bUTbrAs92Pz+knnDqDzj4eXWYQ@mail.gmail.com>
 <20170307064436.qtcscbwbjsrjoyko@macpro.local>
 <CACXZuxcC-VPjB9CD0E9zUXp6XNS8v1DdvPUZ1vc88jqwYdFUhA@mail.gmail.com>
 <20170308065337.vwrebdlo4poc4da4@macpro.local>
 <CACXZuxcbDJAeRBN_wpTRPRk7efOM2vLytke=k_0f4=C0dOQtrA@mail.gmail.com>
 <CACXZuxeQO4p+J5MyggZhWJF9FfwnXHdG_wxx34jF3NFXqgd4Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36154 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754749AbdCIOfS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Mar 2017 09:35:18 -0500
Received: by mail-wr0-f169.google.com with SMTP id u108so46239668wrb.3
        for <linux-sparse@vger.kernel.org>; Thu, 09 Mar 2017 06:35:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxeQO4p+J5MyggZhWJF9FfwnXHdG_wxx34jF3NFXqgd4Yg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Mar 09, 2017 at 01:50:16AM +0000, Dibyendu Majumdar wrote:
> 
> I think by combining the symbol's identifier and address a unique
> reference can be created - thus whenever we encounter a symbol that is
> not extern or toplevel we should create a local object using the
> symbol's name + address as the LLVM identifier.

That's more or less the idea, of course.
And you need to consider all objects that you don't need to
allocate because they are always in a (pseudo-) register.

-- Luc 
