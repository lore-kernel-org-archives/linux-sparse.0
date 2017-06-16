From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] patches for -rc2
Date: Fri, 16 Jun 2017 21:31:11 +0200
Message-ID: <20170616193109.oarg2prwka7q4nxn@ltop.local>
References: <20170615043455.3ke55dyo6v4vpebo@ltop.local>
 <CANeU7QmtKh5LxJVvaFVGy7KApXTtzW+-G19LogbEZH=kTNLHAQ@mail.gmail.com>
 <20170615082050.4ztydiu3d6m4fx2e@ltop.local>
 <CANeU7QmU15CSvknUOT=FSaxLRAv5dnd7g5vXbLbmZKzbHzHLBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35946 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdFPTbQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Jun 2017 15:31:16 -0400
Received: by mail-wm0-f51.google.com with SMTP id m125so34180671wmm.1
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jun 2017 12:31:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QmU15CSvknUOT=FSaxLRAv5dnd7g5vXbLbmZKzbHzHLBg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jun 16, 2017 at 10:08:18AM -0700, Christopher Li wrote:
> On Thu, Jun 15, 2017 at 1:20 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> 
> > Please, drop what you have already pulled and take the
> > following instead.
> 
> I am reviewing the pull request, here is some of the feed back for the memcpy
> patch.

Mmmm. 10 days ago you said for this series:
	"This V2 version of the series looks perfectly fine to me."
 
> For -fmemcpy-max-count and -Wmemcpy-max-count, do we actually need to
> have two separate options here? -fmemcpy-max-count set to zero will disable
> this warning any way.

We don't need to, but what does it cost us to have both?
What it would bring us if we don't?

I'm seeking coherence, here. In sparse, like in gcc or clang,
warnings are enabled and disabled with '-WXXX' and '-Wno-XXX'
options. The other flag is used to tune some settings.
It's all pretty simple  and without surprises. And using '0'
as special value meaning 'unlimited' is pretty common too.

-- Luc
